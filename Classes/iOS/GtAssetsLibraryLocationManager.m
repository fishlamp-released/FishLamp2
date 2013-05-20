//
//  GtAssetsLibraryLocationManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetsLibraryLocationManager.h"

@implementation GtAssetsLibraryLocationManager

@synthesize didWarnUser = m_didWarnUser;
@synthesize locationManager = m_locationManager;

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}


- (void) _releaseLocationManager
{
    if(m_locationManager)
    {
        m_locationManager.delegate = nil;
        [m_locationManager stopUpdatingLocation];
        GtReleaseWithNil(m_locationManager);
    }
}

- (void) dealloc
{
    [self _releaseLocationManager];
    GtRelease(m_callback);
    GtSuperDealloc();
}


- (void) _finishedCheck
{
    if(m_callback)
    {
        m_callback();
    }
    
    [self _releaseLocationManager];
    GtReleaseBlockWithNil(m_callback);
}

- (BOOL) isCheckingPermissions
{
    return m_locationManager != nil;
}

- (void) startPermissionsCheck:(GtBlock) finishedCallback
{
//#if DEBUG
//    if(DeviceIsSimulator())
//    {
//        GtInvokeCallback(m_callback, self);
//        m_callback = GtCallbackZero;
//        return;
//    }
//#endif
    
    GtCopyBlock(m_callback, finishedCallback);

    if( [CLLocationManager locationServicesEnabled] && 
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        GtAssertNil(m_locationManager);
        
        m_locationManager = [[CLLocationManager alloc] init];
        m_locationManager.delegate = self;
        m_locationManager.purpose = NSLocalizedString( @"Browse and Upload Device Photos", nil);
        m_locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers;
        [m_locationManager startUpdatingLocation];
    }
    else
    {
        [self _finishedCheck];
    }
}

- (void)locationManager:(CLLocationManager *)manager
	didFailWithError:(NSError *)error
{
    [self _finishedCheck];
}

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
	fromLocation:(CLLocation *)oldLocation
{
    [self _finishedCheck];
}

- (void) cancelPermissionsCheck
{
    [self _releaseLocationManager];
    GtReleaseBlockWithNil(m_callback);
}

@end