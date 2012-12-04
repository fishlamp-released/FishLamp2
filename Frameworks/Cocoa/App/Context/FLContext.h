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
    NSMutableSet* _registeredServices;
    BOOL _sessionOpen;
}

- (BOOL) serviceIsRegistered:(NSString*) serviceName;

- (id) serviceForName:(NSString*) name;

- (void) removeServiceForName:(NSString*) name;

- (void) setService:(id<FLService>) service forName:(NSString*) name;

@property (readonly, assign, getter=isContextOpen) BOOL sessionOpen;
- (void) openContext;
- (void) closeContext;

@end



#define service_register_(__NAME__, __TYPE__, __UTI__) 

//#define service_register_(__NAME__, __TYPE__, __UTI__) \
//    @implementation __TYPE__ (__TYPE__##ServiceRegistration) \
//        + (NSString*) serviceUTI { return __UTI__; } \
//    @end \
//    @implementation FLContext (__TYPE__##ServiceRegistration) \
//        - (id) __NAME__ { return [self valueForKey:__UTI__]; }\
//    @end


@protocol FLSessionObserver <FLObservable>
@optional
- (void) sessionWillOpen:(FLContext*) context;
- (void) sessionDidOpen:(FLContext*) context;

- (void) sessionWillClose:(FLContext*) context;
- (void) sessionDidClose:(FLContext*) context;
@end


