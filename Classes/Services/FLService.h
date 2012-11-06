//
//  FLService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"
#import "FLServiceable.h"

@protocol FLService <FLObservable>
+ (id) serviceID;

@property (readonly, assign) id parentService;
@property (readonly, assign) BOOL isServiceOpen;
- (void) openService;
- (void) closeService;

- (void) wasAddedToService:(id<FLService>) parentService;
@end

@interface FLService : FLObservable<FLService> {
@private
    __unsafe_unretained id<FLService> _parentService;
    BOOL _isServiceOpen;
}
@end

@interface FLParentService : FLService {
@private
    NSMutableDictionary* _services;
}

- (void) setService:(id<FLService>) appService 
       forID:(id) serviceID;

- (void) setService:(id<FLService>) service;

- (void) removeService:(id<FLService>) service;

- (void) removeServiceForID:(id) serviceID;

- (id) serviceForID:(id) serviceID;

@end

// helper for your init methods         
#define FLCreateService_(__TYPE__) \
        [self setService:autorelease_([[__TYPE__ alloc] init]) forID:[__TYPE__ serviceID]];

#define using_service_(__NAME__, __TYPE__) \
            @property (readonly, strong) __TYPE__* __NAME__;

#define declare_service_(__NAME__, __TYPE__) \
    @class __TYPE__; \
    @protocol __TYPE__##ServiceRegistration <NSObject>  \
        @property (readonly, strong) __TYPE__* __NAME__; \
    @end 

#define register_service_(__NAME__, __TYPE__) \
    @implementation FLParentService (__TYPE__##ServiceRegistration) \
        - (__TYPE__*) __NAME__ { return [self serviceForID:@#__NAME__]; } \
    @end \
    @implementation __TYPE__ (__TYPE__##ServiceRegistration) \
        + (id) serviceID { return @#__NAME__; } \
    @end



    