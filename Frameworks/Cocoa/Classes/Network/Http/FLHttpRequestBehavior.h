//
//  FLHttpRequestController.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/20/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FishLamp.h"
@class FLHttpRequest;
@class FLHttpResponse;
@class FLHttpRequestByteCount;

@protocol FLHttpRequestBehavior <NSObject, FLPerformer>

- (NSURL*) httpRequestURL;
- (NSString*) httpRequestHttpMethod;

@optional

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) request
        didReadBytes:(FLHttpRequestByteCount*) amount;

- (void) httpRequest:(FLHttpRequest*) request
 didFinishWithResult:(FLPromisedResult) result;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (void) httpRequest:(FLHttpRequest*) httpRequest
     convertResponse:(FLHttpResponse*) httpResponse
            toResult:(FLPromisedResult*) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest
throwErrorIfResponseIsError:(FLHttpResponse*) httpResponse;

/// this returns YES by default.
- (void) httpRequest:(FLHttpRequest*) request
      shouldRedirect:(BOOL*) shouldRedirect
               toURL:(NSURL*) url;

@end

//@interface FLHttpRequestBehavior : NSObject<FLHttpRequestBehavior> {
//@private
//    __unsafe_unretained FLHttpRequest* _httpRequest;
//}
//@property (readwrite, assign, nonatomic) FLHttpRequest* httpRequest;
//
//- (id) initWithRequest:(FLHttpRequest*) request;
//+ (id) httpRequestProtocol:(FLHttpRequest*) request;
//
//@end
