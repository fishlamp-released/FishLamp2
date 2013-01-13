//
//  FLWriteStream.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWriteStream.h"

@interface FLWriteStream ()
- (void) handleStreamEvent:(CFStreamEventType) eventType;
@property (readwrite, assign) BOOL isOpen;

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
@synthesize isOpen = _isOpen;
@synthesize delegate = _delegate;

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

- (void) didEncounterError:(NSError*) error {
    [self.delegate writeStream:self didEncounterError:error];
}

- (void) handleStreamEvent:(CFStreamEventType) eventType {

//    FLAssert_v([NSThread currentThread] == self.thread, @"tcp operation on wrong thread");

//#if TRACE
//    FLDebugLog(@"Write Stream got event %d", eventType);
//#endif

    switch (eventType)  {
        case kCFStreamEventOpenCompleted: {
            [self.timeoutTimer touchTimestamp];
            self.isOpen = YES;
            [self.delegate writeStreamDidOpen:self];
        }
        break;

        case kCFStreamEventErrorOccurred: {
            [self.timeoutTimer touchTimestamp];
            NSError* error = FLAutorelease(bridge_transfer_(NSError*,CFWriteStreamCopyError(self.streamRef)));
            [self didEncounterError:error];
        }
        break;
        
        case kCFStreamEventEndEncountered:{
            [self.timeoutTimer touchTimestamp];
            [self.delegate writeStream:self didCloseWithResult:FLSuccessfullResult];
        }
        break;
        
        case kCFStreamEventNone:
            // wtf? why would we get this?
            break;
        
        case kCFStreamEventHasBytesAvailable: {
            FLAssertFailed_v(@"this is a write stream");
        }
        break;
            
        case kCFStreamEventCanAcceptBytes: {
            [self.timeoutTimer touchTimestamp];
            [self.delegate writeStreamCanAcceptBytes:self];
            break;
        }
    }
}

- (void) openSelfWithInput:(id) input {
    FLAssertIsNotNil_(_streamRef);
    self.isOpen = NO;
    CFWriteStreamScheduleWithRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
    CFWriteStreamOpen(_streamRef);
}

- (void) closeSelfWithResult:(id) result {
    FLAssertIsNotNil_(_streamRef);
    CFWriteStreamUnscheduleFromRunLoop(_streamRef, CFRunLoopGetMain(), bridge_(void*,NSDefaultRunLoopMode));
    CFWriteStreamClose(_streamRef);
    self.isOpen = NO;
}



//- (id) result {
//    NSError* error = FLAutorelease(bridge_transfer_(NSError*,CFWriteStreamCopyError(self.streamRef)));
//    if(error) {
//        return error;
//    }
//    
//    return [FLSuccessfullResult successfulResult];
//}

- (BOOL) canAcceptBytes {
    return CFWriteStreamCanAcceptBytes(_streamRef);
}

- (void) writeBytes:(const uint8_t*) bytes length:(unsigned long) length {
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
    
    [self touchTimestamp];
    [self.delegate writeStream:self didWriteBytes:length];
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
