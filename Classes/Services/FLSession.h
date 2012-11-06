//
//  FLSession.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/6/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLService.h"
#import "FLObservable.h"

@interface FLSession : FLObservable {
@private
    NSMutableDictionary* _services;
    BOOL _sessionOpen;
}

- (void) registerService:(id<FLService>) appService 
              forID:(id) serviceID;

- (void) registerService:(id<FLService>) service;

- (void) removeService:(id<FLService>) service;

- (void) removeServiceForID:(id) serviceID;

- (id) serviceForID:(id) serviceID;

- (BOOL) serviceIsRegistered:(id) serviceID;

@property (readonly, assign, getter=isSessionOpen) BOOL sessionOpen;
- (void) openSession;
- (void) closeSession;

@end

#define register_service_(__NAME__, __TYPE__) \
    @implementation FLSession (__TYPE__##ServiceRegistration) \
        - (__TYPE__*) __NAME__ { return [self serviceForID:@#__NAME__]; } \
    @end \
    @implementation __TYPE__ (__TYPE__##ServiceRegistration) \
        + (id) serviceID { return @#__NAME__; } \
    @end

@protocol FLSessionObserver <FLObservable>
@optional
- (void) sessionWillOpen:(FLSession*) session;
- (void) sessionDidOpen:(FLSession*) session;

- (void) sessionWillClose:(FLSession*) session;
- (void) sessionDidClose:(FLSession*) session;
@end