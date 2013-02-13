//
//  FLHttpUserContext.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLHttp.h"
#import "FLOperation.h"
#import "FLGcdDispatcher.h"
#import "FLHttpRequestAuthenticator.h"
#import "FLAsyncWorkerContext.h"
#import "FLImageCache.h"
#import "FLService.h"

@interface FLHttpUserContext :  FLService {
@private
    FLHttpRequestAuthenticator* _httpRequestAuthenticator;
    FLFifoGcdDispatcher* _asyncDispatcher;
    FLAsyncWorkerContext* _context;
}
@property (readonly, strong) FLServiceManager* serviceManager;

@property (readwrite, strong) FLUserLogin* userLogin;
@property (readonly, assign) BOOL isContextAuthenticated;

@property (readwrite, strong) FLHttpRequestAuthenticator* httpRequestAuthenticator;
@property (readwrite, strong) id<FLDispatcher> asyncDispatcher;

- (void) logoutUser;

//- (FLResult) sendHttpRequestSynchronously:(FLHttpRequest*) request;
//- (FLResult) sendHttpRequestSynchronouslyWithObserver:(FLHttpRequest*) request
//                                             observer:(FLHttpRequestObserver*) observer;
//
//- (FLFinisher*) startHttpRequest:(FLHttpRequest*) request;
//- (FLFinisher*) startHttpRequest:(FLHttpRequest*) request withCompletion:(FLBlockWithResult) completion;
//
//- (void) startHttpRequest:(FLHttpRequest*) request withObserver:(FLHttpRequestObserver*) observer;

@end
