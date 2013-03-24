//
//  FLHttpResponse.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FishLampCore.h"

@class FLHttpMessage;

@interface FLHttpResponse : NSObject {
@private
    NSURL* _requestURL;
    NSInteger _responseStatusCode;
    NSString* _responseStatusLine;
    NSDictionary* _responseHeaders;
    FLHttpResponse* _redirectedFrom;
    NSData* _responseData;
    NSURL* _responseDataFileURL;
}
@property (readonly, strong, nonatomic) NSURL* requestURL;
@property (readonly, strong, nonatomic) NSDictionary* responseHeaders;
@property (readonly, strong, nonatomic) NSString* responseStatusLine;
@property (readonly, strong, nonatomic) FLHttpResponse* redirectedFrom;
@property (readonly, assign, nonatomic) NSInteger responseStatusCode;
@property (readonly, strong, nonatomic) NSData* responseData;
@property (readonly, strong, nonatomic) NSURL* responseDataFileURL;

+ (id) httpResponse:(NSURL*) requestURL 
                   headers:(FLHttpMessage*) headers 
            redirectedFrom:(FLHttpResponse*) redirectedFrom
              responseData:(NSData*) data
responseDataFileURL:(NSURL*) fileURL;

- (NSString*) valueForHeader:(NSString*) header;

/** returns an error for responses >= 400 */
- (NSError*) simpleHttpResponseErrorCheck;
- (void) throwHttpErrorIfNeeded;
@end

@interface FLHttpResponse (Utils)
// http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html
@property (readonly, assign, nonatomic) BOOL wantsRedirect;
@property (readonly, assign, nonatomic) BOOL responseCodeIsRedirect;
- (NSURL*) redirectURL;
@end


//    NSData* _responseData;
//    NSURL* _responseDataFile;
//@property (readonly, strong, nonatomic) NSData* responseData;
//@property (readonly, strong, nonatomic) NSURL* responseURL;
