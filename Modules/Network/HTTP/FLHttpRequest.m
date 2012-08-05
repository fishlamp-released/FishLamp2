//
//  FLHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHttpRequest.h"
#import "CFHTTPStreamWrapper.h"
#import "CFHTTPMessageWrapper.h"

#if IOS
#import <UIKit/UIKit.h>
#endif

static NSString* s_defaultUserAgent = nil;

@interface FLHttpRequest ()
@property (readwrite, assign, nonatomic) unsigned long long postLength;
@end

@implementation FLHttpRequest

@synthesize requestMethod = _requestMethod;
@synthesize requestUrl = _url;
@synthesize postBodyFilePath = _postBodyFilePath;
@synthesize postLength = _postLength;
@synthesize postData = _postData;
@synthesize requestHeaders = _requestHeaders;

+ (void) setDefaultUserAgent:(NSString*) userAgent
{
    FLAssignObject(s_defaultUserAgent, userAgent);
}

- (id) initWithURL:(NSURL*) url 
{
    return [self initWithURL:url requestMethod:nil];
}

-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod
{
    if((self = [super init]))
    {
        _url = FLReturnRetained(url);
        _requestMethod = FLReturnRetained(requestMethod);
        _requestHeaders = [[NSMutableDictionary alloc] init];
        
        [self setDefaultUserAgentHeader];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    FLHttpRequest* request = [[FLHttpRequest alloc] initWithURL:self.requestUrl requestMethod:self.requestMethod];
    request.requestHeaders = self.requestHeaders;
    request.postData = self.postData;
    request.postBodyFilePath = self.postBodyFilePath;
    return request;
}

+ (id) httpRequestWithURL:(NSURL*) url
{
    return FLReturnAutoreleased([[[self class] alloc] initWithURL:url]);
}

+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod
{
    return FLReturnAutoreleased([[[self class] alloc] initWithURL:url requestMethod:requestMethod]);
}

- (void) dealloc 
{
    FLRelease(_request);
    FLRelease(_postData);
    FLRelease(_requestMethod);
    FLRelease(_url);
    FLRelease(_postBodyFilePath);
    FLRelease(_requestHeaders);
    FLSuperDealloc();
}

- (void) appendPostData:(NSData*) data
{
    FLAssignObject(_postData, data);
}

- (void) addRequestHeader:(NSString*) headerName value:(NSString*) value
{
    [_requestHeaders setObject:value forKey:headerName];
}

- (void) finalizeHeaders
{
    if(FLStringIsNotEmpty(self.postBodyFilePath))
    {
        NSError* err = nil;
        self.postLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err)
        {
           FLThrowError(FLReturnAutoreleased(err));
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

- (CFHTTPStreamWrapper*) openHttpRequest
{
    [self finalizeHeaders];
    
    _request = [[CFHTTPMessageWrapper alloc] initWithURL:self.requestUrl 
                requestMethod:self.requestMethod];

    [_request setHeaders:self.requestHeaders];
        
    if(FLStringIsNotEmpty(self.postBodyFilePath))
    {
        NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:self.postBodyFilePath];
    
        return FLReturnAutoreleased([[CFHTTPStreamWrapper alloc] initWithStreamedHTTPRequest:_request requestBody:inputStream]);
    }
    else
    {
        if(self.postData)
        {
            _request.bodyData = self.postData;
        }
        return FLReturnAutoreleased([[CFHTTPStreamWrapper alloc] initWithHTTPRequest:_request]);
    }
}

- (void) closeHttpRequest
{
    FLReleaseWithNil(_request);
}
   
- (BOOL) hasHeader:(NSString*) header
{
    FLAssertStringIsNotEmpty(header);

	return [_requestHeaders objectForKey:header] != nil;
}

- (NSString*) postHeader
{
	return [NSString stringWithFormat:@"%@ HTTP/1.1", self.requestUrl.path];
}

+ (NSString*) defaultUserAgent
{
    return s_defaultUserAgent;
}   

- (BOOL) isHTTPPostMethod
{
	return FLStringsAreEqual(self.requestMethod, @"POST");
}

- (void) setUserAgentHeader:(NSString*) userAgent
{
	FLAssertStringIsNotEmpty(userAgent);

	[self setHeader:@"User-Agent" data:userAgent];
}

- (void) setDefaultUserAgentHeader
{
	[self setUserAgentHeader:[FLHttpRequest defaultUserAgent]];
}

-(void) setHeader:(NSString*)headerName 
             data:(NSString*)data
{
	FLAssertStringIsNotEmpty(headerName);
    FLAssertIsNotNil(data);

	[self addRequestHeader:headerName value:data];
}

-(void) setUtf8Content:(NSString*) content
{
    FLAssertIsNotNil(content);

	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"text/xml; charset=utf-8" ];
}

- (void) setFormUrlEncodedContent:(NSString*) content
{
    FLAssertIsNotNil(content);
    
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"application/x-www-form-urlencoded" ]; 
}

-(void) setContentTypeHeader:(NSString*) contentType
{
	FLAssertStringIsNotEmpty(contentType);
    
	[self setHeader:@"Content-Type" data:contentType];
}

-(void) setContentLengthHeader:(unsigned long long) length
{
	NSString* contentLength = [[NSString alloc] initWithFormat:@"%llu", length];
	[self setHeader:@"Content-Length" data:contentLength];
	FLReleaseWithNil(contentLength);
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;
{
    FLAssertIsNotNil(content);
	FLAssertStringIsNotEmpty(typeContentHeader);

    [self appendPostData:content];
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:[content length]];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;
{
	FLAssertStringIsNotEmpty(typeContentHeader);
    FLAssert([[NSFileManager defaultManager] fileExistsAtPath:path], @"File at %@ doesn't exist", path);

	[self setContentTypeHeader:typeContentHeader];
    self.postBodyFilePath = path;
}

- (void) setHostHeader:(NSString*) host
{
	FLAssertStringIsNotEmpty(host);
	[self setHeader:@"HOST" data:host];
}

- (void) setHTTPMethodToPost
{
	self.requestMethod = @"POST";
    [self addRequestHeader:@"POST" value:self.postHeader];
}

- (void) setImageContentWithFilePath:(NSString*) filePath
{
	[self setContentWithFilePath:filePath typeContentHeader:@"image/jpeg"];
}

- (void) setImageContentWithData:(NSData*) imageData
{
	FLAssertIsNotNil(imageData);
	FLAssert(imageData.length > 0, @"Empty data");
	[self setContentWithData:imageData typeContentHeader:@"image/jpeg"];
}
@end
