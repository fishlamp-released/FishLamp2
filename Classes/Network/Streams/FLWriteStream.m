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
    FLCConfirmIsNotNil_(connection);
    [connection forwardStreamEventToDelegate:eventType];
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
    return autorelease_([[[self class] alloc] initWithWriteStream:streamRef]);
}

- (void) dealloc {
    FLAssertNotNil_(_streamRef);
    if(self.isRunning) {
        [self closeStream];
    }

    CFWriteStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
    CFRelease(_streamRef);
    _streamRef = nil;
    
#if FL_MRC
    [super dealloc];
#endif    
}

- (void) openStream {
 
    FLAssertIsNotNil_(_streamRef);

    [super openStream];
    CFWriteStreamScheduleWithRunLoop(_streamRef, self.runLoop, bridge_(void*,kRunLoopMode));
    CFWriteStreamOpen(_streamRef);
}

- (void) closeStream {
    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
    FLAssertIsNotNil_(_streamRef);

    if(self.isRunning) {
        CFWriteStreamUnscheduleFromRunLoop(_streamRef, self.runLoop, bridge_(void*,kRunLoopMode));
        CFWriteStreamClose(_streamRef);
        [super closeStream];
    }
}

- (NSError*) error {
    return autorelease_(bridge_transfer_(NSError*,CFWriteStreamCopyError(self.streamRef)));
}

- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length {

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
 
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
    
    [self.delegate performIfRespondsToSelector:@selector(writeStreamDidWriteBytes:) withObject:self];
}

- (void) sendData:(NSData*) data {
    [self sendBytes:data.bytes length:data.length];
}

- (unsigned long) bytesWritten {
    NSNumber* number = autorelease_(bridge_transfer_(NSNumber*,
        CFWriteStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));
    return [number unsignedLongValue];
}

- (id<FLReadStream>) readStream {
    return nil;
}

- (id<FLWriteStream>) writeStream {
    return self;
}

@end
