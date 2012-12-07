//
//  FLWriteStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWriteStream.h"

@interface FLWriteStream ()
@end

static void WriteStreamClientCallBack(CFWriteStreamRef readStream, 
                                      CFStreamEventType eventType, 
                                      void *clientCallBackInfo){
    FLWriteStream* connection = bridge_(FLWriteStream*, clientCallBackInfo);
    FLConfirmIsNotNil_(connection);
    [connection handleStreamEvent:eventType];
}

@implementation FLWriteStream

@synthesize streamRef = _streamRef;

- (id) initWithWriteStream:(CFWriteStreamRef) streamRef {
    
    if(!streamRef) {
        return nil;
    }
    
    self = [super init];
    if(self) {
        CFRetain(streamRef);
        _streamRef = streamRef;
        if(_streamRef) {
            CFOptionFlags flags =
                    kCFStreamEventOpenCompleted | 
                    kCFStreamEventCanAcceptBytes |
                    kCFStreamEventEndEncountered | 
                    kCFStreamEventErrorOccurred;

            CFStreamClientContext ctxt = {0, bridge_(void*,self), NULL, NULL, NULL};
            CFWriteStreamSetClient(_streamRef, flags, WriteStreamClientCallBack, &ctxt);
        }
    }

    return self;
}

+ (id) writeStream:(CFWriteStreamRef) streamRef {
    return FLAutorelease([[[self class] alloc] initWithWriteStream:streamRef]);
}

- (void) dealloc {
    FLAssertNotNil_(_streamRef);

    if(_streamRef) {
        CFWriteStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
        CFRelease(_streamRef);
        _streamRef = nil;
    }
    
#if FL_MRC
    [super dealloc];
#endif    
}

- (void) openStream {
    FLAssertIsNotNil_(_streamRef);

// FIXME
//    CFWriteStreamScheduleWithRunLoop(_streamRef, self.runLoop, bridge_(void*,NSDefaultRunLoopMode));
//    CFWriteStreamOpen(_streamRef);
}

- (void) closeStream  {
    FLAssertIsNotNil_(_streamRef);

// FIXME
//    CFWriteStreamUnscheduleFromRunLoop(_streamRef, self.runLoop, bridge_(void*,NSDefaultRunLoopMode));
//    CFWriteStreamClose(_streamRef);
}

//- (id) result {
//    NSError* error = FLAutorelease(bridge_transfer_(NSError*,CFWriteStreamCopyError(self.streamRef)));
//    if(error) {
//        return error;
//    }
//    
//    return [FLSuccessfullResult successfulResult];
//}

- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length {
    FLAssertIsNotNil_(_streamRef);

    const uint8_t *buffer = bytes;
    while(length > 0) {
        CFIndex amt = CFWriteStreamWrite(_streamRef, buffer, length);
        if(amt <= 0) {   
            FLThrowErrorCode_v((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"writing networkbytes failed: %d", result));
        }
        
        length -= amt;
        buffer += amt;
    }
    
    [self postObservation:@selector(writeStreamDidWriteBytes:)];
}

- (void) sendData:(NSData*) data {
    [self sendBytes:data.bytes length:data.length];
}

- (unsigned long) bytesWritten {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFWriteStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));
    return [number unsignedLongValue];
}



@end
