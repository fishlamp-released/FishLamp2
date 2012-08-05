//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCocoa.h"

@class CFHTTPStreamWrapper;
@class CFHTTPMessageWrapper;

@interface FLHttpRequest : NSObject<NSCopying> {
@private
    CFHTTPMessageWrapper* _request;

    NSString* _requestMethod;
    NSMutableDictionary* _requestHeaders;
    NSURL* _url;
    NSString* _postBodyFilePath;
    NSData* _postData;
    unsigned long long _postLength;
}

-(id) initWithURL:(NSURL*) url;
-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod;

+ (id) httpRequestWithURL:(NSURL*) url;
+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod;

/** request */
@property (readwrite, retain, nonatomic) NSURL* requestUrl;
@property (readwrite, retain, nonatomic) NSDictionary* requestHeaders;
@property (readwrite, retain, nonatomic) NSString* requestMethod;
@property (readwrite, retain, nonatomic) NSString* postBodyFilePath;
@property (readwrite, retain, nonatomic) NSData* postData;
@property (readonly, assign, nonatomic) unsigned long long postLength;

- (CFHTTPStreamWrapper*) openHttpRequest;
- (void) closeHttpRequest;

- (void) addRequestHeader:(NSString*) headerName value:(NSString*) value;
- (void) appendPostData:(NSData*) data;

/** headers */
- (BOOL) hasHeader:(NSString*) header;
- (void) setHeader:(NSString*)headerName 
			  data:(NSString*)data;

- (NSString*) postHeader;
- (void) setHostHeader:(NSString*) host;

- (void) setContentLengthHeader:(unsigned long long) length;

- (void) setContentTypeHeader:(NSString*) contentType;

- (void) setUserAgentHeader:(NSString*) userAgent;

- (void) setDefaultUserAgentHeader;

/** set content */
- (void) setFormUrlEncodedContent:(NSString*) content;
 
- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;

- (void) setUtf8Content:(NSString*) content;

- (void) setImageContentWithData:(NSData*) imageData;

- (void) setImageContentWithFilePath:(NSString*) filePath;

/** request method */
- (BOOL) isHTTPPostMethod;
- (void) setHTTPMethodToPost;

+ (void) setDefaultUserAgent:(NSString*) userAgent;
+ (NSString*) defaultUserAgent;

@end
