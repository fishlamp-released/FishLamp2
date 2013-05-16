//
//  GtWebRequestProtocol.h
//  FishLamp
//
//  Created by Mike Fullerton on 1/13/10.
//  Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "GtNetworkRequestProtocol.h"

@protocol GtWebRequestProtocol <GtNetworkRequestProtocol>

- (id) initGetRequestWithUrl:(NSString*) url;

- (id) initPostRequestWithUrl:(NSString*) url 
				   postHeader:(NSString*) postHeader;

- (void) addHeader:(NSString*)headerName 
			  data:(NSString*)data;

- (void) setUtf8Content:(NSString*) content;

- (void) setContentWithData:(NSString*) typeContentHeader 
					content:(NSData*) content;

- (void) setContentWithFilePath:(NSString*) typeContentHeader 
					   filePath:(NSString*) path;


- (void) simpleHttpResponseErrorCheck;

- (void) addHostHeader:(NSString*) host;
- (void) addUserAgentHeader:(NSString*) userAgent;

- (void) addContentLengthHeader:(NSUInteger) length;
- (void) addContentTypeHeader:(NSString*) contentType;

- (void) addDefaultUserAgent;

- (void) addBasicHeaders;

@end

