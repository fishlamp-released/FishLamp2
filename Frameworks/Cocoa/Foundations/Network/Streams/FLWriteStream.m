//
//  FLWriteStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWriteStream.h"

@interface FLWriteStream ()
@property (readwrite, assign) CFWriteStreamRef streamRef;
@end

static void WriteStreamClientCallBack(CFWriteStreamRef writeStream, 
                                      CFStreamEventType eventType, 
                                      void *clientCallBackInfo) {
    
    [FLNetworkStream handleStreamEvent:eventType withStream:FLBridge(FLWriteStream*, clientCallBackInfo)];
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
    FLAssertNotNil(_streamRef);

    if(_streamRef) {
        CFWriteStreamSetClient(_streamRef, kCFStreamEventNone, NULL, NULL);
        CFRelease(_streamRef);
        _streamRef = nil;
    }
    
#if FL_MRC
    [super dealloc];
#endif    
}

- (void) setStreamRef:(CFWriteStreamRef) streamRef {
    if(streamRef != _streamRef) {
        if(_streamRef) {
            CFRelease(_streamRef);
        }
        
        _streamRef = streamRef;
        
        if(_streamRef) {
            CFRetain(_streamRef);
        }
    }
}

- (NSError*) streamError {
    return FLAutorelease(bridge_transfer_(NSError*,CFWriteStreamCopyError(self.streamRef)));
}

- (void) willOpen {
    [super willOpen];
    
    FLAssertIsNotNil(_streamRef);
    CFWriteStreamScheduleWithRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
    CFWriteStreamOpen(_streamRef);
}

- (void) willClose {
    [super willClose];

    FLAssertIsNotNil(_streamRef);
    CFWriteStreamUnscheduleFromRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
    CFWriteStreamClose(_streamRef);
    [self didClose];
}

- (BOOL) canAcceptBytes {
    return CFWriteStreamCanAcceptBytes(_streamRef);
}

- (void) writeBytes:(const uint8_t*) bytes length:(unsigned long) length {
    FLAssertIsNotNil(_streamRef);

    const uint8_t *buffer = bytes;
    while(length > 0) {
        CFIndex amt = CFWriteStreamWrite(_streamRef, buffer, length);
        if(amt <= 0) {   
            FLThrowErrorCodeWithComment((NSString*) kCFErrorDomainCFNetwork, kCFURLErrorBadServerResponse, NSLocalizedString(@"writing networkbytes failed: %d", result));
        }
        
        length -= amt;
        buffer += amt;
    }
    
    [self sendMessageToListeners:@selector(networkStream:didWriteBytes:) withObject:[NSNumber numberWithUnsignedLong:length]];
}

- (void) writeData:(NSData*) data {
    [self writeBytes:data.bytes length:data.length];
}

- (unsigned long) bytesWritten {
    NSNumber* number = FLAutorelease(bridge_transfer_(NSNumber*,
        CFWriteStreamCopyProperty(self.streamRef, kCFStreamPropertyDataWritten)));
    return [number unsignedLongValue];
}



@end
