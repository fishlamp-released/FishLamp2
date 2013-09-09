//
//	FLPhotoViewControllerStrategy.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLCameraController.h"
#import "FLCamera.h"
#import "FLCameraOverlayView.h"
#import "FLFramesCameraController.h"
#import "FLStillCameraController.h"
#if FL_CUSTOM_CAMERA
@class FLCameraViewController;

@interface FLPhotoViewControllerStrategy : NSObject<FLCameraControllerDelegate, 
	FLCameraOverlayViewDelegate> {

@private
	FLCameraController* _cameraController;
	FLCameraViewController* _viewController;
	struct {
		unsigned int registeredForFocusEvents:1;
		unsigned int closeWhenCameraStopped:1;
	} _flags;
}

- (id) initWithViewController:(FLCameraViewController*) viewController;

@property (readonly, nonatomic, assign) FLCameraViewController* viewController;
@property (readwrite, nonatomic, retain) FLCameraController* cameraController;
@property (readonly, nonatomic, retain) FLCamera* camera;
@property (readwrite, nonatomic, assign) BOOL registeredForFocusEvents;

- (void) updateFocusRect;

- (void) beginTakingPhoto;

- (void) viewWillAppear:(BOOL)animated;
- (void) viewWillDisappear:(BOOL)animated;

- (void) viewDidLoad;
- (void) viewDidUnload;

- (void) removeLastPhotoPreview;
- (void) setLastPhotoPreview:(FLCameraPhoto*) image; 

- (void) unregisterForFocusEvents;
- (void) registerForFocusEvents;

@end

@interface FLPhotoViewControllerVideoFrameStrategy : FLPhotoViewControllerStrategy
@end

@interface FLPhotoViewControllerStillStrategy : FLPhotoViewControllerStrategy<FLStillCameraControllerDelegate> {
	NSMutableArray* _photos;
}
@end

#endif