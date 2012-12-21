//
//  FLHttpStream.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/27/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLNetworkStream.h"
#import "FLHttpRequest.h"
#import "FLHttpResponse.h"

#import "FLReadStream.h"
#import "FLObservable.h"
#import "FLDispatcher.h"
#import "FLDispatchQueue.h"

@protocol FLHttpStreamRedirector;

@interface FLHttpStream : FLObservable<FLCancellable, FLReadStreamDelegate> {
@private
    __unsafe_unretained id<FLHttpStreamRedirector> _redirector;
    
    FLFinisher* _finisher;
    FLMutableHttpResponse* _response;
    FLHttpRequest* _request;
    FLReadStream* _httpStream;
    FLDispatchQueue* _dispatchQueue;
}

@property (readwrite, assign) id<FLHttpStreamRedirector> redirector;

+ (id) httpStream;

- (FLResult) sendSynchronousRequest:(FLHttpRequest*) request; 
- (FLFinisher*) sendRequest:(FLHttpRequest*) request;

@end

@protocol FLHttpStreamRedirector<NSObject>
- (void) httpStream:(FLHttpStream*) httpStream shouldRedirect:(BOOL*) redirect toURL:(NSURL*) url;
@end


@protocol FLHttpStreamObserver <NSObject>

- (void) httpStreamWillOpen:(FLHttpStream*) httpStream;

- (void) httpStreamDidOpen:(FLHttpStream*) httpStream;

- (void) httpStream:(FLHttpStream*) httpStream 
   willCloseWithResult:(FLResult) result;

- (void) httpStream:(FLHttpStream*) httpStream 
    didCloseWithResult:(FLResult) result;

- (void) httpStream:(FLHttpStream*) httpStream
      didEncounterError:(NSError*) error;

- (void) httpStreamDidReadBytes:(FLHttpStream*) httpStream;

- (void) httpStreamDidWriteBytes:(FLHttpStream*) httpStream;

@end

