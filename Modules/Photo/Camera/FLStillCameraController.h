//
//	FLStillCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLStillCamera.h"
#import "FLCameraController.h"
#import "FLJpegFileImageAsset.h"
#if FL_CUSTOM_CAMERA
@protocol FLStillCameraControllerDelegate;

@interface FLStillCameraController : FLCameraController {
	FLStillCamera* m_camera;
}

@property (readwrite, nonatomic, assign) id<FLCameraControllerDelegate, FLStillCameraControllerDelegate> delegate;

@end

@protocol FLStillCameraControllerDelegate <NSObject>
- (void) stillCameraController:(FLStillCameraController*) controller 
	didCapturePhoto:(FLCameraPhoto*) photo;
@end
#endif