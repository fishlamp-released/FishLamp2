//
//  FLReadStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"

@interface FLReadStream()
@property (readwrite, assign) BOOL reading;
@end

static void ReadStreamClientCallBack(CFReadStreamRef streamRef, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLReadStream* connection = (__bridge_fl FLReadStream*) clientCallBackInfo;
    FLCConfirmIsNotNil_(connection);
    [connection forwardStreamEventToDelegate:eventType];
}

@implementation FLReadStream 
@synthesize streamRef = _streamRef;
@synthesize reading = _reading;

- (id) initWithReadStream:(CFReadStreamRef) streamRef {
    self = [super init];
    if(self) {
        _streamRef = streamRef;
        CFRetain(_streamRef);
        
        if(_streamRef) {
            CFOptionFlags flags =
                    kCFStreamEventOpenCompleted | 
                    kCFStreamEventHasBytesAvailable | 
                    kCFStreamEventEndEncountered | 
                    kCFStreamEventErrorOccurred;

            CFStreamClientContext ctxt = {0, (__bridge_fl void*) self, NULL, NULL, NULL};
            CFReadStreamSetClient(_streamRef, flags, ReadStreamClientCallBack, &ctxt);
        }
    }
    return self;
}

+ (id) readStream:(CFReadStreamRef) streamRef {
    return FLReturnAutoreleased([[[self class] alloc] initWithReadStream:streamRef]);
}

- (void) dealloc {
    if(_streamRef) {
        if(self.isRunning) {
            [self closeStream];
        }

        CFReadStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
        CFRelease(_streamRef);
        _streamRef = nil;
    }
    
#if FL_NO_ARC
    [super dealloc];
#endif
}
- (void) openStream {
    CFReadStreamRef stream = self.streamRef;
    if(stream) {
        [super openStream];
        CFReadStreamScheduleWithRunLoop(stream, self.runLoop, kRunLoopMode);
        CFReadStreamOpen(stream);
    }
}

- (void) closeStream {
    CFReadStreamRef stream = self.streamRef;
    if(stream && self.isRunning) {
        CFReadStreamUnscheduleFromRunLoop(stream, self.runLoop, kRunLoopMode);
        CFReadStreamClose(stream);
        [super closeStream];
    }
    
}

- (NSError*) error {
    CFErrorRef error = nil; // CFWriteStreamCopyError(self.writeStream);
    
#if FL_ARC
    return (__bridge_transfer NSError*) error;
#else 
    return [NSMakeCollectable(error) autorelease];
#endif
}

NS_INLINE
NSInteger CheckReadResult(NSInteger result) {
    if(result <= 0) {
// TODO: this isn't the right error to throw probably.
            FLCThrowErrorCode_v((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
    }
    return result;
}

- (BOOL) hasBytesAvailable {
    return CFReadStreamHasBytesAvailable(self.streamRef);
}

- (void) readAvailableBytesWithByteBuffer:(FLByteBuffer*) buffer {
    FLAssertIsNotNil_(self.streamRef);
    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

    while(!buffer.isFull && CFReadStreamHasBytesAvailable(self.streamRef)) {
        NSInteger result = CheckReadResult(CFReadStreamRead(self.streamRef, buffer.unusedContent, buffer.unusedContentLength));
        [buffer incrementContentLength:result];
    }
}

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {
    
    FLAssertIsNotNil_(self.streamRef);

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

#if DEBUG   
    uint8_t* lastBytePtr = bytes + maxLength;
#endif

    uint8_t* readPtr = bytes;
    NSUInteger readTotal = 0;
    while(maxLength > 0 && CFReadStreamHasBytesAvailable(self.streamRef)) {

#if DEBUG
        FLAssert_v(readPtr + maxLength <= lastBytePtr, @"buffer overrun!!!! Warning warning warning!!!!");
#endif

        NSInteger result = CheckReadResult(CFReadStreamRead(self.streamRef, readPtr, maxLength));
        readPtr += result;
        maxLength -= result;
        readTotal += result;
    }

    return readTotal;
}

- (NSUInteger) appendAvailableBytesToData:(NSMutableData*) data 
                                chunkSize:(NSUInteger) chunkSize {

    NSUInteger amountRead = 0;
    
    while(CFReadStreamHasBytesAvailable(self.streamRef)) {

        NSUInteger prevLength = data.length;
        [data increaseLengthBy:chunkSize];
        
        NSInteger result = CheckReadResult(
                                CFReadStreamRead(   self.streamRef, 
                                                    data.mutableBytes + prevLength, 
                                                    chunkSize));

        [data setLength:prevLength + result];
        amountRead += result;
    }
    
    [self.delegate performIfRespondsToSelector:@selector(readStreamDidReadBytes:) withObject:self];

    return amountRead;
}

- (void) readBytes:(void*) bytes
    numBytesToRead:(NSUInteger) amount  {

    FLAssertFailed_v(@"this is broken");

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertIsNotNil_(self.streamRef);
    
//    NSUInteger amountRead = [self readAvailableBytes:bytes maxLength:amount];
//    if(amountRead == amount) {
//        return;
//    }    
//
//    void* position = bytes + amountRead;
//    
//    // note that this can time out.
//    while(amountRead < amount && [self waitOnceForRunLoop]) {
//        if(CFReadStreamHasBytesAvailable(self.streamRef)) {
//            NSUInteger chunkSize = [self readAvailableBytes:position maxLength:amount - amountRead];
//            position += chunkSize;
//            amountRead += chunkSize;
//        }
//    }
//
//    if(amountRead != amount) {
//        FLThrowCancelException();
//    }
}

- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock {

    FLAssertIsNotNil_(self.streamRef);

    if(readblock) {
        if(!self.reading){
            @try {
                self.reading = YES;
                
                BOOL stop = NO;
                while(!stop && CFReadStreamHasBytesAvailable(_streamRef)) {
                    readblock(&stop);
                }
            }
            @finally {
                self.reading = NO;
            }
        }
    }
}

- (unsigned long) bytesRead {
    CFTypeRef number = CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten);
    unsigned long value = [((__bridge_fl NSNumber*) number) unsignedLongValue];
    CFRelease(number);
    return value;
}

- (id<FLReadStream>) readStream {
    return self;
}

- (id<FLReadStream>) writeStream {
    return nil;
}



@end

// EXPERIMENT(MF)

//- (NSData*) readBytes:(NSUInteger) maxLength {
//
//// TODO: not sure this even makes sense
//
//    NSMutableData* data = [NSMutableData dataWithLength:2048];
//
////    NSInteger amount = 0;
////    while(maxLength > 0 && CFReadStreamHasBytesAvailable(_streamRef))
////    {   
////        CFIndex result = CFReadStreamRead(_streamRef, data.bytes + amount, maxLength);
////        if(result <= 0) 
////        {   
////            FLThrowErrorCode_v((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
////        }
////        
////        maxLength -= amount;
////        amount += result;
////    }
////
////    [self touchTimestamp];
////
////
////
////    uint8_t bytes[512];
////    
////    NSUInteger amount = 0;
////    
////    NSInteger amount = [self readBytes:bytes maxLength:maxLength];
////    
//    return data;
//}

//- (NSData*) readAllAvailableBytes {
//// TODO: not sure this even makes sense
//
//    return nil;
//}

