//
//  NSURLRequest+HTTP.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

typedef void (^FLMutableURLRequestCallback)(NSMutableURLRequest* request);
typedef void (^FLURLRequestCallback)(NSURLRequest* request);

#define FLHttpConnectionMethodPost @"POST"
#define FLHttpConnectionMethodGet @"GET"

NS_INLINE 
BOOL FLIsHTTPRequestMethod(NSString* method)
{
	return FLStringsAreEqual(FLHttpConnectionMethodPost, method) || FLStringsAreEqual(FLHttpConnectionMethodGet, method);
}

NS_INLINE
BOOL FLIsHTTPPostRequestMethod(NSString* method)
{
	return FLStringsAreEqual(FLHttpConnectionMethodPost, method);
}

@interface NSURLRequest (HTTP)
+ (void) setDefaultUserAgent:(NSString*) userAgent;
+ (NSString*) defaultUserAgent;

- (BOOL) hasHeader:(NSString*) header;
- (NSString*) postHeader;

- (BOOL) isHTTPPostMethod;
@end

@interface NSMutableURLRequest (HTTP)

- (void) setUserAgentHeader:(NSString*) userAgent;
- (void) setDefaultUserAgentHeader;

- (void) setHeader:(NSString*)headerName 
			  data:(NSString*)data;


- (void) setFormUrlEncodedContent:(NSString*) content;


- (void) setHostHeader:(NSString*) host;
- (void) setHTTPMethodToPost;

/**
    set content
 */
 
- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;

- (void) setContentWithInputStream:(NSInputStream*) stream
                 typeContentHeader: (NSString*) typeContentHeader 
                         inputSize:(unsigned long long) size;

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;

- (void) setUtf8Content:(NSString*) content;

- (void) setContentLengthHeader:(unsigned long long) length;
- (void) setContentTypeHeader:(NSString*) contentType;

- (void) setImageContentWithData:(NSData*) imageData;
- (void) setImageContentWithFilePath:(NSString*) filePath;
- (void) setImageContentWithInputStream:(NSInputStream*) stream	 inputSize:(NSUInteger) size;


@end

