//
//  FLReadStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"

#if DEBUG
CFIndex _FLReadStreamRead(CFReadStreamRef stream, UInt8 *buffer, CFIndex bufferLength) {
    memset(buffer, bufferLength, 0); 
    return CFReadStreamRead(stream, buffer, bufferLength); 
}
#define CFReadStreamRead _FLReadStreamRead
#endif

@interface FLReadStream()
@property (readwrite, assign) BOOL reading;
@property (readwrite, strong) NSError* error;
@end

static void ReadStreamClientCallBack(CFReadStreamRef streamRef, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLReadStream* connection = bridge_(FLReadStream*, clientCallBackInfo);
    
    FLConfirmIsNotNil_(connection);
    [connection handleStreamEvent:eventType];
}

@implementation FLReadStream 
@synthesize streamRef = _streamRef;
@synthesize reading = _reading;

synthesize_(error)

- (id) initWithReadStream:(CFReadStreamRef) streamRef {
    if(!streamRef) {
        return nil;
    }
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

            CFStreamClientContext ctxt = {0, bridge_(void*, self), NULL, NULL, NULL};
            CFReadStreamSetClient(_streamRef, flags, ReadStreamClientCallBack, &ctxt);
        }
    }
    return self;
}

+ (id) readStream:(CFReadStreamRef) streamRef {
    return autorelease_([[[self class] alloc] initWithReadStream:streamRef]);
}

- (void) dealloc {
    FLAssertIsNotNil_(_streamRef);
    
    CFReadStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
    FLReleaseCRef_(_streamRef);
    
#if FL_MRC
    [_error error];
    [super dealloc];
#endif
}

- (void) networkStreamOpenStream:(id<FLNetworkStream>) stream {
    self.error = nil;
    FLAssertNotNil_(_streamRef);
    CFReadStreamScheduleWithRunLoop(_streamRef, self.runLoop, bridge_(void*,kRunLoopMode));
    CFReadStreamOpen(_streamRef);
}

- (void) networkStreamCloseStream:(id<FLNetworkStream>) stream withError:(NSError*) error {
    FLAssertNotNil_(_streamRef);
    CFReadStreamUnscheduleFromRunLoop(_streamRef, self.runLoop, bridge_(void*,kRunLoopMode));
    CFReadStreamClose(_streamRef);
    self.error = nil;
}

- (NSError*) streamError {
    return autorelease_(bridge_transfer_(NSError*, CFReadStreamCopyError(self.streamRef)));
}

- (BOOL) hasBytesAvailable {
    return CFReadStreamHasBytesAvailable(self.streamRef);
}

- (void) throwReadError:(NSInteger) badResult {
    if(CFReadStreamGetStatus(self.streamRef) == kCFStreamStatusError) {
        FLThrowError_(self.streamError);
    }
    if(self.error) {
        FLThrowError_(self.error);
    }
    if(badResult < 0) {
        FLThrowErrorCode_v((NSString*) kCFErrorDomainCFNetwork, 
                                kCFURLErrorBadServerResponse, 
                                NSLocalizedString(@"Read networkbytes failed: %d", badResult));
    }
}

- (void) readAvailableBytesWithByteBuffer:(FLByteBuffer*) buffer {
    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertNotNil_(_streamRef);

    while(!buffer.isFull && [self hasBytesAvailable]) {
        NSInteger bytesRead = CFReadStreamRead(_streamRef, buffer.unusedContent, buffer.unusedContentLength);
        if(bytesRead > 0) {
            [buffer incrementContentLength:bytesRead];
            continue;
        }
       
        if(bytesRead == 0) {
            // CFReadStreamHasBytesAvailable lied. 
            break;
        }
        
        [self throwReadError:bytesRead];        
    }
}

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {
    
    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertNotNil_(_streamRef);
    

#if DEBUG   
    uint8_t* lastBytePtr = bytes + maxLength;
#endif
    uint8_t* readPtr = bytes;
    NSUInteger readTotal = 0;
    while(maxLength > 0 && [self hasBytesAvailable]) {

//        FLThrowIfCancelled(self);

#if DEBUG
        FLAssert_v(readPtr + maxLength <= lastBytePtr, @"buffer overrun!!!! Warning warning warning!!!!");
#endif
        NSInteger bytesRead = CFReadStreamRead(_streamRef, readPtr, maxLength);
        if(bytesRead > 0) {
            readPtr += bytesRead;
            maxLength -= bytesRead;
            readTotal += bytesRead;
            continue;
        }
       
        if(bytesRead == 0) {
            // CFReadStreamHasBytesAvailable lied. 
            break;
        }
        
        [self throwReadError:bytesRead];
    }

    return readTotal;
}

//- (NSData*) readAvailableBytes {
//
//    NSMutableData* data = [NSMutableData data];
//    return data;
//}

#define kBufferSize 1024 

- (NSInteger) appendBytesToMutableData:(NSMutableData*) data {
    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertNotNil_(_streamRef);
    
    CFIndex bytesRead = 0;
    
    uint8_t buffer[kBufferSize];
        
    while([self hasBytesAvailable]) {

//        FLThrowIfCancelled(self);

        bytesRead = CFReadStreamRead(self.streamRef, buffer, kBufferSize);
        
        if(bytesRead > 0) {
            [data appendBytes:buffer length:bytesRead];
            continue;
        }
        
        if(bytesRead == 0) {
            // CFReadStreamHasBytesAvailable lied. 
            break;
        }
        
        [self throwReadError:bytesRead];
    }
    
    if(bytesRead > 0) {
        FLPerformSelectorWithObject(self.delegate, @selector(readStreamDidReadBytes:), self);
    }

    return bytesRead;
}

//- (NSUInteger) appendAvailableBytesToData:(NSMutableData*) data 
//                                chunkSize:(NSUInteger) chunkSize {
//
//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
//    FLAssertNotNil_(_streamRef);
//    
//    NSUInteger amountRead = 0;
//    while(CFReadStreamHasBytesAvailable(_streamRef)) {
//
//        NSUInteger prevLength = data.length;
//        [data increaseLengthBy:chunkSize];
//        
//        bytesRead = CFReadStreamRead(self.streamRef, data.mutableBytes, chunkSize);
//        if(bytesRead == 0) {
//            break;
//        }
//        
//        if(bytesRead > 0) {
//            [data appendBytes:buffer length:bytesRead];
//            [data setLength:prevLength + result];
//        }
//        if(bytesRead == 0) {
//            break;
//        }
//        
//        if(bytesRead > 0) {
//            [data appendBytes:buffer length:bytesRead];
//        }
//        else {
//             FLCThrowErrorCode_v((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
//        }
//        
//        amountRead += result;
//    }
//    
//    FLPerformSelectorWithObject(self.delegate, @selector(readStreamDidReadBytes:), self);
//
//    return amountRead;
//
//return 0;
//}

- (void) readBytes:(void*) bytes
    numBytesToRead:(NSUInteger) amount  {

FIXME("readbytes");
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

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertNotNil_(_streamRef);

    if(readblock) {
        if(!self.reading){
            @try {
                self.reading = YES;
                
                BOOL stop = NO;
                while(!stop) {
                    readblock(&stop);
                    
//                    FLThrowIfCancelled(self);
                }
            }
            @finally {
                self.reading = NO;
            }
        }
    }
}

- (unsigned long) bytesRead {
    NSNumber* number = autorelease_(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));

    return [number unsignedLongValue];
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

