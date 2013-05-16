//
//  GtWebServiceRequest.h
//  FishLamp
//
//  Created By Mike Fullerton on 4/20/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtWebRequestProtocol.h"
#import "GtNetworkRequest.h"

@interface GtWebRequest : GtNetworkRequest<GtWebRequestProtocol> {
@private
	BOOL m_isPostRequest;
	NSString* m_postHeader;
}
@property (readwrite, assign, nonatomic) NSString* postHeader;

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


- (void) addHostHeader:(NSString*) host;
- (void) addUserAgentHeader:(NSString*) userAgent;

- (void) addContentLengthHeader:(NSUInteger) length;
- (void) addContentTypeHeader:(NSString*) contentType;

+ (NSString*) defaultUserAgent;
- (void) addDefaultUserAgent;

- (void) addBasicHeaders;

@end

@interface GtWebRequest (Image)

- (void) addImageContentWithData:(NSData*) imageData;

- (void) addImageContentWithFilePath:(NSString*) filePath;

@end
