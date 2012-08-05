//
//  FLAssetsLibraryLocationManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import "FLAssetsLibraryLocationManager.h"

@implementation FLAssetsLibraryLocationManager

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
        FLReleaseWithNil(m_locationManager);
    }
}

- (void) dealloc
{
    [self _releaseLocationManager];
    FLRelease(m_callback);
    FLSuperDealloc();
}


- (void) _finishedCheck
{
    if(m_callback)
    {
        m_callback();
    }
    
    [self _releaseLocationManager];
    FLReleaseBlockWithNil(m_callback);
}

- (BOOL) isCheckingPermissions
{
    return m_locationManager != nil;
}

- (void) startPermissionsCheck:(FLEventCallback) finishedCallback
{
//#if DEBUG
//    if(DeviceIsSimulator())
//    {
//        FLInvokeCallback(m_callback, self);
//        m_callback = FLCallbackZero;
//        return;
//    }
//#endif
    
    FLCopyBlock(m_callback, finishedCallback);

    if( [CLLocationManager locationServicesEnabled] && 
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        FLAssertIsNil(m_locationManager);
        
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
    FLReleaseBlockWithNil(m_callback);
}

@end