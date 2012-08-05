//
//  CFHTTPMessageWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "CFHTTPMessageWrapper.h"

@implementation CFHTTPMessageWrapper

@synthesize messageRef = _message;

- (id) init
{
    if((self = [super init]))
    {
        _message = CFHTTPMessageCreateEmpty( kCFAllocatorDefault, TRUE );
    }

    return self;
}

- (id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod
{
    if((self = [super init]))
    {
        if(!requestMethod || requestMethod.length == 0)
        {
            requestMethod = @"GET";
        }   
        
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            (__fl_bridge CFStringRef)requestMethod, (__fl_bridge CFURLRef)url, kCFHTTPVersion1_1);
    }
    return self;
}

- (BOOL) isHeaderComplete
{
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSData*) bodyData
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSData*)CFHTTPMessageCopyBody(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((__fl_bridge NSData*)CFHTTPMessageCopyBody(_message)));
#endif    
}

- (void) setBodyData:(NSData*) bodyData
{
    CFHTTPMessageSetBody(_message, (__fl_bridge CFDataRef) bodyData);
}

- (void) setHeader:(NSString*) header value:(NSString*) value
{
    CFHTTPMessageSetHeaderFieldValue(_message, (__fl_bridge CFStringRef)header, (__fl_bridge CFStringRef)value);
}

- (NSString*) valueForHeader:(NSString*) header
{

#if OBJC_ARC
    return (__fl_bridge_transfer NSString*)CFHTTPMessageCopyHeaderFieldValue(_message, (__fl_bridge CFStringRef) header);
#else
    return FLAutorelease(NSMakeCollectable((NSString*)CFHTTPMessageCopyHeaderFieldValue(_message, (CFStringRef) header)));
#endif    
}

- (NSString*) httpVersion
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSString *)CFHTTPMessageCopyVersion(_message);
#else
    return FLAutorelease(NSMakeCollectable((NSString *)CFHTTPMessageCopyVersion(_message)));
#endif    
}

- (NSDictionary*) allHeaders
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSDictionary*)CFHTTPMessageCopyAllHeaderFields(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSDictionary*)CFHTTPMessageCopyAllHeaderFields(_message)));
#endif
}

- (void) dealloc
{
    if(_message)
    {
        CFRelease(_message);
        _message = nil;
    }

    FLSuperDealloc();
}

- (id) initWithHttpMessageRef:(CFHTTPMessageRef) ref
{
    if((self = [super init]))
    {
        _message = (CFHTTPMessageRef) CFRetain(ref);
    }
    
    return self;
} 


- (id)copyWithZone:(NSZone *)zone
{
    CFHTTPMessageRef ref = CFHTTPMessageCreateCopy(kCFAllocatorDefault, _message);
    CFHTTPMessageWrapper* wrapper = [[CFHTTPMessageWrapper alloc] initWithHttpMessageRef:ref];
    CFRelease(ref);
    
    return wrapper;
}

- (BOOL) isRequest
{
    return CFHTTPMessageIsRequest(_message);
}

- (NSURL*) requestURL
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSURL*)CFHTTPMessageCopyRequestURL(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSURL*)CFHTTPMessageCopyRequestURL(_message)));
#endif    
}

- (NSString*) requestMethod
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSString*)CFHTTPMessageCopyRequestMethod(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyRequestMethod(_message)));
#endif
}

- (NSInteger) responseStatusCode
{
    return CFHTTPMessageGetResponseStatusCode(_message);
}

- (NSString*) responseStatusLine
{
#if OBJC_ARC
    return (__fl_bridge_transfer NSString*)CFHTTPMessageCopyResponseStatusLine(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyResponseStatusLine(_message)));
#endif
}

- (void) setHeaders:(NSDictionary*) headers
{
    for(NSString* header in headers)
    {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
