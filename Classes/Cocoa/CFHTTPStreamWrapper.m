//
//  CFHTTPStreamWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
        (CFReadStreamRef) requestBody);
    
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
    GtSuperDealloc();
}

- (CFHTTPMessageWrapper*) responseHeader
{
    CFHTTPMessageRef ref = (CFHTTPMessageRef)CFReadStreamCopyProperty(self.readStreamRef, kCFStreamPropertyHTTPResponseHeader);
    CFHTTPMessageWrapper* wrapper = GtReturnAutoreleased([[CFHTTPMessageWrapper alloc] initWithHttpMessageRef:ref]);
    CFRelease(ref);
    
    return wrapper;
}

- (unsigned long long) bytesSent
{
    return [GtReturnAutoreleased(NSMakeCollectable((NSNumber *)CFReadStreamCopyProperty(self.readStreamRef, kCFStreamPropertyHTTPRequestBytesWrittenCount))) unsignedLongLongValue];
}			

@end
