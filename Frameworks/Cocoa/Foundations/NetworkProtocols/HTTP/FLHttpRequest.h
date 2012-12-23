//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"

#import "FLHttpRequestContent.h"

#import "FLHttpResponse.h"
#import "FLReadStream.h"
#import "FLObservable.h"
#import "FLDispatcher.h"
#import "FLDispatchQueue.h"


@class FLHttpRequest;
@protocol FLHttpRequestRedirector;

@protocol FLHttpRequestSender <NSObject>
- (FLResult) sendHttpRequest:(FLHttpRequest*) request;
@end

@interface FLHttpRequest : FLObservable<FLCancellable, FLReadStreamDelegate> {
@private
    __unsafe_unretained id<FLHttpRequestRedirector> _redirector;
    
    FLHttpRequestContent* _content;
    
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    FLDispatchQueue* _dispatchQueue;
}

@property (readwrite, assign) id<FLHttpRequestRedirector> redirector;

@property (readonly, strong, nonatomic) FLHttpRequestHeaders* httpHeaders;
@property (readonly, strong, nonatomic) FLHttpRequestContent* httpBody;

- (id) initWithURL:(NSURL*) url;
- (id) initWithURL:(NSURL*) url httpMethod:(NSString*) httpMethod;

+ (id) httpRequestWithURL:(NSURL*) url httpMethod:(NSString*) httpMethod;
+ (id) httpPostRequestWithURL:(NSURL*) url;

+ (id) httpRequest;
+ (id) httpRequestWithURL:(NSURL*) url;

- (FLResult) sendRequest; 

- (FLFinisher*) startRequest;

@end

@protocol FLHttpRequestRedirector<NSObject>
- (void) httpRequest:(FLHttpRequest*) httpRequest 
      shouldRedirect:(BOOL*) redirect 
               toURL:(NSURL*) url;
@end


@protocol FLHttpRequestObserver <NSObject>

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
   willCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error;

- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest;

@end

