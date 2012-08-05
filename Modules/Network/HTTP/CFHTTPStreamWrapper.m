//
//  CFHTTPStreamWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//
#import "CFHTTPStreamWrapper.h"
#import "CFHTTPMessageWrapper.h"

@implementation CFHTTPStreamWrapper

- (id) initWithStreamedHTTPRequest:(CFHTTPMessageWrapper*) message
    requestBody:(NSInputStream*) requestBody
{
    CFReadStreamRef ref = CFReadStreamCreateForStreamedHTTPRequest(
        kCFAllocatorDefault,
        message.messageRef,
        (__fl_bridge CFReadStreamRef) requestBody);
    
    if((self = [super initWithReadStreamRef:ref]))
    {
    }
    
    CFRelease(ref);

    return self;
}

- (id) initWithHTTPRequest:(CFHTTPMessageWrapper*) message
{
    CFReadStreamRef ref = CFReadStreamCreateForHTTPRequest(
        kCFAllocatorDefault,
        message.messageRef);
    
    if((self = [super initWithReadStreamRef:ref]))
    {
    }

    CFRelease(ref);

    return self;
}

- (void) dealloc
{
    FLSuperDealloc();
}

- (CFHTTPMessageWrapper*) responseHeader
{
    CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(self.readStreamRef, kCFStreamPropertyHTTPResponseHeader);
    CFHTTPMessageWrapper* wrapper = FLReturnAutoreleased([[CFHTTPMessageWrapper alloc] initWithHttpMessageRef:ref]);
    CFRelease(ref);
    
    return wrapper;
}

- (unsigned long long) bytesSent
{
// TODO is this the right bridge?

#if OBJC_ARC
FIXMEF(is this the right bridge?)
    return [((__bridge_transfer NSNumber *)CFReadStreamCopyProperty(self.readStreamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount)) unsignedLongLongValue];
#else
    return [FLReturnAutoreleased(NSMakeCollectable((NSNumber *)CFReadStreamCopyProperty(self.readStreamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount))) unsignedLongLongValue];
#endif    
}			

@end
