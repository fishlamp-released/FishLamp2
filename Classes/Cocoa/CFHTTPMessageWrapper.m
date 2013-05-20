//
//  CFHTTPMessageWrapper.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "CFHTTPMessageWrapper.h"

@implementation CFHTTPMessageWrapper

@synthesize messageRef = m_message;

- (id) init
{
    if((self = [super init]))
    {
        m_message = CFHTTPMessageCreateEmpty( kCFAllocatorDefault, TRUE );
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
        
        m_message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            (CFStringRef)requestMethod, (CFURLRef)url, kCFHTTPVersion1_1);
    }
    return self;
}

- (BOOL) isHeaderComplete
{
    return CFHTTPMessageIsHeaderComplete(m_message);
}

- (NSData*) bodyData
{
    return GtAutorelease(NSMakeCollectable((NSData*)CFHTTPMessageCopyBody(m_message)));
}

- (void) setBodyData:(NSData*) bodyData
{
    CFHTTPMessageSetBody(m_message, (CFDataRef) bodyData);
}

- (void) setHeader:(NSString*) header value:(NSString*) value
{
    CFHTTPMessageSetHeaderFieldValue(m_message, (CFStringRef)header, (CFStringRef)value);
}

- (NSString*) valueForHeader:(NSString*) header
{
    return GtAutorelease(NSMakeCollectable((NSString*)CFHTTPMessageCopyHeaderFieldValue(m_message, (CFStringRef) header)));
}

- (NSString*) httpVersion
{
    return GtAutorelease(NSMakeCollectable((NSString *)CFHTTPMessageCopyVersion(m_message)));
}

- (NSDictionary*) allHeaders
{
    return GtReturnAutoreleased(NSMakeCollectable((NSDictionary*)CFHTTPMessageCopyAllHeaderFields(m_message)));
}

- (void) dealloc
{
    if(m_message)
    {
        CFRelease(m_message);
        m_message = nil;
    }

    GtSuperDealloc();
}

- (id) initWithHttpMessageRef:(CFHTTPMessageRef) ref
{
    if((self = [super init]))
    {
        m_message = (CFHTTPMessageRef) CFRetain(ref);
    }
    
    return self;
} 


- (id)copyWithZone:(NSZone *)zone
{
    CFHTTPMessageRef ref = CFHTTPMessageCreateCopy(kCFAllocatorDefault, m_message);
    CFHTTPMessageWrapper* wrapper = [[CFHTTPMessageWrapper alloc] initWithHttpMessageRef:ref];
    CFRelease(ref);
    
    return wrapper;
}

- (BOOL) isRequest
{
    return CFHTTPMessageIsRequest(m_message);
}

- (NSURL*) requestURL
{
    return GtReturnAutoreleased(NSMakeCollectable((NSURL*)CFHTTPMessageCopyRequestURL(m_message)));
}

- (NSString*) requestMethod
{
    return GtReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyRequestMethod(m_message)));
}

- (NSInteger) responseStatusCode
{
    return CFHTTPMessageGetResponseStatusCode(m_message);
}

- (NSString*) responseStatusLine
{
    return GtReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyResponseStatusLine(m_message)));
}

- (void) setHeaders:(NSDictionary*) headers
{
    for(NSString* header in headers)
    {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
