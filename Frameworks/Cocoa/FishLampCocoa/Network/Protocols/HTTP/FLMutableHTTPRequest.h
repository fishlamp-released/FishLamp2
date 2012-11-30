//
//  FLMutableHTTPRequest.h
//  Downloader
//
//  Created by Mike Fullerton on 11/28/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpRequest.h"

@interface FLMutableHttpRequest : FLHttpRequest {
}

- (id) initWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod;

+ (id) httpRequestWithURL:(NSURL*) url HTTPMethod:(NSString*) HTTPMethod;
+ (id) httpPostRequestWithURL:(NSURL*) url;

@property (readwrite, strong, nonatomic) NSURL* requestURL;

//
// headers
//
@property (readwrite, strong, nonatomic) NSDictionary* allHTTPHeaderFields;
@property (readwrite, strong, nonatomic) NSString* HTTPMethod;
@property (readwrite, assign, nonatomic, getter=isPostRequest) BOOL postRequest;
@property (readwrite, strong, nonatomic) NSString* hostHeader;
@property (readwrite, strong, nonatomic) NSString* userAgentHeader;
@property (readwrite, assign, nonatomic) unsigned long long contentLengthHeader;
@property (readwrite, strong, nonatomic) NSString* contentTypeHeader;

- (void) setValue:(NSString *)value forHTTPHeaderField:(NSString *)field;
- (void) removeHTTPHeaderField:(NSString*) field;

//
// Content
//
@property (readwrite, strong, nonatomic) NSData* HTTPBody;
@property (readwrite, strong, nonatomic) NSInputStream* HTTPBodyStream;
@property (readwrite, strong, nonatomic) NSString* postBodyFilePath;

- (void) setFormUrlEncodedContent:(NSString*) content;
 
- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;

- (void) setUtf8Content:(NSString*) content;

- (void) setJpegContentWithData:(NSData*) imageData;

- (void) setJpegContentWithFilePath:(NSString*) filePath;

@end

@protocol FLHttpRequestAuthenticator <NSObject>
- (FLResult) authenticateHTTPRequest:(FLMutableHttpRequest*) httpRequest;
@end