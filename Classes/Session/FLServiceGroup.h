//
//  FLServiceGroup.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/3/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLService.h"

@protocol FLServiceGroup <FLObservable>
- (void) addService:(id<FLService>) appService;
- (void) removeService:(id<FLService>) appService;
- (id<FLService>) serviceByID:(id) serviceID;

- (void) openSession;
- (void) closeSession;
@property (readonly, assign) BOOL isSessionOpen;
@end

@interface FLServiceGroup : NSObject<FLServiceGroup> {
@private
    NSMutableDictionary* _services;
}

@end
