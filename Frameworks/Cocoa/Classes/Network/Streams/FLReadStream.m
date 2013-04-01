//
//  FLReadStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLReadStream.h"
#import "FLCoreFoundation.h"

@interface FLReadStream ()
// CFStream
//@property (readwrite, assign, nonatomic) CFReadStreamRef streamRef;
@end

#if DEBUG
CFIndex _FLReadStreamRead(CFReadStreamRef stream, UInt8 *buffer, CFIndex bufferLength) {
    memset(buffer, bufferLength, 0); 
    return CFReadStreamRead(stream, buffer, bufferLength); 
}
#define CFReadStreamRead _FLReadStreamRead
#endif

static void ReadStreamClientCallBack(CFReadStreamRef streamRef, CFStreamEventType eventType, void *clientCallBackInfo) {
    [FLNetworkStream handleStreamEvent:eventType withStream:bridge_(FLReadStream*, clientCallBackInfo)];
}

@implementation FLReadStream

@synthesize streamRef = _streamRef;
@synthesize inputSink = _inputSink;

- (void) dealloc {
    FLAssert(_streamRef == nil);
    
#if FL_MRC  
    [_inputSink release];
    [super dealloc];
#endif
}

- (NSError*) streamError {
    return FLAutorelease(bridge_transfer_(NSError*, CFReadStreamCopyError(self.streamRef)));
}

- (CFReadStreamRef) createReadStreamRef {
    return nil;
}

- (void) willOpen {
    [super willOpen];
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
     
    _streamRef = [self createReadStreamRef];         
         
    FLAssertIsNotNil(_streamRef);

    [self.inputSink openSink];

    CFOptionFlags flags =
            kCFStreamEventOpenCompleted | 
            kCFStreamEventHasBytesAvailable | 
            kCFStreamEventEndEncountered | 
            kCFStreamEventErrorOccurred;

    CFStreamClientContext ctxt = {0, bridge_(void*, self), NULL, NULL, NULL};
    CFReadStreamSetClient(_streamRef, flags, ReadStreamClientCallBack, &ctxt);

    CFReadStreamOpen(_streamRef);
    CFReadStreamScheduleWithRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
}

- (void) willClose {

    FLAssert([NSThread currentThread] != [NSThread mainThread]);

    if(_streamRef) {
        [super willClose];

        [self.inputSink closeSinkWithError:self.error];

        if(!self.error) {
            [self.inputSink commit];
        }

        FLAssertNotNil(_streamRef);
        CFReadStreamClose(_streamRef);
        CFReadStreamUnscheduleFromRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
        CFRelease(_streamRef);
        _streamRef = nil;
        
        [self didClose];
    }
}

- (BOOL) hasBytesAvailable {
    return CFReadStreamHasBytesAvailable(_streamRef) && !self.error;
}

- (void) encounteredBytesAvailable {
    while(self.hasBytesAvailable && !self.error) {
        NSUInteger bytesRead = [self readBytes:_buffer maxLength:FLReadStreamBufferSize];
        if(bytesRead) {
            [self.inputSink appendBytes:_buffer length:bytesRead];
        }
    }
}

- (BOOL) readResultIsError:(NSInteger) bytesRead {

    if(bytesRead == 0) {
        // CFReadStreamHasBytesAvailable lied. 
        return YES;
    }

    if(bytesRead < 0) {
        [self encounteredError:[NSError errorWithDomain:(NSString*) kCFErrorDomainCFNetwork code:kCFURLErrorBadServerResponse localizedDescription:NSLocalizedString(@"Read networkbytes failed: %d", bytesRead)]];
    
        return YES;
    }
    
    return NO;
}

- (NSUInteger) readBytes:(uint8_t*) bytes 
               maxLength:(NSUInteger) maxLength {
   
    FLAssert([NSThread currentThread] != [NSThread mainThread]);
      
    FLAssertNotNil(_streamRef);
    

#if DEBUG   
    uint8_t* lastBytePtr = bytes + maxLength;
#endif
    uint8_t* readPtr = bytes;
    NSUInteger readTotal = 0;
    while(maxLength > 0 && [self hasBytesAvailable]) {

#if DEBUG
        FLAssertWithComment(readPtr + maxLength <= lastBytePtr, @"buffer overrun!!!! Warning warning warning!!!!");
#endif
        NSInteger bytesRead = CFReadStreamRead(_streamRef, readPtr, maxLength);
        if([self readResultIsError:bytesRead]) {
            return 0;
            break;
        }
       
        readPtr += bytesRead;
        maxLength -= bytesRead;
        readTotal += bytesRead;
    }

    if(readTotal > 0) {
        [self sendNotification:@selector(networkStream:didReadBytes:) withObject:self withObject:[NSNumber numberWithUnsignedInteger:readTotal]];
    }

    return readTotal;
}

- (unsigned long) bytesRead {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFReadStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));

    return [number unsignedLongValue];
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
////            FLThrowErrorCodeWithComment((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"Read networkbytes failed: %d", result));
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