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

@class FLSession;

@protocol FLService <FLObservable>
+ (id) serviceID;

@property (readonly, assign) id session;

@property (readonly, assign) BOOL isServiceOpen;
- (void) openService;
- (void) closeService;

- (void) wasAddedToSession:(FLSession*) session;
@end

@interface FLService : FLObservable<FLService> {
@private
    __unsafe_unretained id<FLService> _session;
    BOOL _isServiceOpen;
}
@end

#define declare_service_(__NAME__, __TYPE__) \
    @class __TYPE__; \
    @protocol __TYPE__##ServiceRegistration <NSObject>  \
        @property (readonly, strong) __TYPE__* __NAME__; \
    @end 



    