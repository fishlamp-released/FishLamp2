//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpRequest.h"

#if IOS
#import <UIKit/UIKit.h>
#endif

static NSString* s_defaultUserAgent = @"FishLamp3;";

@interface FLHttpRequest ()
@property (readwrite, assign, nonatomic) unsigned long long postLength;
@end

@implementation FLHttpRequest
@synthesize requestMethod = _requestMethod;
@synthesize requestURL = _url;
@synthesize postBodyFilePath = _postBodyFilePath;
@synthesize postLength = _postLength;
@synthesize postData = _postData;
@synthesize requestHeaders = _requestHeaders;

+ (void) setDefaultUserAgent:(NSString*) userAgent {
    FLRetainObject_(s_defaultUserAgent, userAgent);
}

- (id) initWithURL:(NSURL*) url  {
    return [self initWithURL:url requestMethod:nil];
}

-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod {
    if((self = [super init])) {
        _url = retain_(url);
        _requestMethod = retain_(requestMethod);
        _requestHeaders = [[NSMutableDictionary alloc] init];
        
        [self setDefaultUserAgentHeader];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpRequest* request = [[FLHttpRequest alloc] initWithURL:self.requestURL requestMethod:self.requestMethod];
    request.requestHeaders = self.requestHeaders;
    request.postData = self.postData;
    request.postBodyFilePath = self.postBodyFilePath;
    return request;
}

+ (id) httpRequestWithURL:(NSURL*) url {
    return autorelease_([[[self class] alloc] initWithURL:url]);
}

+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod {
    return autorelease_([[[self class] alloc] initWithURL:url requestMethod:requestMethod]);
}

- (void) dealloc  {
    release_(_postData);
    release_(_requestMethod);
    release_(_url);
    release_(_postBodyFilePath);
    release_(_requestHeaders);
    super_dealloc_();
}

- (void) appendPostData:(NSData*) data {
    FLRetainObject_(_postData, data);
}

- (void) addRequestHeader:(NSString*) headerName value:(NSString*) value {
    [_requestHeaders setObject:value forKey:headerName];
}

- (void) finalizeHeaders {
    if(FLStringIsNotEmpty(self.postBodyFilePath))
    {
        NSError* err = nil;
        self.postLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err)
        {
           FLThrowError_(autorelease_(err));
        }
    }
    else if (_postData)
    {
        _postLength = _postData.length;
    }
    
    if(_postLength> 0)
    {
        if ([self.requestMethod isEqualToString:@"GET"] || 
            [self.requestMethod isEqualToString:@"DELETE"] || 
            [self.requestMethod isEqualToString:@"HEAD"]) 
        {
            self.requestMethod = @"POST";
		}
		[self addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%qu", _postLength]];
    }
}

- (BOOL) hasHeader:(NSString*) header {
    FLAssertStringIsNotEmpty_v(header, nil);

	return [_requestHeaders objectForKey:header] != nil;
}

- (NSString*) postHeader {
	return [NSString stringWithFormat:@"%@ HTTP/1.1", self.requestURL.path];
}

+ (NSString*) defaultUserAgent {
    return s_defaultUserAgent;
}   

- (BOOL) isHTTPPostMethod {
	return FLStringsAreEqual(self.requestMethod, @"POST");
}

- (void) setUserAgentHeader:(NSString*) userAgent {
	FLAssertStringIsNotEmpty_v(userAgent, nil);

	[self setHeader:@"User-Agent" data:userAgent];
}

- (void) setDefaultUserAgentHeader {
	[self setUserAgentHeader:[FLHttpRequest defaultUserAgent]];
}

-(void) setHeader:(NSString*)headerName 
             data:(NSString*)data {
	FLAssertStringIsNotEmpty_v(headerName, nil);
    FLAssertIsNotNil_v(data, nil);

	[self addRequestHeader:headerName value:data];
}

-(void) setUtf8Content:(NSString*) content {
    FLAssertIsNotNil_v(content, nil);

	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"text/xml; charset=utf-8" ];
}

- (void) setFormUrlEncodedContent:(NSString*) content {
    FLAssertIsNotNil_v(content, nil);
    
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"application/x-www-form-urlencoded" ]; 
}

-(void) setContentTypeHeader:(NSString*) contentType {
	FLAssertStringIsNotEmpty_v(contentType, nil);
    
	[self setHeader:@"Content-Type" data:contentType];
}

-(void) setContentLengthHeader:(unsigned long long) length {
	NSString* contentLength = [[NSString alloc] initWithFormat:@"%llu", length];
	[self setHeader:@"Content-Length" data:contentLength];
	FLReleaseWithNil_(contentLength);
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader {
    FLAssertIsNotNil_v(content, nil);
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);

    [self appendPostData:content];
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:[content length]];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader {
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);
    FLAssert_v([[NSFileManager defaultManager] fileExistsAtPath:path], @"File at %@ doesn't exist", path);

	[self setContentTypeHeader:typeContentHeader];
    self.postBodyFilePath = path;
}

- (void) setHostHeader:(NSString*) host {
	FLAssertStringIsNotEmpty_v(host, nil);
	[self setHeader:@"HOST" data:host];
}

- (void) setHTTPMethodToPost {
	self.requestMethod = @"POST";
    [self addRequestHeader:@"POST" value:self.postHeader];
}

- (void) setImageContentWithFilePath:(NSString*) filePath {
	[self setContentWithFilePath:filePath typeContentHeader:@"image/jpeg"];
}

- (void) setImageContentWithData:(NSData*) imageData {
	FLAssertIsNotNil_v(imageData, nil);
	FLAssert_v(imageData.length > 0, @"Empty data");
	[self setContentWithData:imageData typeContentHeader:@"image/jpeg"];
}

@end
