//
//	FLFramesCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright 2010 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLVideoFrameGrabberCamera.h"
#import "FLCameraController.h"
#if FL_CUSTOM_CAMERA
@interface FLFramesCameraController : FLCameraController {
	FLVideoFrameGrabberCamera* _camera;
}
@end
#endif

