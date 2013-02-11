//
//  FLHttpRequest.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/23/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLDispatcher.h"
#import "FLReadStream.h"
#import "FLResult.h"
#import "FLHttpResponse.h"
#import "FLHttpRequestBody.h"
#import "FLFinisher.h"
#import "FLDataEncoding.h"
#import "FLDataDecoding.h"

@class FLHttpRequest;
@class FLFinisher;

@protocol FLHttpRequestAuthenticator <NSObject>
// this needs to be synchronous for scheduling reasons amoung concurrent requests.
- (void) authenticateHttpRequest:(FLHttpRequest*) httpRequest;
@end

@protocol FLHttpRequestDispatchingContext <NSObject>
- (id<FLDispatcher>) httpRequestFifoDispatcher:(FLHttpRequest*) request;
- (id<FLHttpRequestAuthenticator>) httpRequestAuthenticator:(FLHttpRequest*) request;
- (void) httpRequestDidStart:(FLHttpRequest*) request;
- (void) httpRequestDidFinish:(FLHttpRequest*) request;
@end

@protocol FLHttpRequestObserver;

@interface FLHttpRequest : NSObject<FLReadStreamDelegate, FLAsyncWorker> {
@private
    FLHttpRequestHeaders* _headers;
    FLHttpRequestBody* _body;
    id _observer;
    FLMutableHttpResponse* _response;
    FLReadStream* _networkStream;
    id _context;
    id<FLDispatcher> _dispatcher;
    BOOL _authenticationDisabled;
    
    id<FLDataEncoding> _dataEncoder;
    id<FLDataDecoding> _dataDecoder;
    
}

@property (readwrite, strong) id<FLDataEncoding> dataEncoder;
@property (readwrite, strong) id<FLDataDecoding> dataDecoder;

@property (readwrite, assign, nonatomic) BOOL authenticationDisabled;

@property (readonly, strong) id context;

// http
@property (readonly, strong, nonatomic) FLHttpRequestHeaders* headers;
@property (readonly, strong, nonatomic) FLHttpRequestBody* body;

- (id) initWithRequestURL:(NSURL*) requestURL;

- (id) initWithRequestURL:(NSURL*) requestURL
               httpMethod:(NSString*) httpMethod; // designated

+ (id) httpRequest:(NSURL*) url 
        httpMethod:(NSString*) httpMethod;

+ (id) httpRequest;

@end

@interface FLHttpRequest () // Sending

// by default the request is run in global FIFO queue (FLFifoDispatchQueue) 
// if the context provides a dispatcher, that one will be used instead.
- (void) requestCancel;

- (FLResult) sendSynchronouslyInContext:(id) context
                         withObserver:(FLFinisher*) observer;

- (FLResult) sendSynchronouslyInContext:(id) context;

- (FLFinisher*) startRequestInContext:(id) context 
                         withObserver:(FLFinisher*) observer;

- (FLFinisher*) startRequestInContext:(id) context;


@end

@interface FLHttpRequest () // optional overrides

- (void) willAuthenticateHttpRequest:(id<FLHttpRequestAuthenticator>) authenticator;
- (void) didAuthenticateHttpRequest;

/// called before the request is started. You may set ALL of the
/// request info here, including the URL
- (void) willSendHttpRequest;

/// did receive the response. If there was an error, this will
/// not be called.
/// if you want to convert the httpRespose.responseData into something
/// else do it here and return it from from your override
- (id) didReceiveHttpResponse:(FLHttpResponse*) httpResponse;

//
// Redirects
//
/// this returns YES by default.
- (BOOL) shouldRedirectToURL:(NSURL*) url;
- (void) didMoveToContext:(id) context;
@end

@protocol FLHttpRequestObserver <NSObject>
@optional

- (void) httpRequestWillAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidAuthenticate:(FLHttpRequest*) httpRequest;

- (void) httpRequestWillOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequestDidOpen:(FLHttpRequest*) httpRequest;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
   willCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest 
    didCloseWithResult:(FLResult) result;

- (void) httpRequest:(FLHttpRequest*) httpRequest
      didEncounterError:(NSError*) error;

- (void) httpRequestDidReadBytes:(FLHttpRequest*) httpRequest amount:(unsigned long) amount;

- (void) httpRequestDidWriteBytes:(FLHttpRequest*) httpRequest amount:(unsigned long) amount;

@end

typedef void (^FLHttpRequestResultBlock)(FLResult result);
typedef void (^FLHttpRequestErrorBlock)(NSError* result);
typedef void (^FLHttpRequestByteBlock)(unsigned long count);

@interface FLHttpRequestObserver : FLFinisher<FLHttpRequestObserver> {
@private
    dispatch_block_t _willAuthenticate;
    dispatch_block_t _didAuthenticate;
    dispatch_block_t _willOpen;
    dispatch_block_t _didOpen;
    FLHttpRequestResultBlock _willClose;
    FLHttpRequestResultBlock _didClose;
    FLHttpRequestErrorBlock _encounteredError;
    FLHttpRequestByteBlock _didWriteBytes;
    FLHttpRequestByteBlock _didReadBytes;
}
+ (id) httpRequestObserver;
@property (readwrite, copy, nonatomic) dispatch_block_t willAuthenticate;
@property (readwrite, copy, nonatomic) dispatch_block_t didAuthenticate;
@property (readwrite, copy, nonatomic) dispatch_block_t willOpen;
@property (readwrite, copy, nonatomic) dispatch_block_t didOpen;
@property (readwrite, copy, nonatomic) FLHttpRequestResultBlock willClose;
@property (readwrite, copy, nonatomic) FLHttpRequestResultBlock didClose;
@property (readwrite, copy, nonatomic) FLHttpRequestErrorBlock encounteredError;
@property (readwrite, copy, nonatomic) FLHttpRequestByteBlock didWriteBytes;
@property (readwrite, copy, nonatomic) FLHttpRequestByteBlock didReadBytes;
@end


