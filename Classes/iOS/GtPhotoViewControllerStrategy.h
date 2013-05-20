//
//	GtPhotoViewControllerStrategy.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/6/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCameraController.h"
#import "GtCamera.h"
#import "GtCameraOverlayView.h"
#import "GtFramesCameraController.h"
#import "GtStillCameraController.h"
#if GT_CUSTOM_CAMERA
@class GtCameraViewController;

@interface GtPhotoViewControllerStrategy : NSObject<GtCameraControllerDelegate, 
	GtCameraOverlayViewDelegate> {

@private
	GtCameraController* m_cameraController;
	GtCameraViewController* m_viewController;
	struct {
		unsigned int registeredForFocusEvents:1;
		unsigned int closeWhenCameraStopped:1;
	} m_flags;
}

- (id) initWithViewController:(GtCameraViewController*) viewController;

@property (readonly, nonatomic, assign) GtCameraViewController* viewController;
@property (readwrite, nonatomic, retain) GtCameraController* cameraController;
@property (readonly, nonatomic, retain) GtCamera* camera;
@property (readwrite, nonatomic, assign) BOOL registeredForFocusEvents;

- (void) updateFocusRect;

- (void) beginTakingPhoto;

- (void) viewWillAppear:(BOOL)animated;
- (void) viewWillDisappear:(BOOL)animated;

- (void) viewDidLoad;
- (void) viewDidUnload;

- (void) removeLastPhotoPreview;
- (void) setLastPhotoPreview:(GtCameraPhoto*) image; 

- (void) unregisterForFocusEvents;
- (void) registerForFocusEvents;

@end

@interface GtPhotoViewControllerVideoFrameStrategy : GtPhotoViewControllerStrategy
@end

@interface GtPhotoViewControllerStillStrategy : GtPhotoViewControllerStrategy<GtStillCameraControllerDelegate> {
	NSMutableArray* m_photos;
}
@end

#endif