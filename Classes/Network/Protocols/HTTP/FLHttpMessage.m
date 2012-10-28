//
//  FLHttpMessage.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpMessage.h"

@implementation FLHttpMessage

@synthesize messageRef = _message;

- (id) init {
    if((self = [super init])) {
        _message = CFHTTPMessageCreateEmpty( kCFAllocatorDefault, TRUE );
    }

    return self;
}

- (id) initWithURL:(NSURL*) url
     requestMethod:(NSString*) requestMethod {
    
    if((self = [super init])) {
        if(!requestMethod || requestMethod.length == 0) {
            requestMethod = @"GET";
        }   
        
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            (__bridge_fl CFStringRef)requestMethod, (__bridge_fl CFURLRef)url, kCFHTTPVersion1_1);
    }
    return self;
}

- (BOOL) isHeaderComplete {
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSData*) bodyData {
#if FL_ARC
    return (__bridge_transfer NSData*)CFHTTPMessageCopyBody(_message);
#else
    return [NSMakeCollectable((NSData*)CFHTTPMessageCopyBody(_message)) autorelease];
#endif    
}

- (void) setBodyData:(NSData*) bodyData {
    CFHTTPMessageSetBody(_message, (__bridge_fl CFDataRef) bodyData);
}

- (void) setHeader:(NSString*) header value:(NSString*) value {
    CFHTTPMessageSetHeaderFieldValue(_message, (__bridge_fl CFStringRef)header, (__bridge_fl CFStringRef)value);
}

- (NSString*) valueForHeader:(NSString*) header {
#if FL_ARC
    return (__bridge_transfer NSString*)CFHTTPMessageCopyHeaderFieldValue(_message, (__bridge_fl CFStringRef) header);
#else
    return FLAutorelease(NSMakeCollectable((NSString*)CFHTTPMessageCopyHeaderFieldValue(_message, (CFStringRef) header)));
#endif    
}

- (NSString*) httpVersion {
#if FL_ARC
    return (__bridge_transfer_fl NSString *)CFHTTPMessageCopyVersion(_message);
#else
    return FLAutorelease(NSMakeCollectable((NSString *)CFHTTPMessageCopyVersion(_message)));
#endif    
}

- (NSDictionary*) allHeaders {
#if FL_ARC
    return (__bridge_transfer NSDictionary*)CFHTTPMessageCopyAllHeaderFields(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSDictionary*)CFHTTPMessageCopyAllHeaderFields(_message)));
#endif
}

- (void) dealloc {
    if(_message) {
        CFRelease(_message);
        _message = nil;
    }

    FLSuperDealloc();
}

- (id) initWithHttpMessageRef:(CFHTTPMessageRef) ref {
    if((self = [super init])) {
        _message = (CFHTTPMessageRef) CFRetain(ref);
    }
    
    return self;
} 

+ (id) httpMessageWithHttpMessageRef:(CFHTTPMessageRef) ref {
    return FLReturnAutoreleased([[[self class] alloc] initWithHttpMessageRef:ref]);
}

+ (id) httpMessageWithURL:(NSURL*) url requestMethod:(NSString*) requestMethodOrNil {
    return FLReturnAutoreleased([[[self class] alloc] initWithURL:url requestMethod:requestMethodOrNil]);
}

- (id)copyWithZone:(NSZone *)zone {
    CFHTTPMessageRef ref = CFHTTPMessageCreateCopy(kCFAllocatorDefault, _message);
    FLHttpMessage* wrapper = [[FLHttpMessage alloc] initWithHttpMessageRef:ref];
    CFRelease(ref);
    
    return wrapper;
}

- (BOOL) isRequest {
    return CFHTTPMessageIsRequest(_message);
}

- (NSURL*) requestURL {
#if FL_ARC
    return (__bridge_transfer NSURL*)CFHTTPMessageCopyRequestURL(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSURL*)CFHTTPMessageCopyRequestURL(_message)));
#endif    
}

- (NSString*) requestMethod {
#if FL_ARC
    return (__bridge_transfer NSString*)CFHTTPMessageCopyRequestMethod(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyRequestMethod(_message)));
#endif
}

- (NSInteger) responseStatusCode {
    return CFHTTPMessageGetResponseStatusCode(_message);
}

- (NSString*) responseStatusLine {
#if FL_ARC
    return (__bridge_transfer NSString*)CFHTTPMessageCopyResponseStatusLine(_message);
#else
    return FLReturnAutoreleased(NSMakeCollectable((NSString*)CFHTTPMessageCopyResponseStatusLine(_message)));
#endif
}

- (void) setHeaders:(NSDictionary*) headers {
    for(NSString* header in headers) {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
