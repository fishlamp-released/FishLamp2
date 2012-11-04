//
//  FLService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"

@protocol FLServiceGroup;

@protocol FLService <FLObservable>
+ (id) serviceID;

@property (readonly, assign) BOOL isServiceOpen;
- (void) openService;
- (void) closeService;

@property (readonly, assign) id services;

- (void) wasAddedToSession:(id<FLServiceGroup>) services;

@end

@interface FLService : FLObservable<FLService> {
@private
    __unsafe_unretained id<FLServiceGroup> _services;
}

@end



