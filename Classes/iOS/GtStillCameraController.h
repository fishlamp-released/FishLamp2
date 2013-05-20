//
//	GtStillCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtStillCamera.h"
#import "GtCameraController.h"
#import "GtJpegFileImageAsset.h"
#if GT_CUSTOM_CAMERA
@protocol GtStillCameraControllerDelegate;

@interface GtStillCameraController : GtCameraController {
	GtStillCamera* m_camera;
}

@property (readwrite, nonatomic, assign) id<GtCameraControllerDelegate, GtStillCameraControllerDelegate> delegate;

@end

@protocol GtStillCameraControllerDelegate <NSObject>
- (void) stillCameraController:(GtStillCameraController*) controller 
	didCapturePhoto:(GtCameraPhoto*) photo;
@end
#endif