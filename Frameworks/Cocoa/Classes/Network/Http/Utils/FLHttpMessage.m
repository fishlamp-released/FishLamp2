//
//  FLHttpMessage.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/22/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
     httpMethod:(NSString*) httpMethod {
    
    if((self = [super init])) {
        if(!httpMethod || httpMethod.length == 0) {
            httpMethod = @"GET";
        }   
        
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            bridge_(void*,httpMethod), bridge_(void*,url), kCFHTTPVersion1_1);
            
        FLConfirmNotNil(_message);    
    }
    return self;
}

- (BOOL) isHeaderComplete {
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSData*) bodyData {
    return FLAutorelease(bridge_transfer_(NSData*,CFHTTPMessageCopyBody(_message)));
}

- (void) setBodyData:(NSData*) bodyData {
    CFHTTPMessageSetBody(_message, bridge_(void*,bodyData));
}

- (void) setHeader:(NSString*) header value:(NSString*) value {
    CFHTTPMessageSetHeaderFieldValue(_message, bridge_(void*,header), bridge_(void*,value));
}

- (NSString*) valueForHeader:(NSString*) header {
    return FLAutorelease(bridge_transfer_(NSString*,
                CFHTTPMessageCopyHeaderFieldValue(_message, bridge_(void*,header))));
}

- (NSString*) httpVersion {
    return FLAutorelease(bridge_transfer_(NSString*,CFHTTPMessageCopyVersion(_message)));
}

- (NSDictionary*) allHeaders {
    return FLAutorelease(bridge_transfer_(NSDictionary*,CFHTTPMessageCopyAllHeaderFields(_message)));
}

- (void) dealloc {
    FLReleaseCRef_(_message);
    FLSuperDealloc();
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
    return FLAutorelease([[[self class] alloc] initWithHttpMessageRef:ref]);
}

+ (id) httpMessageWithURL:(NSURL*) url httpMethod:(NSString*) httpMethodOrNil {
    return FLAutorelease([[[self class] alloc] initWithURL:url httpMethod:httpMethodOrNil]);
}

- (id)copyWithZone:(NSZone *)zone {
    CFHTTPMessageRef ref = CFHTTPMessageCreateCopy(kCFAllocatorDefault, _message);
    if(ref) {
        FLHttpMessage* wrapper = [[FLHttpMessage alloc] initWithHttpMessageRef:ref];
        CFRelease(ref);
        return wrapper;
    }
    return nil;
}

- (BOOL) isRequest {
    return CFHTTPMessageIsRequest(_message);
}

- (NSURL*) requestURL {
    return FLAutorelease(bridge_transfer_(NSURL*,CFHTTPMessageCopyRequestURL(_message)));
}

- (NSString*) httpMethod {
    return FLAutorelease(bridge_transfer_(NSString*,CFHTTPMessageCopyRequestMethod(_message)));
}

- (NSInteger) responseStatusCode {
    return CFHTTPMessageGetResponseStatusCode(_message);
}

- (NSString*) responseStatusLine {
    return FLAutorelease(bridge_transfer_(NSString*,CFHTTPMessageCopyResponseStatusLine(_message)));
}

- (void) setHeaders:(NSDictionary*) headers {
    for(NSString* header in headers) {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
