//
//  FLAssetsLibraryLocationManager.m
//  FishLamp
//
//  Created by Mike Fullerton on 8/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLAssetsLibraryLocationManager.h"

@implementation FLAssetsLibraryLocationManager

@synthesize didWarnUser = _didWarnUser;
@synthesize locationManager = _locationManager;

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}


- (void) _releaseLocationManager
{
    if(_locationManager)
    {
        _locationManager.delegate = nil;
        [_locationManager stopUpdatingLocation];
        FLReleaseWithNil(_locationManager);
    }
}

- (void) dealloc
{
    [self _releaseLocationManager];
    FLRelease(_callback);
    FLSuperDealloc();
}


- (void) _finishedCheck
{
    if(_callback)
    {
        _callback();
    }
    
    [self _releaseLocationManager];
    FLReleaseBlockWithNil(_callback);
}

- (BOOL) isCheckingPermissions
{
    return _locationManager != nil;
}

- (void) startPermissionsCheck:(dispatch_block_t) finishedCallback
{
//#if DEBUG
//    if(DeviceIsSimulator())
//    {
//        FLInvokeCallback(_callback, self);
//        _callback = FLCallbackZero;
//        return;
//    }
//#endif
    
    _callback = FLCopyBlock(finishedCallback);

    if( [CLLocationManager locationServicesEnabled] && 
        [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        FLAssertIsNilWithComment(_locationManager, nil);
        
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.purpose = NSLocalizedString( @"Browse and Upload Device Photos", nil);
        _locationManager.desiredAccuracy=kCLLocationAccuracyThreeKilometers;
        [_locationManager startUpdatingLocation];
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
    FLReleaseBlockWithNil(_callback);
}

@end