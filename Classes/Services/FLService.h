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

- (void) addService:(id<FLService>) appService;
- (void) removeService:(id<FLService>) appService;
- (id<FLService>) serviceByID:(id) serviceID;

@end

// helper for your init methods         
#define FLSetService(__NAME__, __TYPE__) \
        __NAME__ = [[__TYPE__ alloc] init]; \
        [self addService:__NAME__];
