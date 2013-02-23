//
//  FLHttpResponse.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpResponse.h"
#import "FLHttpMessage.h"

@interface FLHttpResponse ()
@property (readwrite, strong, nonatomic) NSDictionary* responseHeaders;
@property (readwrite, assign, nonatomic) NSInteger responseStatusCode;
@property (readwrite, strong, nonatomic) NSString* responseStatusLine;
@property (readwrite, strong, nonatomic) FLHttpResponse* redirectedFrom;
@property (readwrite, strong, nonatomic) NSURL* requestURL;
@property (readwrite, strong, nonatomic) NSMutableData* mutableResponseData;
@end

@implementation FLHttpResponse

@synthesize mutableResponseData = _data;
@synthesize responseStatusCode = _responseStatusCode;
@synthesize responseHeaders = _responseHeaders;
@synthesize responseStatusLine = _responseStatusLine;
@synthesize requestURL = _requestURL;
@synthesize redirectedFrom = _redirectedFrom;
#if DEBUG
@synthesize debugResponseData = _debugResponseData;
#endif

- (NSData*) responseData {
    return self.mutableResponseData;
}

- (id) initWithRequestURL:(NSURL*) url {
    return [self initWithRequestURL:url redirectedFrom:nil];
}

- (id) initWithRequestURL:(NSURL*) url redirectedFrom:(FLHttpResponse*) redirectedFrom {
    if((self = [super init])) {
        _data = [[NSMutableData alloc] init];
        self.requestURL = url;
        self.redirectedFrom = redirectedFrom;
    }
    
    return self;
}

+ (id) httpResponse:(NSURL*) requestURL {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:requestURL redirectedFrom:nil]);
}

+ (id) httpResponse:(NSURL*) requestURL redirectedFrom:(FLHttpResponse*) redirectedFrom {
    return FLAutorelease([[[self class] alloc] initWithRequestURL:requestURL redirectedFrom:redirectedFrom]);
}


#if FL_MRC
- (void) dealloc {
    [_redirectedFrom release];
    [_requestURL release];
    [_responseStatusLine release];
    [_responseHeaders release];
    [_data release];
#if DEBUG
    [_debugResponseData release];
#endif    
    [super dealloc];
}
#endif


+ (id) httpRespose {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSError*) simpleHttpResponseErrorCheck {
	NSInteger statusCode = self.responseStatusCode;
	if(statusCode >= 400) {
	
        NSString* errorString = [NSString stringWithFormat:
			  (NSLocalizedString(@"Server returned error code:%d (%@). Status line: %@",nil)),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode],
                _responseStatusLine == nil ? @"" : _responseStatusLine];

    
	   return [NSError errorWithDomain:[FLFrameworkErrorDomain instance]
                                  code:statusCode
                  localizedDescription:errorString];
	}

	return nil;
}
- (void) throwHttpErrorIfNeeded {
    FLThrowError([self simpleHttpResponseErrorCheck]);
}

- (NSString*) valueForHeader:(NSString*) header {
    return [_responseHeaders objectForKey:header];
}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpResponse* response = [[FLHttpResponse alloc] initWithRequestURL:self.requestURL];
    response.responseHeaders = self.responseHeaders;
    response.responseStatusCode = self.responseStatusCode;
    response.redirectedFrom = self.redirectedFrom;
    response.mutableResponseData = FLAutorelease([self.mutableResponseData mutableCopy]);
    response.responseStatusLine = self.responseStatusLine;
    return response;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    FLHttpResponse* response = [[FLMutableHttpResponse alloc] initWithRequestURL:self.requestURL];
    response.responseHeaders = self.responseHeaders;
    response.responseStatusCode = self.responseStatusCode;
    response.redirectedFrom = self.redirectedFrom;
    response.mutableResponseData = FLAutorelease([self.mutableResponseData mutableCopy]);
    response.responseStatusLine = self.responseStatusLine;
    return response;
}

- (NSString*) description {
//    NSMutableString* string = [self headers]
    
    NSMutableString* desc = [NSMutableString stringWithFormat:@"%@\r\n", [super description]];
    [desc appendFormat:@"request URL:%@\r\n",  [_requestURL description]];
    [desc appendFormat:@"response status line: \"%@\"\r\nresponse code: %d\r\n", _responseStatusLine, (int)_responseStatusCode];
    [desc appendFormat:@"response headers: %@\r\n",  [_responseHeaders description]];
    
#if DEBUG
    if(_debugResponseData) {
        [desc appendFormat:@"response data:\r\n%@\r\n", [_debugResponseData description]];
    }
#endif    

    if(self.redirectedFrom) {
        [desc appendFormat:@"redirected from: %@\r\n", [self.redirectedFrom description]];
    }

    return desc;
}

@end

@implementation FLMutableHttpResponse 

@dynamic mutableResponseData;

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length {

    if(!self.mutableResponseData) {
        self.mutableResponseData = [NSMutableData dataWithCapacity:length];
    }

    [self.mutableResponseData appendBytes:bytes length:length];
}

- (void) appendBytes:(FLByteBuffer*) buffer {
    [self appendBytes:buffer.content length:buffer.length];
}

- (void) setResponseHeadersWithHttpMessage:(FLHttpMessage*) message {
    self.responseHeaders = message.allHeaders;
    self.responseStatusLine = message.responseStatusLine;
    self.responseStatusCode = message.responseStatusCode;
}

@end
