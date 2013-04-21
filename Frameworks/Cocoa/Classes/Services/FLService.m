//
//  FLService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

@interface FLService ()
@property (readwrite, assign, getter=isServiceOpen) BOOL serviceOpen;
@property (readwrite, assign) id superService;
@end

@implementation FLService
@synthesize serviceOpen = _serviceOpen;
@synthesize superService = _superService;
@synthesize subServices = _subServices;
@synthesize delegate = _delegate;

- (id) init {
    return [self initWithDelegate:nil];
}

- (id) initWithDelegate:(id) delegate {
	self = [super init];
	if(self) {
        self.delegate = delegate;
	}
	return self;
}

- (id) initWithRootNameForDelegateMethods:(NSString*) rootName {
    self = [self initWithDelegate:nil];
    if(self) {
        if(rootName) {
            _didOpenDelegateMethod = NSSelectorFromString([NSString stringWithFormat:@"%@DidOpen:", rootName]);
            _didCloseDelegateMethod = NSSelectorFromString([NSString stringWithFormat:@"%@DidClose:", rootName]);
        }
    }
    return self;
}

+ (id) service {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_subServices release];
    [super dealloc];
}
#endif


- (void) setOpen { 
    [self openService];
    self.serviceOpen = YES;
}
- (void) openService {
}

- (void) setClosed {
    [self closeService];
    self.serviceOpen = NO;
}
- (void) closeService {
}

- (void) willOpenService {
}

- (void) didOpenService {
}

- (void) willCloseService {
}

- (void) didCloseService {
}
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) performSelectorOnAllServices:(SEL) selector {
    [self performSelector:selector];
    for(FLService* service in _subServices) {
        [service performSelector:selector];
        [service performSelectorOnAllServices:selector];
    }
}

#pragma GCC diagnostic pop

- (void) openService:(id) opener {
    if(!self.isServiceOpen) {
        [self performSelectorOnAllServices:@selector(willOpenService)];
        [self performSelectorOnAllServices:@selector(setOpen)];
        [self performSelectorOnAllServices:@selector(didOpenService)];
        FLPerformSelector1(self.delegate, _didOpenDelegateMethod, self);
        FLTrace(@"opened %@", NSStringFromClass([self class]));    
    }
}

- (void) closeService:(id) opener {
    if(self.isServiceOpen) {
        [self performSelectorOnAllServices:@selector(willCloseService)];
        [self performSelectorOnAllServices:@selector(setClosed)];
        [self performSelectorOnAllServices:@selector(didCloseService)];
        FLPerformSelector1(self.delegate, _didCloseDelegateMethod, self);
        FLTrace(@"close %@", NSStringFromClass([self class]));    
    }
}

- (void) addSubService:(id) service {
    if(!_subServices) {
        _subServices = [[NSMutableArray alloc] init];
    }
    [_subServices addObject:service];
    
    [service setSuperService:self];
    [service didMoveToSuperService:self];
}

- (void) removeSubService:(id) service {
    [_subServices removeObject:service];

    [service setSuperService:nil];
    [service didMoveToSuperService:nil];
}

- (void) didMoveToSuperService:(id) superService {

}

- (id) rootService {
    id superService = self.superService;
    return superService == nil ? self : [superService rootService];
}

- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor stop:(BOOL*) stop {
    for(id service in _subServices) {
        if(*stop) break;
        visitor(service, stop);
    }
}

- (void) visitSubServices:(void (^)(id service, BOOL* stop)) visitor {
    BOOL stop = NO;
    [self visitSubServices:visitor stop:&stop];
}


@end

void FLAtomicAddServiceToService(__strong id* ivar, FLService* newService, FLService* parentService) {
    FLAtomicPropertySet(ivar, newService, ^{ 
        if(*ivar) {
            [parentService removeSubService:*ivar];
        }
        if(newService) {
            [parentService addSubService:newService];
        }
    });
}


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
//    [_requestHandlers setObject:FLCopyWithAutorelease(handler) forKey:serviceRequestType];
//}
//
//- (FLFinisher*) didReceiveServiceRequest:(FLServiceRequest*) request 
//                              completion:(fl_result_block_t) completion {
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
//- (FLFinisher*) openService:(fl_result_block_t) completion {
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
//- (FLFinisher*) closeService:(fl_result_block_t) completion {
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
//    FLAssertNotNilWithComment(self.context, @"service not in a context");
//    FLAssertWithComment([self.context isContextOpen], @"opening a service in a closed context");
//    _isServiceOpen = YES;
//}
//
//- (void) closeService {
//    FLAssertNotNilWithComment(self.context, @"service not in a context");
//    _isServiceOpen = NO;
//}
//@interface FLService()
//@property (readwrite, assign) FLService* parentService;
//@property (readwrite, assign, getter=isServiceOpen) BOOL serviceOpen;
//@end
//@synthesize parentService = _parentService;
//@synthesize serviceOpen = _serviceOpen;

