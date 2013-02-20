//
//  FLHttpRequestSender.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLHttpRequest.h"
#import "FLExecutionContext.h"

//@interface FLAbstractHttpRequestSender : NSObject {
//@private
//    FLHttpRequest* _httpRequest;
//    FLHttpRequestObserver* _observer;
//    __unsafe_unretained id<FLExecutionContext> _executionContext;
//}
//
//- (id) initWithRequest:(FLHttpRequest*) request;
//+ (id) httpRequestSender:(FLHttpRequest*) request;
//
//- (void) requestCancel;
//
//@property (readonly, assign, nonatomic) id<FLExecutionContext> executionContext;
//@property (readwrite, strong, nonatomic) FLHttpRequestObserver* observer;
//@property (readonly, strong, nonatomic) FLHttpRequest* httpRequest;
//@end
//
//@interface FLHttpRequestSender : FLAbstractHttpRequestSender
//- (FLResult) sendRequest;
//- (FLResult) sendRequestInContext:(id<FLExecutionContext>) context;
//@end
//
//@interface FLAsyncHttpRequestSender : FLAbstractHttpRequestSender<FLAsyncWorker>
//- (FLFinisher*) startSending:(FLBlockWithResult) completion;
//@end

