//
//  FLHttpRequestSender.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 2/19/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLHttpRequestSender.h"
#import "FLDispatch.h"

//@interface FLHttpRequest (FLHttpRequestSender)
//- (void) startSendingRequest:(FLFinisher*) observer;
//- (void) requestCancel;
//@end
//
//@interface FLAbstractHttpRequestSender ()
//@property (readwrite, assign, nonatomic) id<FLWorkerContext> workerContext;
//@property (readwrite, strong, nonatomic) FLHttpRequest* httpRequest;
//@end
//
//@implementation FLAbstractHttpRequestSender
//@synthesize workerContext = _workScheduler;
//@synthesize httpRequest = _httpRequest;
//@synthesize observer = _observer;
//
//FLSynthesizeLazyCreateGetter(observer, FLHttpRequestObserver);
//
//- (id) initWithRequest:(FLHttpRequest*) request {
//    self = [super init];
//    if(self) {
//        self.httpRequest = httpRequest;
//    }
//    return self;
//}
//
//+ (id) httpRequestSender:(FLHttpRequest*) httpRequest {
//    return FLAutorelease([[[self class] alloc] initWithRequest:httpRequest]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_httpRequest release];
//    [_observer release];
//    [super dealloc];
//}
//#endif
//
//- (void) requestCancel {
//    [self.httpRequest requestCancel];
//}
//
//@end
//
//@implementation FLHttpRequestSender
//
//- (FLResult) sendRequestInContext:(id<FLWorkerContext>) context {
//    self.workerContext = context;
//    [self sendRequest];
//}
//
//- (FLResult) sendRequest {
//    [self.httpRequest startWorking:self.observer];
//    return [self.observer result];
//}
//
//@end
//
//@implementation FLAsyncHttpRequestSender
//- (void) startWorking:(FLFinisher*) observer {
//    [self.httpRequest startSendingRequest:finisher];
//}
//
//- (FLFinisher*) startSending:(FLBlockWithResult) completion {
//    [[FLGcdDispatcher sharedDefaultQueue] dispatchObject:self withFinisher:self.observer];
//}
//@end


