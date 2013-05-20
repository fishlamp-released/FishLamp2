//
//  GtHttpRequest.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtHttpRequest.h"
#import "CFHTTPStreamWrapper.h"
#import "CFHTTPMessageWrapper.h"

#if IOS
#import <UIKit/UIKit.h>
#endif

static NSString* s_defaultUserAgent = nil;

@interface GtHttpRequest ()
@property (readwrite, assign, nonatomic) unsigned long long postLength;
@end

@implementation GtHttpRequest

@synthesize requestMethod = m_requestMethod;
@synthesize requestUrl = m_url;
@synthesize postBodyFilePath = m_postBodyFilePath;
@synthesize postLength = m_postLength;
@synthesize postData = m_postData;
@synthesize requestHeaders = m_requestHeaders;

+ (void) setDefaultUserAgent:(NSString*) userAgent
{
    GtAssignObject(s_defaultUserAgent, userAgent);
}

- (id) initWithURL:(NSURL*) url 
{
    return [self initWithURL:url requestMethod:nil];
}

-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod
{
    if((self = [super init]))
    {
        m_url = GtRetain(url);
        m_requestMethod = GtRetain(requestMethod);
        m_requestHeaders = [[NSMutableDictionary alloc] init];
        
        [self setDefaultUserAgentHeader];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone
{
    GtHttpRequest* request = [[GtHttpRequest alloc] initWithURL:self.requestUrl requestMethod:self.requestMethod];
    request.requestHeaders = self.requestHeaders;
    request.postData = self.postData;
    request.postBodyFilePath = self.postBodyFilePath;
    return request;
}

+ (id) httpRequestWithURL:(NSURL*) url
{
    return GtReturnAutoreleased([[[self class] alloc] initWithURL:url]);
}

+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod
{
    return GtReturnAutoreleased([[[self class] alloc] initWithURL:url requestMethod:requestMethod]);
}

- (void) dealloc 
{
    GtRelease(m_request);
    GtRelease(m_postData);
    GtRelease(m_requestMethod);
    GtRelease(m_url);
    GtRelease(m_postBodyFilePath);
    GtRelease(m_requestHeaders);
    GtSuperDealloc();
}

- (void) appendPostData:(NSData*) data
{
    GtAssignObject(m_postData, data);
}

- (void) addRequestHeader:(NSString*) headerName value:(NSString*) value
{
    [m_requestHeaders setObject:value forKey:headerName];
}

- (void) finalizeHeaders
{
    if(GtStringIsNotEmpty(self.postBodyFilePath))
    {
        NSError* err = nil;
        self.postLength = [[[NSFileManager defaultManager] attributesOfItemAtPath:self.postBodyFilePath error:&err] fileSize];
        
        if(err)
        {
           GtThrowError(GtReturnAutoreleased(err));
        }
    }
    else if (m_postData)
    {
        m_postLength = m_postData.length;
    }
    
    if(m_postLength> 0)
    {
        if ([self.requestMethod isEqualToString:@"GET"] || 
            [self.requestMethod isEqualToString:@"DELETE"] || 
            [self.requestMethod isEqualToString:@"HEAD"]) 
        {
            self.requestMethod = @"POST";
		}
		[self addRequestHeader:@"Content-Length" value:[NSString stringWithFormat:@"%qu", m_postLength]];
    }
}

- (CFHTTPStreamWrapper*) openHttpRequest
{
    [self finalizeHeaders];
    
    m_request = [[CFHTTPMessageWrapper alloc] initWithURL:self.requestUrl 
                requestMethod:self.requestMethod];

    [m_request setHeaders:self.requestHeaders];
        
    if(GtStringIsNotEmpty(self.postBodyFilePath))
    {
        NSInputStream* inputStream = [NSInputStream inputStreamWithFileAtPath:self.postBodyFilePath];
    
        return GtReturnAutoreleased([[CFHTTPStreamWrapper alloc] initWithStreamedHTTPRequest:m_request requestBody:inputStream]);
    }
    else
    {
        if(self.postData)
        {
            m_request.bodyData = self.postData;
        }
        return GtReturnAutoreleased([[CFHTTPStreamWrapper alloc] initWithHTTPRequest:m_request]);
    }
}

- (void) closeHttpRequest
{
    GtReleaseWithNil(m_request);
}
   
- (BOOL) hasHeader:(NSString*) header
{
    GtAssertIsValidString(header);

	return [m_requestHeaders objectForKey:header] != nil;
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
	return GtStringsAreEqual(self.requestMethod, @"POST");
}

- (void) setUserAgentHeader:(NSString*) userAgent
{
	GtAssertIsValidString(userAgent);

	[self setHeader:@"User-Agent" data:userAgent];
}

- (void) setDefaultUserAgentHeader
{
	[self setUserAgentHeader:[GtHttpRequest defaultUserAgent]];
}

-(void) setHeader:(NSString*)headerName 
             data:(NSString*)data
{
	GtAssertIsValidString(headerName);
    GtAssertNotNil(data);

	[self addRequestHeader:headerName value:data];
}

-(void) setUtf8Content:(NSString*) content
{
    GtAssertNotNil(content);

	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"text/xml; charset=utf-8" ];
}

- (void) setFormUrlEncodedContent:(NSString*) content
{
    GtAssertNotNil(content);
    
	[self setContentWithData:[content dataUsingEncoding:NSUTF8StringEncoding]
           typeContentHeader:@"application/x-www-form-urlencoded" ]; 
}

-(void) setContentTypeHeader:(NSString*) contentType
{
	GtAssertIsValidString(contentType);
    
	[self setHeader:@"Content-Type" data:contentType];
}

-(void) setContentLengthHeader:(unsigned long long) length
{
	NSString* contentLength = [[NSString alloc] initWithFormat:@"%llu", length];
	[self setHeader:@"Content-Length" data:contentLength];
	GtReleaseWithNil(contentLength);
}

- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;
{
    GtAssertNotNil(content);
	GtAssertIsValidString(typeContentHeader);

    [self appendPostData:content];
	[self setContentTypeHeader:typeContentHeader];
	[self setContentLengthHeader:[content length]];
}

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;
{
	GtAssertIsValidString(typeContentHeader);
    GtAssert([[NSFileManager defaultManager] fileExistsAtPath:path], @"File at %@ doesn't exist", path);

	[self setContentTypeHeader:typeContentHeader];
    self.postBodyFilePath = path;
}

- (void) setHostHeader:(NSString*) host
{
	GtAssertIsValidString(host);
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
	GtAssertNotNil(imageData);
	GtAssert(imageData.length > 0, @"Empty data");
	[self setContentWithData:imageData typeContentHeader:@"image/jpeg"];
}
@end
