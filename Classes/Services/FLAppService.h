//
//  FLAppService.h
//  FishLampCore
//
//  Created by Mike Fullerton on 11/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLObservable.h"
#import "FLFolder.h"
#import "FLPromisedResult.h"
#import "FLResult.h"

@protocol FLServiceSession;
@protocol FLUserSession;

@protocol FLAppService <FLObservable>
- (void) setService:(id<FLAppService>) service forKey:(id) key;
- (void) removeServiceForKey:(id) key;
- (id<FLAppService>) serviceForKey:(id) key;

- (void) addAppService:(id<FLAppService>) appService;
- (void) removeAppService:(id<FLAppService>) appService;

@property (readonly, assign) BOOL isServiceOpen;

- (id<FLPromisedResult>) startOpeningService:(FLResultBlock) completion;
- (id<FLPromisedResult>) startClosingService:(FLResultBlock) completion;

- (void) addToAppService:(id<FLAppService>) service;
- (void) removeFromAppService:(id<FLAppService>) service;

@end

@interface FLAppService : FLObservable<FLAppService> {
@private
    NSMutableDictionary* _services;
}

- (void) openSelf:(id<FLFinisher>) finisher;
- (void) closeSelf:(id<FLFinisher>) finisher;

@end



