//
//  FLHttpUserService.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/12/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLHttp.h"
#import "FLOperation.h"
#import "FLGcdDispatcher.h"
#import "FLHttpRequestAuthenticationService.h"
#import "FLExecutionContext.h"
#import "FLImageStoreService.h"
#import "FLService.h"

@interface FLHttpUserService :  FLService {
@private
    FLHttpRequestAuthenticationService* _httpRequestAuthenticator;
    FLFifoGcdDispatcher* _asyncDispatcher;
    FLExecutionContext* _context;
}

@property (readwrite, strong) FLUserLogin* userLogin;
@property (readonly, assign) BOOL isContextAuthenticated;

@property (readwrite, strong) FLHttpRequestAuthenticationService* httpRequestAuthenticator;
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
