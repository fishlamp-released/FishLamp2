//
//  FLSession.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLCocoaRequired.h"
#import "FLServiceProvider.h"
#import "FLObservable.h"
#import "FLDispatcher.h"

@class FLMutableBatchDictionary;
@class FLFifoDispatchQueue;

typedef id (^FLResourceProviderBlock)(id provider);

@interface FLSession : FLObservable {
@private
    NSMutableDictionary* _services;
    NSMutableDictionary* _resourceProviders;
    FLMutableBatchDictionary* _resourceConsumers;
    FLFifoDispatchQueue* _dispatcher;
    
    BOOL _open;
}

@property (readonly, assign, getter=isOpen) BOOL open;
@property (readonly, strong) id<FLDispatcher> dispatcher;

+ (id) session;

- (id) serviceForServiceID:(id) serviceID;

- (void) setService:(id) service forServiceID:(id) serviceID;

- (void) removeServiceForServiceType:(id) serviceID;

- (void) openSession;
- (void) closeSession;
- (void) requestCancel;

// TODO : some sort of FIFO queue for opening???


// 
// resources
//

- (id) resourceForKey:(id) key;

- (void) setResourceProvider:(id) provider 
                      forKey:(id) resourceKey
               providerBlock:(FLResourceProviderBlock) providerBlock;
                              
- (void) addResourceConsumer:(id) consumer 
                    selector:(SEL) selector 
                      forKey:(id) resourceKey;

// 
// broadcasts 
//
- (void) broadcast:(SEL) selector;

- (void) broadcast:(SEL) selector withObject:(id) object;

- (void) broadcast:(SEL) selector withObject:(id) object1 withObject:(id) object2;



@end

//#define __CATEGORY_FOR_SERVICE(__TYPE__) (__TYPE__##ServiceDeclaration)
//
//#define FLBeginPublishingService(__NAME__, __TYPE__) \
//            @interface FLSession __CATEGORY_FOR_SERVICE(__TYPE__) \
//                - (__TYPE__*) __NAME__
//
//#define FLBeginPublishingServiceForProtocol(__NAME__, __TYPE__) \
//            @interface FLSession __CATEGORY_FOR_SERVICE(__TYPE__) \
//                - (id<__TYPE__>) __NAME__ 
//
//#define FLPublishServiceProperty(__TYPE__, __NAME__) \
//                - (__TYPE__) __NAME__ 
//
//#define FLEndPublishingService() \
//            @end
//           
//#define FLPublishService(__NAME__, __TYPE__) \ 
//            FLBeginPublishingService(__NAME__, __TYPE__); \
//            FLEndPublishingService();
//
//#define FLPublishServiceForProtocol(__NAME__, __TYPE__) \ 
//            FLBeginPublishingServiceForProtocol(__NAME__, __TYPE__); \
//            FLEndPublishingService();
//           
//           
//#define FLBeginSynthesizingService(__NAME__, __TYPE__, __SERVICE_TYPE__) \
//            \
//            @implementation __TYPE__ __CATEGORY_FOR_SERVICE(__TYPE__) \
//                + (id) serviceID { \
//                    return __SERVICE_TYPE__; \
//                } \
//            @end \
//            \
//            @implementation FLSession __CATEGORY_FOR_SERVICE(__TYPE__) \
//            - (__TYPE__*) __NAME__ { \
//                return [self serviceForServiceID:__SERVICE_TYPE__]; \
//            } 
//                        
//#define FLSynthesizeSessionProperty(__TYPE__, __NAME__) \
//            - (__TYPE__*) __NAME__ { \
//                return nil; \
//            } 
//
//
//            
//#define FLEndSynthesizingService() \
//            @end
//            
//#define FLSynthesizeService(__NAME__, __TYPE__, __SERVICE_TYPE__) \
//            FLBeginSynthesizingService(__NAME__, __TYPE__, __SERVICE_TYPE__); \
//            FLEndSynthesiziingService()
            
#define FLSynthesizeSessionProperty(__GETTER__, __TYPE__, __SERVICE_CLASS_NAME__) \
            - (__TYPE__) __GETTER__ { \
                return [[self serviceForServiceID:@#__SERVICE_CLASS_NAME__] __GETTER__]; \
            }             

#define FLSynthesizeSessionService(__GETTER__, __SETTER__, __TYPE__) \
           - (__TYPE__) __GETTER__ { \
                return [self serviceForServiceID:@#__GETTER__]; \
           } \
           - (void) __SETTER__:(__TYPE__) service { \
                [self setService:service forServiceID:@#__GETTER__]; \
           }
