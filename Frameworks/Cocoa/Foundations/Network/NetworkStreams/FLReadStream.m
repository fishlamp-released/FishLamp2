//
//  FLReadStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"
#import "FLCoreFoundation.h"
#import "FLTraceOff.h"

@interface FLReadStream ()
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@property (readwrite, assign) BOOL isOpen;
- (NSError*) readStreamError;

@end

#if DEBUG
CFIndex _FLReadStreamRead(CFReadStreamRef stream, UInt8 *buffer, CFIndex bufferLength) {
    memset(buffer, bufferLength, 0); 
    return CFReadStreamRead(stream, buffer, bufferLength); 
}
#define CFReadStreamRead _FLReadStreamRead
#endif

static void ReadStreamClientCallBack(CFReadStreamRef streamRef, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLReadStream* connection = bridge_(FLReadStream*, clientCallBackInfo);
    
    FLConfirmIsNotNil_(connection);
    [connection handleStreamEvent:eventType];
}


@implementation FLReadStream 

@synthesize streamRef = _streamRef;
@synthesize isOpen = _isOpen;
@synthesize delegate = _delegate;

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
    return FLAutorelease([[[self class] alloc] initWithReadStream:streamRef]);
}

- (void) dealloc {
    if(_streamRef) {
        CFReadStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
        FLReleaseCRef_(_streamRef);
    }
    
#if FL_MRC
    [super dealloc];
#endif
}

- (void) handleStreamEvent:(CFStreamEventType) eventType {

//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

//#if TRACE
//    FLDebugLog(@"Read Stream got event %d", eventType);
//#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted: {
            self.isOpen = YES;
            [self.delegate readStreamDidOpen:self];
        }
        break;

        case kCFStreamEventErrorOccurred: {
            [self didEncounterError:[self readStreamError]];
        }
        break;
        
        case kCFStreamEventEndEncountered:{
            [self.delegate readStream:self didCloseWithResult:FLSuccessfullResult];
        }
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable: {
            [self.delegate readStreamHasBytesAvailable:self];
        }
        break;
            
        case kCFStreamEventCanAcceptBytes: {
            FLAssertFailed_v(@"this is a read stream");
            break;
        }
    }
}

- (NSError*) readStreamError {
    return FLAutorelease(bridge_transfer_(NSError*, CFReadStreamCopyError(self.streamRef)));
}

- (void) didEncounterError:(NSError*) error {
    [self.delegate readStream:self didEncounterError:error];
}

- (void) openSelfWithInput:(id) input {
    self.isOpen = NO;
    FLAssertNotNil_(_streamRef);
    
    CFReadStreamOpen(_streamRef);
    CFReadStreamScheduleWithRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
}

- (void) closeSelfWithResult:(id) result {
    FLAssertNotNil_(_streamRef);
    CFReadStreamUnscheduleFromRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
    CFReadStreamClose(_streamRef);
    self.isOpen = NO;
}

- (BOOL) hasBytesAvailable {
    return CFReadStreamHasBytesAvailable(self.streamRef);
}

//- (BOOL) didEncounterError {
//
////    if([self.result error]) {
////        return YES;
////    }
//    
//    if(CFReadStreamGetStatus(self.streamRef) == kCFStreamStatusError) {
//        [self closeStreamWithResult:[self readStreamError]];
//         [self.delegate readStream:self didEncounterError:[self readStreamError]];
//        return YES;
//    }
//    
//    return NO;
//}

- (BOOL) canContinueReading {
    return YES;
}

- (BOOL) readResultIsError:(NSInteger) bytesRead {

    if(bytesRead == 0) {
        // CFReadStreamHasBytesAvailable lied. 
        return YES;
    }

    if(bytesRead < 0) {
        [self didEncounterError:[NSError errorWithDomain:(NSString*) kCFErrorDomainCFNetwork code:kCFURLErrorBadServerResponse localizedDescription:NSLocalizedString(@"Read networkbytes failed: %d", bytesRead)]];
    
        return YES;
    }
    
    return NO;
}

- (void) readAvailableBytesWithByteBuffer:(FLByteBuffer*) buffer {
    FLAssertNotNil_(_streamRef);

    while(!buffer.isFull && [self hasBytesAvailable] && [self canContinueReading]) {
        
        NSInteger bytesRead = CFReadStreamRead(_streamRef, buffer.unusedContent, buffer.unusedContentLength);
        if([self readResultIsError:bytesRead]) {
            break;
        }

        [buffer incrementContentLength:bytesRead];
    }
}

- (NSUInteger) readAvailableBytes:(void*) bytes 
                        maxLength:(NSUInteger) maxLength {
    
    FLAssertNotNil_(_streamRef);
    

#if DEBUG   
    uint8_t* lastBytePtr = bytes + maxLength;
#endif
    uint8_t* readPtr = bytes;
    NSUInteger readTotal = 0;
    while(maxLength > 0 && [self hasBytesAvailable] && [self canContinueReading]) {

#if DEBUG
        FLAssert_v(readPtr + maxLength <= lastBytePtr, @"buffer overrun!!!! Warning warning warning!!!!");
#endif
        NSInteger bytesRead = CFReadStreamRead(_streamRef, readPtr, maxLength);
        if([self readResultIsError:bytesRead]) {
            break;
        }
       
        readPtr += bytesRead;
        maxLength -= bytesRead;
        readTotal += bytesRead;
    }

    return readTotal;
}

#define kBufferSize 1024 

- (NSInteger) readAvailableBytes:(NSMutableData*) data {
    FLAssertNotNil_(_streamRef);
    
    unsigned long bytesRead = 0;
    
    uint8_t buffer[kBufferSize];
        
    while([self hasBytesAvailable] && [self canContinueReading]) {
        bytesRead = CFReadStreamRead(self.streamRef, buffer, kBufferSize);
        if([self readResultIsError:bytesRead]) {
            break;
        }

        [data appendBytes:buffer length:bytesRead];
    }
    
    if(bytesRead > 0) {
        [self.delegate readStream:self didReadBytes:bytesRead];
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

//- (void) readAvailableBytesWithBlock:(void (^)(BOOL* stop)) readblock {
//
//    FLAssertNotNil_(_streamRef);
//
//    if(readblock) {
//        if(!self.reading){
//            @try {
//                self.reading = YES;
//                
//                BOOL stop = NO;
//                while(!stop) {
//                    readblock(&stop);
//                    
////                    FLThrowIfCancelled(self);
//                }
//            }
//            @finally {
//                self.reading = NO;
//            }
//        }
//    }
//}

- (unsigned long) bytesRead {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));

    return [number unsignedLongValue];
}

- (void) requestCancel {
    [self.delegate readStream:self didEncounterError:[NSError cancelError]];
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

//    CFDataRef handle = CFReadStreamCopyProperty(_streamRef, kCFStreamPropertySocketNativeHandle);
////	if(nativeProp == NULL)
////	{
////		if (errPtr) *errPtr = [self getStreamError];
////		return NO;
////	}
//
//
//    if(handle) {
//        dispatch_source_t source = dispatch_source_create(DISPATCH_SOURCE_TYPE_READ, (uintptr_t) handle, 0, self.dispatchQueue.dispatch_queue_t);
//        CFRelease(handle);
//    
//        dispatch_source_set_event_handler(source, ^{
//            FLLog(@"event handler");
//    
////				NSAutoreleasePool *eventPool = [[NSAutoreleasePool alloc] init];
////				
////				LogVerbose(@"event4Block");
////				
////				unsigned long i = 0;
////				unsigned long numPendingConnections = dispatch_source_get_data(acceptSource);
////				
////				LogVerbose(@"numPendingConnections: %lu", numPendingConnections);
////				
////				while ([self doAccept:socketFD] && (++i < numPendingConnections));
////				
////				[eventPool drain];
//			});
//			
//        dispatch_source_set_cancel_handler(source, ^{
//            FLLog(@"cancel handler");
//            
//    //        LogVerbose(@"dispatch_release(accept4Source)");
//    //        dispatch_release(acceptSource);
//    //        
//    //        LogVerbose(@"close(socket4FD)");
//    //        close(socketFD);
//        });
//			
////			LogVerbose(@"dispatch_resume(accept4Source)");
//        dispatch_resume(source);   
//    }