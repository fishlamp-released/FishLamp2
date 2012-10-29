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

static void WriteStreamClientCallBack(CFWriteStreamRef readStream, CFStreamEventType eventType, void *clientCallBackInfo) {
    FLWriteStream* connection = (__bridge_fl FLWriteStream*) clientCallBackInfo;
    FLCConfirmIsNotNil_(connection);
    [connection forwardStreamEventToDelegate:eventType];
}

@implementation FLWriteStream

@synthesize streamRef = _streamRef;

- (id) initWithWriteStream:(CFWriteStreamRef) streamRef {
    
    FLAssertIsNotNil_(streamRef);
    
    self = [super init];
    if(self) {
        _streamRef = streamRef;
        CFRetain(_streamRef);
        if(_streamRef) {
            CFOptionFlags flags =
                    kCFStreamEventOpenCompleted | 
                    kCFStreamEventCanAcceptBytes |
                    kCFStreamEventEndEncountered | 
                    kCFStreamEventErrorOccurred;

            CFStreamClientContext ctxt = {0, (__bridge_fl void*) self, NULL, NULL, NULL};
            CFWriteStreamSetClient(_streamRef, flags, WriteStreamClientCallBack, &ctxt);
        }
    }

    return self;
}

+ (id) writeStream:(CFWriteStreamRef) streamRef {
    return FLReturnAutoreleased([[[self class] alloc] initWithWriteStream:streamRef]);
}

- (void) dealloc {
    if(_streamRef) {
        if(self.isRunning) {
            [self closeStream];
        }
    
        CFWriteStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
        CFRelease(_streamRef);
        _streamRef = nil;
    }
    
#if FL_NO_ARC
    [super dealloc];
#endif    
}

- (void) openStream {
    CFWriteStreamRef stream = self.streamRef;
    if(stream) {
        [super openStream];
        CFWriteStreamScheduleWithRunLoop(stream, self.runLoop, kRunLoopMode);
        CFWriteStreamOpen(stream);
    }
}

- (void) closeStream {
    CFWriteStreamRef stream = self.streamRef;
    if(stream && self.isRunning) {
        CFWriteStreamUnscheduleFromRunLoop(stream, self.runLoop, kRunLoopMode);
        CFWriteStreamClose(stream);
        [super closeStream];
    }
}

- (NSError*) error {
    CFErrorRef error = CFWriteStreamCopyError(self.streamRef);
    
#if FL_ARC
    return (__bridge_transfer NSError*) error;
#else 
    return [NSMakeCollectable(error) autorelease];
#endif
}

- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length {

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
 
    FLAssertIsNotNil_(self.streamRef);

    const uint8_t *buffer = bytes;
    while(length > 0) {
        CFIndex amt = CFWriteStreamWrite( self.streamRef, buffer, length);
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
    CFTypeRef number = CFWriteStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten);
    unsigned long value = [((__bridge_fl NSNumber*) number) unsignedLongValue];
    CFRelease(number);
    return value;
}

- (id<FLReadStream>) readStream {
    return nil;
}

- (id<FLWriteStream>) writeStream {
    return self;
}

@end
