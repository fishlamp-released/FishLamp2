//
//  FLSimpleCamera.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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




