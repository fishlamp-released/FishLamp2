//
//  GtAssetsLibraryLocationManager.h
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCallback.h"

@interface GtAssetsLibraryLocationManager : NSObject<CLLocationManagerDelegate> {
@private
    CLLocationManager* m_locationManager;
    BOOL m_didWarnUser;
    GtBlock m_callback;
}

@property (readwrite, assign, nonatomic) BOOL didWarnUser;
@property (readonly, assign, nonatomic) BOOL isCheckingPermissions;
@property (readonly, retain, nonatomic) CLLocationManager* locationManager; // only valid during permissions check

- (void) startPermissionsCheck:(GtBlock) finishedBlock;

- (void) cancelPermissionsCheck;

@end

