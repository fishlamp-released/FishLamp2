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
    return autorelease_([[[self class] alloc] initWithRequestURL:requestURL redirectedFrom:nil]);
}

+ (id) httpResponse:(NSURL*) requestURL redirectedFrom:(FLHttpResponse*) redirectedFrom {
    return autorelease_([[[self class] alloc] initWithRequestURL:requestURL redirectedFrom:redirectedFrom]);
}

#if FL_MRC
- (void) dealloc  {
    [_redirectedFrom release];
    [_requestURL release];
    release_(_responseStatusLine);
    release_(_responseHeaders);
    release_(_data);
    super_dealloc_();
}
#endif

+ (id) httpRespose {
    return autorelease_([[[self class] alloc] init]);
}

- (NSError*) simpleHttpResponseErrorCheck 
{
	NSInteger statusCode = self.responseStatusCode;
	if(statusCode >= 400)
	{
		NSDictionary *errorInfo
		  = [NSDictionary dictionaryWithObject:[NSString stringWithFormat:
			  (NSLocalizedString(@"Server returned error code:%d (%@). Status line: %@",nil)),
				statusCode,
				[NSHTTPURLResponse localizedStringForStatusCode:statusCode],
                _responseStatusLine == nil ? @"" : _responseStatusLine
				]
				forKey:NSLocalizedDescriptionKey];
	
	   return autorelease_([[NSError alloc] initWithDomain:[FLFrameworkErrorDomain instance]
			code:statusCode
			userInfo:errorInfo]);
	}

	return nil;
}

- (NSString*) valueForHeader:(NSString*) header {
    return [_responseHeaders objectForKey:header];
}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpResponse* response = [[FLHttpResponse alloc] initWithRequestURL:self.requestURL];
    response.responseHeaders = self.responseHeaders;
    response.responseStatusCode = self.responseStatusCode;
    response.redirectedFrom = self.redirectedFrom;
    response.mutableResponseData = autorelease_([self.mutableResponseData mutableCopy]);
    response.responseStatusLine = self.responseStatusLine;
    return response;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    FLHttpResponse* response = [[FLMutableHttpResponse alloc] initWithRequestURL:self.requestURL];
    response.responseHeaders = self.responseHeaders;
    response.responseStatusCode = self.responseStatusCode;
    response.redirectedFrom = self.redirectedFrom;
    response.mutableResponseData = autorelease_([self.mutableResponseData mutableCopy]);
    response.responseStatusLine = self.responseStatusLine;
    return response;
}

- (NSString*) description {
//    NSMutableString* string = [self headers]
    
    NSString* responseStr = autorelease_([[NSString alloc] initWithData:self.responseData encoding:NSUTF8StringEncoding]);
    
    return [NSMutableString stringWithFormat:@"%@ {\n%@\n}", [super description], responseStr];
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
