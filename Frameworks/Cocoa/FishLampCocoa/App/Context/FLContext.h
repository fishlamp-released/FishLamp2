//
//  FLContext.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

@protocol FLService;

@interface FLContext : FLObservable {
@private
    NSMutableDictionary* _services;
    BOOL _sessionOpen;
}

- (void) registerService:(id<FLService>) appService 
              forID:(id) serviceUTI;

- (void) registerService:(id<FLService>) service;

- (void) removeService:(id<FLService>) service;

- (void) removeServiceForID:(id) serviceUTI;

- (id) serviceForID:(id) serviceUTI;

@property (readonly, assign, getter=isContextOpen) BOOL sessionOpen;
- (void) openContext;
- (void) closeContext;

@end

//    @implementation FLContext (__TYPE__##ServiceRegistration) \
//        - (__TYPE__*) __NAME__ { return [self serviceForID:@#__NAME__]; } \
//    @end 

#define service_declare_(__NAME__, __TYPE__) \
    @class __TYPE__; \
    @interface FLContext (__TYPE__##ServiceRegistration) \
        @property (readonly, strong) id __NAME__; \
    @end

#define service_register_(__NAME__, __TYPE__, __UTI__) \
    @implementation __TYPE__ (__TYPE__##ServiceRegistration) \
        + (NSString*) serviceUTI { return __UTI__; } \
    @end \
    @implementation FLContext (__TYPE__##ServiceRegistration) \
        - (id) __NAME__ { return [self valueForKey:__UTI__]; }\
    @end

@protocol FLSessionObserver <FLObservable>
@optional
- (void) sessionWillOpen:(FLContext*) context;
- (void) sessionDidOpen:(FLContext*) context;

- (void) sessionWillClose:(FLContext*) context;
- (void) sessionDidClose:(FLContext*) context;
@end


