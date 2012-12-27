//
//  FLSession.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSession.h"
#import "FLKeyValuePair.h"
#import "FLBatchDictionary.h"
#import "FLCallback.h"
#import "FLDispatchQueue.h"

//
// requests
//

//- (BOOL) canSendRequest:(FLServiceRequest*) request;
//
//- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request;
//
//- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request 
//                        completion:(FLCompletionBlock) completion;


@interface FLSession ()
@property (readwrite, assign, getter=isOpen) BOOL open;
@end

@implementation FLSession

@synthesize open = _open;
@synthesize dispatcher = _dispatcher;

- (id) init {
    self = [super init];
    if(self) {
        _services = [[NSMutableDictionary alloc] init];
        _resourceProviders = [[NSMutableDictionary alloc] init];
        _resourceConsumers = [[FLMutableBatchDictionary alloc] init];
        _dispatcher = [[FLFifoDispatchQueue alloc] init];
    }
    
    return self;
}

+ (id) session {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_dispatcher release];
    [_resourceConsumers release];
    [_resourceProviders release];
    [_services release];
    [super dealloc];
}
#endif

- (id) serviceForServiceID:(id) serviceID {
    FLAssertNotNil_(serviceID);
    return [_services objectForKey:serviceID];
} 

- (void) removeServiceForServiceType:(id) serviceID {

    FLAssertNotNil_(serviceID);

    id service = [self serviceForServiceID:serviceID];
    if(service) {
        if(self.isOpen) {
            [service closeService:self];
        }

        [_services removeObjectForKey:serviceID];
    }
}

- (void) setService:(id) service forServiceID:(id) serviceID {

    FLAssertNotNil_(serviceID);
    FLAssertNotNil_(service);
    
    FLConfirm_v([_services objectForKey:serviceID] == nil, @"service type already registered: %@", serviceID);
    
    [_services setObject:service forKey:serviceID];

    if(self.isOpen) {
        [service openService:self];
    }
}

- (void) openSession {
    [self broadcast:@selector(openService:) withObject:self];
}

- (void) closeSession {
    [self broadcast:@selector(closeService:) withObject:self];
}

- (void) requestCancel {
    [self broadcast:@selector(requestCancel)];
}

- (void) setResourceProvider:(id) provider 
                      forKey:(id) resourceKey
               providerBlock:(FLResourceProviderBlock) providerBlock {

    FLConfirm_v([_resourceProviders objectForKey:resourceKey] == nil, @"resource provider for %@ already set", resourceKey);
    
    [_resourceProviders setObject:[FLKeyValuePair keyValuePair:provider value:FLAutoreleasedCopy(providerBlock)] forKey:resourceKey];
}

- (void) addResourceConsumer:(id) consumer 
                    selector:(SEL) selector 
                      forKey:(id) resourceKey {

    [_resourceConsumers addObject:[FLCallback callbackWithTarget:consumer action:selector] forKey:resourceKey];
}

- (id) resourceForKey:(id) key {
    FLKeyValuePair* providerInfo = [_resourceProviders objectForKey:key];
    if(providerInfo && providerInfo.value) {
        FLResourceProviderBlock block = providerInfo.value;
        return block(providerInfo.value);
    }
    
    return nil;
}

//- (BOOL) canSendRequest:(FLServiceRequest*) request {
//    id service = [self serviceForServiceID:request.serviceID];
//    return service != nil && [service respondsToSelector:@selector(didReceiveServiceRequest:completion:)];
//}
//
//- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request {
//    return [self sendServiceRequest:request completion:nil];
//}
//
//- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request 
//                 completion:(FLCompletionBlock) completion {
//                 
//    id service = [self serviceForServiceID:request.serviceID];
//    if(service) {
//        return [service didReceiveServiceRequest:request completion:completion]; 
//    }
//
//    FLFinisher* finisher = [FLFinisher finisher:completion];
//    [finisher setFinishedWithResult:[NSError serviceRequestNotHandledError:request.serviceID]];
//    return finisher;
//}  

- (void) broadcast:(SEL) selector {
    for(id<FLServiceProvider> service in _services) {
        FLPerformSelector(service, selector);
    }
}

- (void) broadcast:(SEL) selector withObject:(id) object {
    for(id<FLServiceProvider> service in _services) {
        FLPerformSelector1(service, selector, object);
    }
}

- (void) broadcast:(SEL) selector withObject:(id) object1 withObject:(id) object2 {
    for(id<FLServiceProvider> service in _services) {
        FLPerformSelector2(service, selector, object1, object2);
    }
}


@end
