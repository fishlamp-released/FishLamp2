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
@property (readwrite, strong, nonatomic) NSDictionary* requestHeaders;
@property (readwrite, strong, nonatomic) NSData* postData;
@property (readwrite, strong, nonatomic) NSString* postBodyFilePath;
@end

@implementation FLHttpRequest
synthesize_(requestMethod);
synthesize_(requestURL);
synthesize_(postBodyFilePath);
synthesize_(postLength);
synthesize_(postData);
synthesize_(requestHeaders);

- (void) dealloc  {
    release_(_postData);
    release_(_requestMethod);
    release_(_requestURL);
    release_(_postBodyFilePath);
    release_(_requestHeaders);
    super_dealloc_();
}

+ (void) setDefaultUserAgent:(NSString*) userAgent {
    FLRetainObject_(s_defaultUserAgent, userAgent);
}

- (id) initWithURL:(NSURL*) url  {
    return [self initWithURL:url requestMethod:nil];
}

-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod {
    if((self = [super init])) {
        self.requestURL = url;
        self.requestMethod = requestMethod;
        _requestHeaders = [[NSMutableDictionary alloc] init];
       
        if(FLStringIsEmpty(self.requestMethod)) {
            self.requestMethod = @"GET";
        }
        [self setDefaultUserAgentHeader];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    FLHttpRequest* request = [[FLHttpRequest alloc] initWithURL:self.requestURL requestMethod:self.requestMethod];
    request.requestHeaders = self.requestHeaders;
    request.postData = autorelease_([self.postData copy]);
    request.postBodyFilePath = self.postBodyFilePath;
    request.requestMethod = self.requestMethod;
    return request;
}

+ (id) httpRequestWithURL:(NSURL*) url {
    return autorelease_([[[self class] alloc] initWithURL:url requestMethod:@"GET"]);
}

+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod {
    return autorelease_([[[self class] alloc] initWithURL:url requestMethod:requestMethod]);
}

+ (id) httpRequest {
    return [self create];
}


- (void) setHeaderValue:(NSString*) value forName:(NSString*) headerName {
	FLAssertStringIsNotEmpty_v(headerName, nil);
    FLAssertIsNotNil_v(value, nil);

    [_requestHeaders setObject:value forKey:headerName];
}

- (void) removeHeaderForName:(NSString*) headerName {
    [_requestHeaders removeObjectForKey:self.postHeader];
}

- (void) setRequestMethod:(NSString *)requestMethod {
    FLRetainObject_(_requestMethod, requestMethod);
    
    if(self.willPostRequest) {
        [self setHeaderValue:self.postHeader forName:@"POST"];
        [self setHeaderValue:[NSString stringWithFormat:@"%qu", _postLength] forName:@"Content-Length"];
    }
    else {
        [self removeHeaderForName:@"POST"];
        [self removeHeaderForName:@"Content-Length"];
    }
}

- (void) setPostData:(NSData*) data {
    _postLength = 0;
    FLReleaseWithNil_(_postBodyFilePath);
    FLRetainObject_(_postData, data);
    if (_postData) {
        _postLength = _postData.length;
        self.requestMethod = @"POST";
	}
}

- (void) setPostBodyFilePath:(NSString*) path {
    _postLength = 0;
    FLReleaseWithNil_(_postData);
    
    FLRetainObject_(_postBodyFilePath, path);
    if(FLStringIsNotEmpty(_postBodyFilePath)) {
        NSError* err = nil;
        self.postLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err) {
           FLThrowError_(autorelease_(err));
        }
        self.requestMethod = @"POST";
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

- (BOOL) willPostRequest {
	return FLStringsAreEqualCaseInsensitive(self.requestMethod, @"POST");
}

- (void) setUserAgentHeader:(NSString*) userAgent {
	[self setHeaderValue:userAgent forName:@"User-Agent"];
}

- (void) setDefaultUserAgentHeader {
	[self setUserAgentHeader:[FLHttpRequest defaultUserAgent]];
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
    
	[self setHeaderValue:contentType forName:@"Content-Type"];
}

-(void) setContentLengthHeader:(unsigned long long) length {
	[self setHeaderValue:[NSString stringWithFormat:@"%llu", length] forName:@"Content-Length"];
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader {
    FLAssertIsNotNil_v(content, nil);
	FLAssertStringIsNotEmpty_v(typeContentHeader, nil);

    self.postData = content;
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
	[self setHeaderValue:host forName:@"HOST"];
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
