//
//  FLHttpResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"
#import "FLResponseReceiver.h"

@class FLHttpMessage;

@interface FLHttpResponse : NSObject {
@private
    NSURL* _requestURL;
    NSInteger _responseStatusCode;
    NSString* _responseStatusLine;
    NSDictionary* _responseHeaders;
    id<FLResponseReceiver> _responseReceiver;
    FLHttpResponse* _redirectedFrom;
}
@property (readwrite, strong, nonatomic) id<FLResponseReceiver> responseReceiver;
@property (readonly, strong, nonatomic) NSURL* requestURL;
@property (readonly, strong, nonatomic) NSDictionary* responseHeaders;
@property (readonly, strong, nonatomic) NSString* responseStatusLine;
@property (readonly, strong, nonatomic) FLHttpResponse* redirectedFrom;

@property (readonly, assign, nonatomic) NSInteger responseStatusCode;

+ (id) httpResponse:(NSURL*) requestURL;
+ (id) httpResponse:(NSURL*) requestURL redirectedFrom:(FLHttpResponse*) redirectedFrom;

- (NSString*) valueForHeader:(NSString*) header;

/** returns an error for responses >= 400 */
- (NSError*) simpleHttpResponseErrorCheck;
- (void) throwHttpErrorIfNeeded;

- (void) setResponseHeadersWithHttpMessage:(FLHttpMessage*) message;

// convieience methods

// careful - if this response is a big stream - the whole file will 
// get loaded into the NSData.
@property (readonly, strong, nonatomic) NSData* responseData;

@end

@interface FLHttpResponse (Utils)
// http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
@property (readonly, assign, nonatomic) BOOL wantsRedirect;
@property (readonly, assign, nonatomic) BOOL responseCodeIsRedirect;
- (NSURL*) redirectURL;
@end


