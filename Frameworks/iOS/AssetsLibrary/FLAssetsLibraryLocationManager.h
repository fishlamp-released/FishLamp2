//
//  FLAssetsLibraryLocationManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCallback_t.h"

@interface FLAssetsLibraryLocationManager : NSObject<CLLocationManagerDelegate> {
@private
    CLLocationManager* _locationManager;
    BOOL _didWarnUser;
    dispatch_block_t _callback;
}

@property (readwrite, assign, nonatomic) BOOL didWarnUser;
@property (readonly, assign, nonatomic) BOOL isCheckingPermissions;
@property (readonly, retain, nonatomic) CLLocationManager* locationManager; // only valid during permissions check

- (void) startPermissionsCheck:(dispatch_block_t) finishedBlock;

- (void) cancelPermissionsCheck;

@end

