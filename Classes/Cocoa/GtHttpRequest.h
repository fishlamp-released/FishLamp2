//
//  GtHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class CFHTTPStreamWrapper;
@class CFHTTPMessageWrapper;

@interface GtHttpRequest : NSObject<NSCopying> {
@private
    CFHTTPMessageWrapper* m_request;

    NSString* m_requestMethod;
    NSMutableDictionary* m_requestHeaders;
    NSURL* m_url;
    NSString* m_postBodyFilePath;
    NSData* m_postData;
    unsigned long long m_postLength;
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
