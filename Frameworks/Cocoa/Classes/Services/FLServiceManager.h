//
//  FLServiceManager.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/26/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

//#import "FLCocoaRequired.h"
//#import "FLServiceProvider.h"
//
//@class FLMutableBatchDictionary;
//
//typedef id (^FLResourceProviderBlock)(id provider);
//
//typedef SEL FLServicePropertySelector;
//
//@interface FLServiceManager : NSObject {
//@private
//    NSMutableDictionary* _resourceProviders;
//    FLMutableBatchDictionary* _resourceConsumers;
//    NSMutableArray* _services;
//    BOOL _open;
//}
//
//@property (readonly, assign, getter=isOpen) BOOL open;
//
//+ (id) serviceManager;
//
//- (void) openServices;
//
//- (void) closeServices;
//
//- (void) requestCancel;
//
//// TODO : some sort of FIFO queue for opening???
//
//- (void) registerService:(FLServicePropertySelector) serviceSelector;
//
//- (void) unregisterService:(FLServicePropertySelector) serviceSelector;
//
//- (void) visitServices:(void (^)(id service, BOOL* stop)) visitor;
//
//// 
//// resources

////
//
//- (id) resourceForKey:(id) key;
//
//- (void) setResourceProvider:(id) provider 
//                      forKey:(id) resourceKey
//               providerBlock:(FLResourceProviderBlock) providerBlock;
//                              
//- (void) addResourceConsumer:(id) consumer 
//                    selector:(SEL) selector 
//                      forKey:(id) resourceKey;
//
//// 
//// broadcasts 
////
//- (void) broadcast:(SEL) selector;
//
//- (void) broadcast:(SEL) selector withObject:(id) object;
//
//- (void) broadcast:(SEL) selector withObject:(id) object1 withObject:(id) object2;
//
//@end
//
//#define FLCreateAndRegisterService(__NAME__, __TYPE__) \
//            self.__NAME__ = FLAutorelease([[__TYPE__ alloc] init]); \
//            [self registerService:@selector(__NAME__)]
//    
//
//
