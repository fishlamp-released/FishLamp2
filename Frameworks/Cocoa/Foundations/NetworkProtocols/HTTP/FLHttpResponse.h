//
//  FLHttpResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLCore.h"
#import "FLByteBuffer.h"

@class FLHttpMessage;

@interface FLHttpResponse : NSObject<NSCopying, NSMutableCopying> {
@private
    NSURL* _requestURL;
    NSInteger _responseStatusCode;
    NSString* _responseStatusLine;
    NSMutableData* _data;
    NSDictionary* _responseHeaders;
    FLHttpResponse* _redirectedFrom;
}

@property (readonly, strong, nonatomic) NSURL* requestURL;
@property (readonly, strong, nonatomic) NSDictionary* responseHeaders;
@property (readonly, strong, nonatomic) NSString* responseStatusLine;
@property (readonly, strong, nonatomic) FLHttpResponse* redirectedFrom;

@property (readonly, assign, nonatomic) NSInteger responseStatusCode;

@property (readonly, strong, nonatomic) NSData* responseData;

+ (id) httpResponse:(NSURL*) requestURL;
+ (id) httpResponse:(NSURL*) requestURL redirectedFrom:(FLHttpResponse*) redirectedFrom;

- (NSString*) valueForHeader:(NSString*) header;

/** returns an error for responses >= 400 */
- (NSError*) simpleHttpResponseErrorCheck;
- (void) throwHttpErrorIfNeeded;

@end

@interface FLMutableHttpResponse : FLHttpResponse {
}
@property (readwrite, strong, nonatomic) NSMutableData* mutableResponseData;

- (void) appendBytes:(const void *)bytes length:(NSUInteger)length;
- (void) appendBytes:(FLByteBuffer*) buffer;
- (void) setResponseHeadersWithHttpMessage:(FLHttpMessage*) message;
@end
