//
//  CFStreamWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "CFStreamWrapper.h"

@implementation CFReadStreamWrapper

@synthesize readStreamRef = _readStream;
@synthesize delegate = _delegate;

static void ReadStreamClientCallBack(CFReadStreamRef readStream, CFStreamEventType eventType, void *clientCallBackInfo) 
{
    CFReadStreamWrapper* readStreamWrapper = (__fl_bridge CFReadStreamWrapper*)clientCallBackInfo;
    FLCAssert(readStream == readStreamWrapper.readStreamRef, @"wrong readStream??");
    
    if(readStreamWrapper.delegate)
    {
        switch (eventType) 
        {
            case kCFStreamEventHasBytesAvailable:
                [readStreamWrapper.delegate readStreamBytesAvailable:readStreamWrapper];
                break;
                
            case kCFStreamEventEndEncountered:
                [readStreamWrapper.delegate readStreamEndEncountered:readStreamWrapper];
                break;
                
            case kCFStreamEventOpenCompleted:
                [readStreamWrapper.delegate readStreamOpenCompleted:readStreamWrapper];
                break;
                
            case kCFStreamEventErrorOccurred:
                [readStreamWrapper.delegate readStreamErrorOccurred:readStreamWrapper];
                break;

            case kCFStreamEventCanAcceptBytes:
                [readStreamWrapper.delegate readStreamCanAcceptBytes:readStreamWrapper];
                break;
                
            case kCFStreamEventNone:
                break;
        }
    }
}

- (id) initWithReadStreamRef:(CFReadStreamRef) ref
{
    if((self = [super init]))
    {
        _readStream = (CFReadStreamRef) CFRetain(ref);
    
   		CFStreamClientContext ctxt = {0, (__fl_bridge void*) self, NULL, NULL, NULL};
        CFReadStreamSetClient(_readStream, 
            kCFStreamEventOpenCompleted | 
            kCFStreamEventHasBytesAvailable | 
            kCFStreamEventCanAcceptBytes |
            kCFStreamEventEndEncountered | 
            kCFStreamEventErrorOccurred, 
            ReadStreamClientCallBack, &ctxt);
	}

    return self;
}

- (void) dealloc 
{
    if(_readStream)
    {
        CFReadStreamSetClient(_readStream, kCFStreamEventNone, NULL, NULL);
		
        CFRelease(_readStream);
        _readStream = nil;
    }
    
    FLSuperDealloc();
}

- (void)scheduleInRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
    [((NSStream*) self.readStreamRef) scheduleInRunLoop:aRunLoop forMode:mode];
}

- (void)removeFromRunLoop:(NSRunLoop *)aRunLoop forMode:(NSString *)mode
{
    [((NSStream*) self.readStreamRef) removeFromRunLoop:aRunLoop forMode:mode];
}

- (NSError*) error 
{
// TODO: how does the compiler know how to delete this?
#if OBJC_ARC
    return (__fl_bridge NSError*) CFReadStreamCopyError(self.readStreamRef);
#else
    return FLReturnAutoreleased(NSMakeCollectable((__fl_bridge NSError *)CFReadStreamCopyError(self.readStreamRef)));
#endif

}

- (BOOL) hasBytesAvaialable
{
    return CFReadStreamHasBytesAvailable(self.readStreamRef);
}

- (NSInteger)read:(uint8_t *)buffer maxLength:(NSUInteger)len
{
    return CFReadStreamRead(self.readStreamRef, buffer, len);
}

- (BOOL) open
{
    return CFReadStreamOpen(self.readStreamRef);
}

- (void) close
{
    CFReadStreamClose(self.readStreamRef);
}


@end
