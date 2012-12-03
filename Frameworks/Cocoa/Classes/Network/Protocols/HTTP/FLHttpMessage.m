//
//  FLHttpMessage.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpMessage.h"
#import "FLCoreFoundation.h"

@implementation FLHttpMessage

@synthesize messageRef = _message;

- (id) init {
    if((self = [super init])) {
        _message = CFHTTPMessageCreateEmpty( kCFAllocatorDefault, TRUE );
    }

    return self;
}

- (id) initWithURL:(NSURL*) url
     HTTPMethod:(NSString*) HTTPMethod {
    
    if((self = [super init])) {
        if(!HTTPMethod || HTTPMethod.length == 0) {
            HTTPMethod = @"GET";
        }   
        
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            bridge_(void*,HTTPMethod), bridge_(void*,url), kCFHTTPVersion1_1);
    }
    return self;
}

- (BOOL) isHeaderComplete {
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSData*) bodyData {
    return autorelease_(bridge_transfer_(NSData*,CFHTTPMessageCopyBody(_message)));
}

- (void) setBodyData:(NSData*) bodyData {
    CFHTTPMessageSetBody(_message, bridge_(void*,bodyData));
}

- (void) setHeader:(NSString*) header value:(NSString*) value {
    CFHTTPMessageSetHeaderFieldValue(_message, bridge_(void*,header), bridge_(void*,value));
}

- (NSString*) valueForHeader:(NSString*) header {
    return autorelease_(bridge_transfer_(NSString*,
                CFHTTPMessageCopyHeaderFieldValue(_message, bridge_(void*,header))));
}

- (NSString*) httpVersion {
    return autorelease_(bridge_transfer_(NSString*,CFHTTPMessageCopyVersion(_message)));
}

- (NSDictionary*) allHeaders {
    return autorelease_(bridge_transfer_(NSDictionary*,CFHTTPMessageCopyAllHeaderFields(_message)));
}

- (void) dealloc {
    FLReleaseCRef_(_message);
    super_dealloc_();
}

- (id) initWithHttpMessageRef:(CFHTTPMessageRef) ref {
    if((self = [super init])) {
        if(!ref) {
            return nil;
        }
        _message = (CFHTTPMessageRef) CFRetain(ref);
    }
    
    return self;
} 

+ (id) httpMessageWithHttpMessageRef:(CFHTTPMessageRef) ref {
    return autorelease_([[[self class] alloc] initWithHttpMessageRef:ref]);
}

+ (id) httpMessageWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethodOrNil {
    return autorelease_([[[self class] alloc] initWithURL:url HTTPMethod:HTTPMethodOrNil]);
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
    return autorelease_(bridge_transfer_(NSURL*,CFHTTPMessageCopyRequestURL(_message)));
}

- (NSString*) HTTPMethod {
    return autorelease_(bridge_transfer_(NSString*,CFHTTPMessageCopyRequestMethod(_message)));
}

- (NSInteger) responseStatusCode {
    return CFHTTPMessageGetResponseStatusCode(_message);
}

- (NSString*) responseStatusLine {
    return autorelease_(bridge_transfer_(NSString*,CFHTTPMessageCopyResponseStatusLine(_message)));
}

- (void) setHeaders:(NSDictionary*) headers {
    for(NSString* header in headers) {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
