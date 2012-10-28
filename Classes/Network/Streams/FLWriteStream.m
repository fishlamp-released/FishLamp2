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

@synthesize writeStream = _writeStream;

- (id) initWithWriteStream:(CFWriteStreamRef) writeStream {
    
    FLAssertIsNotNil_(writeStream);
    
    self = [super init];
    if(self) {
        _writeStream = writeStream;
        CFRetain(_writeStream);
        if(_writeStream) {
            CFOptionFlags flags =
                    kCFStreamEventOpenCompleted | 
                    kCFStreamEventCanAcceptBytes |
                    kCFStreamEventEndEncountered | 
                    kCFStreamEventErrorOccurred;

            CFStreamClientContext ctxt = {0, (__bridge_fl void*) self, NULL, NULL, NULL};
            CFWriteStreamSetClient(_writeStream, flags, WriteStreamClientCallBack, &ctxt);
        }
    }

    return self;
}

+ (id) writeStream:(CFWriteStreamRef) writeStream {
    return FLReturnAutoreleased([[[self class] alloc] initWithWriteStream:writeStream]);
}

- (void) dealloc {
    if(_writeStream) {
        if(self.isRunning) {
            [self closeStream];
        }
    
        CFWriteStreamSetClient(_writeStream, kCFStreamEventNone, NULL, NULL);
        CFRelease(_writeStream);
        _writeStream = nil;
    }
    
#if FL_NO_ARC
    [super dealloc];
#endif    
}

- (void) openStream {
    CFWriteStreamRef stream = self.writeStream;
    if(stream) {
        [super openStream];
        CFWriteStreamScheduleWithRunLoop(stream, self.runLoop, kRunLoopMode);
        CFWriteStreamOpen(stream);
    }
}

- (void) closeStream {
    CFWriteStreamRef stream = self.writeStream;
    if(stream && self.isRunning) {
        CFWriteStreamUnscheduleFromRunLoop(stream, self.runLoop, kRunLoopMode);
        CFWriteStreamClose(stream);
        [super closeStream];
    }
}

- (NSError*) error {
    CFErrorRef error = CFWriteStreamCopyError(self.writeStream);
    
#if FL_ARC
    return (__bridge_transfer NSError*) error;
#else 
    return [NSMakeCollectable(error) autorelease];
#endif
}

- (void) sendBytes:(const uint8_t*) bytes length:(unsigned long) length {

    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");
 
    FLAssertIsNotNil_(self.writeStream);

    const uint8_t *buffer = bytes;
    while(length > 0) {
        CFIndex amt = CFWriteStreamWrite( self.writeStream, buffer, length);
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
    CFTypeRef number = CFWriteStreamCopyProperty(self.writeStream, kCFStreamPropertyDataWritten);
    unsigned long value = [((__bridge_fl NSNumber*) number) unsignedLongValue];
    CFRelease(number);
    return value;
}

@end
