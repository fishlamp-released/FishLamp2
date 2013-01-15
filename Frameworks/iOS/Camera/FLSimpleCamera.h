//
//  FLSimpleCamera.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimplePhoto.h"

@class FLOverlayCameraView;

@interface FLSimpleCamera : NSObject<CLLocationManagerDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate> {
@private
    UIImagePickerController* _picker;
	FLOverlayCameraView* _overlayView;
    CLLocationManager* _locationManager;
    __unsafe_unretained UIViewController* _viewController;
    BOOL _hidden;
    BOOL _animated;
}

- (void) showCameraInViewController:(UIViewController*) inController
                           animated:(BOOL) animated
                        geoTagPhoto:(BOOL) geoTagPhoto;

- (void) hideCamera;

@end

@protocol FLSimpleCameraObserver <FLObserver>
- (void) simpleCamera:(FLSimpleCamera*) camera tookPhoto:(FLSimplePhoto*) photo;
- (void) simpleCameraDidClose:(FLSimpleCamera*) camera;
@end




