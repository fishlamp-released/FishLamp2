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
     requestMethod:(NSString*) requestMethod {
    
    if((self = [super init])) {
        if(!requestMethod || requestMethod.length == 0) {
            requestMethod = @"GET";
        }   
        
        _message = CFHTTPMessageCreateRequest(kCFAllocatorDefault, 
            FLBridgeToCFRef(requestMethod), FLBridgeToCFRef(url), kCFHTTPVersion1_1);
    }
    return self;
}

- (BOOL) isHeaderComplete {
    return CFHTTPMessageIsHeaderComplete(_message);
}

- (NSData*) bodyData {
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyBody(_message));
}

- (void) setBodyData:(NSData*) bodyData {
    CFHTTPMessageSetBody(_message, FLBridgeToCFRef(bodyData));
}

- (void) setHeader:(NSString*) header value:(NSString*) value {
    CFHTTPMessageSetHeaderFieldValue(_message, FLBridgeToCFRef(header), FLBridgeToCFRef(value));
}

- (NSString*) valueForHeader:(NSString*) header {
    return FLBridgeTransferFromCFRefCopy(
                CFHTTPMessageCopyHeaderFieldValue(_message, FLBridgeToCFRef(header)));
}

- (NSString*) httpVersion {
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyVersion(_message));
}

- (NSDictionary*) allHeaders {
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyAllHeaderFields(_message));
}

- (void) dealloc {
    FLReleaseCFRef(_message);
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
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyRequestURL(_message));
}

- (NSString*) requestMethod {
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyRequestMethod(_message));
}

- (NSInteger) responseStatusCode {
    return CFHTTPMessageGetResponseStatusCode(_message);
}

- (NSString*) responseStatusLine {
    return FLBridgeTransferFromCFRefCopy(CFHTTPMessageCopyResponseStatusLine(_message));
}

- (void) setHeaders:(NSDictionary*) headers {
    for(NSString* header in headers) {
        [self setHeader:header value:[headers objectForKey:header]];
    }
}

@end
