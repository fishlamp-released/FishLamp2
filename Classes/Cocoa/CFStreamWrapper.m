//
//  CFStreamWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "CFStreamWrapper.h"

@implementation CFReadStreamWrapper

@synthesize readStreamRef = m_readStream;
@synthesize delegate = m_delegate;

static void ReadStreamClientCallBack(CFReadStreamRef readStream, CFStreamEventType eventType, void *clientCallBackInfo) 
{
    CFReadStreamWrapper* readStreamWrapper = (CFReadStreamWrapper*)clientCallBackInfo;
    GtAssert(readStream == readStreamWrapper.readStreamRef, @"wrong readStream??");
    
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
        m_readStream = (CFReadStreamRef) CFRetain(ref);
    
   		CFStreamClientContext ctxt = {0, self, NULL, NULL, NULL};
        CFReadStreamSetClient(m_readStream, 
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
    if(m_readStream)
    {
        CFReadStreamSetClient(m_readStream, kCFStreamEventNone, NULL, NULL);
		
        CFRelease(m_readStream);
        m_readStream = nil;
    }
    
    GtSuperDealloc();
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
    return GtReturnAutoreleased(NSMakeCollectable((NSError *)CFReadStreamCopyError(self.readStreamRef)));
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
