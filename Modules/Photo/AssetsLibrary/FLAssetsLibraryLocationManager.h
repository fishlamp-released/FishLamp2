//
//  FLAssetsLibraryLocationManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLCallback.h"

@interface FLAssetsLibraryLocationManager : NSObject<CLLocationManagerDelegate> {
@private
    CLLocationManager* m_locationManager;
    BOOL m_didWarnUser;
    FLEventCallback m_callback;
}

@property (readwrite, assign, nonatomic) BOOL didWarnUser;
@property (readonly, assign, nonatomic) BOOL isCheckingPermissions;
@property (readonly, retain, nonatomic) CLLocationManager* locationManager; // only valid during permissions check

- (void) startPermissionsCheck:(FLEventCallback) finishedBlock;

- (void) cancelPermissionsCheck;

@end

