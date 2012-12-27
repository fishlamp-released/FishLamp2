//
//  FLService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLSession.h"

@interface FLService ()
@property (readwrite, assign) id session;
@end

@implementation FLService

@synthesize session = _session;

- (void) openService:(FLSession*) session {
}

- (void) closeService:(FLSession*) session {
}

- (void) didMoveToSession:(FLSession*) session {
    self.session = session;
}

@end


//
//typedef void (^FLServiceRequestHandler)(id service, FLServiceRequest* serviceRequest, FLFinisher* finisher);
//
//@implementation FLRequestHandlingService
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _requestHandlers = [[NSMutableDictionary alloc] init];
//    }
//    return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_requestHandlers release];
//    [super dealloc];
//}
//#endif
//
//- (void) setRequestHandler:(SEL) selector forServiceRequestType:(id) serviceRequestType {
//
//    FLServiceRequestHandler handler = ^(id service, FLServiceRequest* serviceRequest, FLFinisher* finisher) {
//        FLPerformSelector2(service, selector, serviceRequest, finisher);
//    };
//
//    [_requestHandlers setObject:FLAutoreleasedCopy(handler) forKey:serviceRequestType];
//}
//
//- (FLFinisher*) didReceiveServiceRequest:(FLServiceRequest*) request 
//                              completion:(FLCompletionBlock) completion {
//    
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//
//    FLServiceRequestHandler handler = [_requestHandlers objectForKey:request.requestType];
//    if(handler) {
//        handler(self, request, finisher);
//    }
//    else {
//        [finisher setFinishedWithResult:[NSError serviceRequestNotHandledError:request.serviceID]];
//    }
//    
//    return finisher;
//                              
//}                              
//
//@end
//


//- (void) didMoveToService:(FLService*) parent {
//    self.parentService = parentService;
//}
//
//- (void) serviceWillOpen:(FLFinisher*) finisher {
//
//    [finisher setFinished];
//}
//
//- (void) serviceDidOpenWithResult:(FLResult) result {
//}
//
//- (void) serviceWillClose:(FLFinisher*) finisher {
//
//    [finisher setFinished];
//}
//
//- (void) serviceDidCloseWithResult:(FLResult) result {
//}
//
//- (FLFinisher*) openService:(FLCompletionBlock) completion {
//    
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    
//    FLFinisher* openFinisher = [FLFinisher finisher:^(FLResult result){
//        [self serviceDidOpenWithResult:result];
//        [finisher setFinishedWithResult:result];
//    }];
//    
//    [self serviceWillOpen:openFinisher];
//    
//    return finisher;
//}
//
//- (FLFinisher*) closeService:(FLCompletionBlock) completion {
//
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    
//    FLFinisher* closeFinisher = [FLFinisher finisher:^(FLResult result){
//        [self serviceDidCloseWithResult:result];
//        [finisher setFinishedWithResult:result];
//    }];
//    
//    [self serviceWillClose:openFinisher];
//    
//    return finisher;
//}

//- (void) openService {
//    FLAssertNotNil_v(self.context, @"service not in a context");
//    FLAssert_v([self.context isContextOpen], @"opening a service in a closed context");
//    _isServiceOpen = YES;
//}
//
//- (void) closeService {
//    FLAssertNotNil_v(self.context, @"service not in a context");
//    _isServiceOpen = NO;
//}
//@interface FLService()
//@property (readwrite, assign) FLService* parentService;
//@property (readwrite, assign, getter=isServiceOpen) BOOL serviceOpen;
//@end
//@synthesize parentService = _parentService;
//@synthesize serviceOpen = _serviceOpen;

