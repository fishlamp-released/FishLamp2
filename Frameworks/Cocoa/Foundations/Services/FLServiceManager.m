////
////  FLServiceManager.m
////  FishLampCocoa
////
////  Created by Mike Fullerton on 12/26/12.
////  Copyright (c) 2012 Mike Fullerton. All rights reserved.
////
//
//#import "FLServiceManager.h"
//#import "FLKeyValuePair.h"
//#import "FLBatchDictionary.h"
//#import "FLCallback.h"
//#import "FLAsyncQueue.h"
//
////
//// requests
////
//
////- (BOOL) canSendRequest:(FLServiceRequest*) request;
////
////- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request;
////
////- (FLFinisher*) sendServiceRequest:(FLServiceRequest*) request 
////                        completion:(FLBlockWithResult) completion;
//
//#pragma GCC diagnostic push
//#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"
//
//
//@interface FLServiceManager ()
//@property (readwrite, assign, getter=isOpen) BOOL open;
//@end
//
//@implementation FLServiceManager
//
//@synthesize open = _open;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _services = [[NSMutableArray alloc] init];
//        _resourceProviders = [[NSMutableDictionary alloc] init];
//        _resourceConsumers = [[FLMutableBatchDictionary alloc] init];
//    }
//    
//    return self;
//}
//
//+ (id) serviceManager {
//    return FLAutorelease([[[self class] alloc] init]);
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_resourceConsumers release];
//    [_resourceProviders release];
//    [_services release];
//    [super dealloc];
//}
//#endif
//
////- (id)forwardingTargetForSelector:(SEL)aSelector { 
////    if([self.observable respondsToSelector:aSelector]) {
////        return self.observable;
////    }
////    
////    return self;
////}
//
////- (id) serviceForServiceID:(id) serviceID {
////    FLAssertNotNil_(serviceID);
////    return [_services objectForKey:serviceID];
////} 
//
////- (void) removeServiceForServiceType:(id) serviceID {
////
////    FLAssertNotNil_(serviceID);
////
////    id service = [self serviceForServiceID:serviceID];
////    if(service) {
////        if(self.isOpen) {
////            [service closeService:self];
////        }
////
////        [_services removeObjectForKey:serviceID];
////    }
////}
////
////- (void) setService:(id) service forServiceID:(id) serviceID {
////
////    FLAssertNotNil_(serviceID);
////    FLAssertNotNil_(service);
////    
////    FLConfirm_v([_services objectForKey:serviceID] == nil, @"service type already registered: %@", serviceID);
////    
////    [_services setObject:service forKey:serviceID];
////
////    if(self.isOpen) {
////        [service openService:self];
////    }
////}
//
//- (void) registerService:(FLServicePropertySelector) serviceSelector {
//    [_services addObject:[NSValue valueWithPointer:serviceSelector]];
//}
//
//- (void) unregisterService:(FLServicePropertySelector) serviceSelector {
//    [_services removeObject:[NSValue valueWithPointer:serviceSelector]];
//}
//
//- (void) openServices {
//    [self broadcast:@selector(openService:) withObject:self];
//}
//
//- (void) closeServices {
//    [self broadcast:@selector(closeService:) withObject:self];
//}
//
//- (void) requestCancel {
//    [self broadcast:@selector(requestCancel)];
//}
//
//- (void) setResourceProvider:(id) provider 
//                      forKey:(id) resourceKey
//               providerBlock:(FLResourceProviderBlock) providerBlock {
//
//    FLConfirm_v([_resourceProviders objectForKey:resourceKey] == nil, @"resource provider for %@ already set", resourceKey);
//    
//    [_resourceProviders setObject:[FLKeyValuePair keyValuePair:provider value:FLCopyWithAutorelease(providerBlock)] forKey:resourceKey];
//}
//
//- (void) addResourceConsumer:(id) consumer 
//                    selector:(SEL) selector 
//                      forKey:(id) resourceKey {
//
//    [_resourceConsumers addObject:[FLCallback callbackWithTarget:consumer action:selector] forKey:resourceKey];
//}
//
//- (id) resourceForKey:(id) key {
//    FLKeyValuePair* providerInfo = [_resourceProviders objectForKey:key];
//    if(providerInfo && providerInfo.value) {
//        FLResourceProviderBlock block = providerInfo.value;
//        return block(providerInfo.value);
//    }
//    
//    return nil;
//}
//
//- (void) visitServices:(void (^)(id service, BOOL* stop)) visitor {
//
//    BOOL stop = NO;
//    for(NSValue* value in _services) {
//        SEL sel = [value pointerValue];
//        id service = [self performSelector:sel];
//        
//        visitor(service, &stop);
//        
//        if(stop) {
//            break;
//        }
//    }
//}
//
//- (void) broadcast:(SEL) selector {
//    [self visitServices:^(id service, BOOL *stop) {
//        FLPerformSelector(service, selector);
//    }];
//}
//
//- (void) broadcast:(SEL) selector withObject:(id) object {
//    [self visitServices:^(id service, BOOL *stop) {
//        FLPerformSelector1(service, selector, object);
//    }];
//}
//
//- (void) broadcast:(SEL) selector withObject:(id) object1 withObject:(id) object2 {
//    [self visitServices:^(id service, BOOL *stop) {
//        FLPerformSelector2(service, selector, object1, object2);
//    }];
//}
//
//- (NSString*) description {
//    NSMutableArray* services = [NSMutableArray array];
//    
//    [self visitServices:^(id service, BOOL *stop) {
//        [services addObject:service];
//    }];
//    
//    return [NSString stringWithFormat:@"%@ %@", [super description], [services description]];
//}
//
//
//@end
//
////#define __CATEGORY_FOR_SERVICE(__TYPE__) (__TYPE__##ServiceHeader)
////
////#define FLBeginPublishingService(__NAME__, __TYPE__) \
////            @interface FLServiceManager __CATEGORY_FOR_SERVICE(__TYPE__) \
////                - (__TYPE__*) __NAME__
////
////#define FLBeginPublishingServiceForProtocol(__NAME__, __TYPE__) \
////            @interface FLServiceManager __CATEGORY_FOR_SERVICE(__TYPE__) \
////                - (id<__TYPE__>) __NAME__ 
////
////#define FLPublishServiceProperty(__TYPE__, __NAME__) \
////                - (__TYPE__) __NAME__ 
////
////#define FLEndPublishingService() \
////            @end
////           
////#define FLPublishService(__NAME__, __TYPE__) \ 
////            FLBeginPublishingService(__NAME__, __TYPE__); \
////            FLEndPublishingService();
////
////#define FLPublishServiceForProtocol(__NAME__, __TYPE__) \ 
////            FLBeginPublishingServiceForProtocol(__NAME__, __TYPE__); \
////            FLEndPublishingService();
////           
////           
////#define FLBeginSynthesizingService(__NAME__, __TYPE__, __SERVICE_TYPE__) \
////            \
////            @implementation __TYPE__ __CATEGORY_FOR_SERVICE(__TYPE__) \
////                + (id) serviceID { \
////                    return __SERVICE_TYPE__; \
////                } \
////            @end \
////            \
////            @implementation FLServiceManager __CATEGORY_FOR_SERVICE(__TYPE__) \
////            - (__TYPE__*) __NAME__ { \
////                return [self serviceForServiceID:__SERVICE_TYPE__]; \
////            } 
////                        
////#define FLSynthesizeSessionProperty(__TYPE__, __NAME__) \
////            - (__TYPE__*) __NAME__ { \
////                return nil; \
////            } 
////
////
////            
////#define FLEndSynthesizingService() \
////            @end
////            
////#define FLSynthesizeService(__NAME__, __TYPE__, __SERVICE_TYPE__) \
////            FLBeginSynthesizingService(__NAME__, __TYPE__, __SERVICE_TYPE__); \
////            FLEndSynthesiziingService()
//            
////#define FLSynthesizeSessionProperty(__GETTER__, __TYPE__, __SERVICE_CLASS_NAME__) \
////            - (__TYPE__) __GETTER__ { \
////                return [[self serviceForServiceID:@#__SERVICE_CLASS_NAME__] __GETTER__]; \
////            }             
////
////#define FLSynthesizeSessionService(__GETTER__, __SETTER__, __TYPE__) \
////           - (__TYPE__) __GETTER__ { \
////                return [self serviceForServiceID:@#__GETTER__]; \
////           } \
////           - (void) __SETTER__:(__TYPE__) service { \
////                [self setService:service forServiceID:@#__GETTER__]; \
////           }
////
////#define FLSynthesizeService(__NAME__, __TYPE__, __SERVICE_TYPE__)
////
////#define FLSynthesizeSessionService(__GETTER__, __SETTER__, __TYPE__)
//
