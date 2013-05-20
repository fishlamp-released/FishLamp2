//
//  NSURLRequest+HTTP.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/19/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef void (^GtMutableURLRequestCallback)(NSMutableURLRequest* request);
typedef void (^GtURLRequestCallback)(NSURLRequest* request);

#define GtHttpConnectionMethodPost @"POST"
#define GtHttpConnectionMethodGet @"GET"

NS_INLINE 
BOOL GtIsHTTPRequestMethod(NSString* method)
{
	return GtStringsAreEqual(GtHttpConnectionMethodPost, method) || GtStringsAreEqual(GtHttpConnectionMethodGet, method);
}

NS_INLINE
BOOL GtIsHTTPPostRequestMethod(NSString* method)
{
	return GtStringsAreEqual(GtHttpConnectionMethodPost, method);
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

