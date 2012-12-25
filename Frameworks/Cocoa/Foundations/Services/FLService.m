//
//  FLService.m
//  FLCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"

typedef void (^FLServiceRequestHandler)(id service, FLServiceRequest* serviceRequest, FLFinisher* finisher);

@implementation FLServiceGroup

- (id) init {
    self = [super init];
    if(self) {
        _services = [[NSMutableDictionary alloc] init];
    }
    
    return self;
}

+ (id) serviceGroup {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_services release];
    [super dealloc];
}
#endif

- (id) serviceForServiceType:(id) serviceType {
    FLAssertNotNil_(serviceType);
    return [_services objectForKey:serviceType];
} 

- (void) removeServiceForServiceType:(id) serviceType {

    FLAssertNotNil_(serviceType);

    id service = [self serviceForServiceType:serviceType];
    if(service) {
        [_services removeObjectForKey:serviceType];
        FLPerformSelector1(service, @selector(didMoveToServiceGroup:), nil);
    }
}

- (void) setService:(id) service forServiceType:(id) serviceType {

    FLAssertNotNil_(serviceType);
    FLAssertNotNil_(service);
    
    FLConfirm_v([_services objectForKey:serviceType] == nil, @"service type already registered: %@", serviceType);
    
    [_services setObject:service forKey:serviceType];
    
    FLPerformSelector1(service, @selector(didMoveToServiceGroup:), self);
}

- (BOOL) canServiceRequest:(FLServiceRequest*) request {
    id service = [_services objectForKey:request.serviceType];
    return service != nil;
}

- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request {
    return [self sendServiceRequest:request completion:nil];
}

- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request 
                 completion:(FLCompletionBlock) completion {
                 
    id service = [_services objectForKey:request.serviceType];
    if(service) {
       return [service didReceiveServiceRequest:request completion:completion]; 
    }

    FLFinisher* finisher = [FLFinisher finisher:completion];
    [finisher setFinishedWithResult:[NSError serviceRequestNotHandledError:request.serviceType]];
    return finisher;
}                 

- (void) openServices:(id) openedBy {
    for(id<FLService> service in _services) {
        FLPerformSelector1(service, @selector(openService:), openedBy);
    }
}

- (void) closeServices:(id) closedBy {
    for(id<FLService> service in _services) {
        FLPerformSelector1(service, @selector(closeService:), closedBy);
    }
}

- (id) resourceForKey:(id) key {
//    for(id<FLService> service in _services) {
//        FLPerformSelector1(service, @selector(resourceForKey:), key);
//    }

    return nil;
}



@end

@implementation FLService

@synthesize services = _services;

- (id) init {
    self = [super init];
    if(self) {
        _requestHandlers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_requestHandlers release];
    [super dealloc];
}
#endif

- (void) setRequestHandler:(SEL) selector forServiceRequestType:(id) serviceRequestType {

    FLServiceRequestHandler handler = ^(id service, FLServiceRequest* serviceRequest, FLFinisher* finisher) {
        FLPerformSelector2(service, selector, serviceRequest, finisher);
    };

    [_requestHandlers setObject:FLAutoreleasedCopy(handler) forKey:serviceRequestType];
}

- (void) didMoveToServiceGroup:(FLServiceGroup*) parent {
    _services = parent;
}

- (FLFinisher*) didReceiveServiceRequest:(FLServiceRequest*) request 
                              completion:(FLCompletionBlock) completion {
    
    FLFinisher* finisher = [FLFinisher finisher:completion];

    FLServiceRequestHandler handler = [_requestHandlers objectForKey:request.requestType];
    if(handler) {
        handler(self, request, finisher);
    }
    else {
        [finisher setFinishedWithResult:[NSError serviceRequestNotHandledError:request.serviceType]];
    }
    
    return finisher;
                              
}                              

@end

@implementation NSError (FLService)

+ (NSError*) serviceRequestNotHandledError:(NSString*) serviceType {
    
    NSString* notHandled = NSLocalizedString(@"Unhandled service request for service type", nil);

    NSString* errorString = [NSString stringWithFormat:@"%@: %@", notHandled, serviceType];

    return [NSError errorWithDomain:[FLFrameworkErrorDomain instance]
                                   code:FLUnhandledServiceRequestErrorCode
                                   userInfo:[NSDictionary dictionaryWithObject:serviceType forKey:FLServiceTypeKey]
                                   reason:errorString
                                   comment:nil
                                   stackTrace:FLCreateStackTrace(NO)];
}

- (BOOL) isUnhandledServiceRequestError {
	return	FLStringsAreEqual(NSURLErrorDomain, self.domain) && 
			self.code == FLUnhandledServiceRequestErrorCode; 
}

- (NSString*) unhandledServiceRequestServiceType {
    return [self.userInfo objectForKey:FLServiceTypeKey];
}

@end
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

