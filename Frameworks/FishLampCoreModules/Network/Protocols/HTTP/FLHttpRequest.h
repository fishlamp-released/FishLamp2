//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLHttpMessage.h"

@interface FLHttpRequest : NSObject<NSCopying> {
@private
    NSString* _requestMethod;
    NSMutableDictionary* _requestHeaders;
    NSURL* _requestURL;
    NSString* _postBodyFilePath;
    NSData* _postData;
    unsigned long long _postLength;
}

-(id) initWithURL:(NSURL*) url;
-(id) initWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod;

+ (id) httpRequest;
+ (id) httpRequestWithURL:(NSURL*) url;
+ (id) httpRequestWithURL:(NSURL*) url requestMethod:(NSString*) requestMethod;

/** URL */
@property (readwrite, strong, nonatomic) NSURL* requestURL;


/** request method */
@property (readwrite, strong, nonatomic) NSString* requestMethod;

@property (readonly, assign) BOOL willPostRequest;

/** headers */
@property (readonly, strong, nonatomic) NSDictionary* requestHeaders;

- (void) setHeaderValue:(NSString*) value forName:(NSString*) headerName;

- (void) removeHeaderForName:(NSString*) headerName;

- (BOOL) hasHeader:(NSString*) header;

- (NSString*) postHeader;
- (void) setHostHeader:(NSString*) host;

- (void) setContentLengthHeader:(unsigned long long) length;

- (void) setContentTypeHeader:(NSString*) contentType;

- (void) setUserAgentHeader:(NSString*) userAgent;

- (void) setDefaultUserAgentHeader;

/** set content */
@property (readonly, strong, nonatomic) NSData* postData;

@property (readonly, assign, nonatomic) unsigned long long postLength;

@property (readonly, strong, nonatomic) NSString* postBodyFilePath;

- (void) setFormUrlEncodedContent:(NSString*) content;
 
- (void) setContentWithData:(NSData*) content
          typeContentHeader:(NSString*) typeContentHeader;

- (void) setContentWithFilePath:(NSString*) path 
              typeContentHeader:(NSString*) typeContentHeader;

- (void) setUtf8Content:(NSString*) content;

- (void) setImageContentWithData:(NSData*) imageData;

- (void) setImageContentWithFilePath:(NSString*) filePath;

/** default user agent */

+ (void) setDefaultUserAgent:(NSString*) userAgent;
+ (NSString*) defaultUserAgent;

@end
