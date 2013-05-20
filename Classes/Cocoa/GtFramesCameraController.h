//
//	GtFramesCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtVideoFrameGrabberCamera.h"
#import "GtCameraController.h"
#if GT_CUSTOM_CAMERA
@interface GtFramesCameraController : GtCameraController {
	GtVideoFrameGrabberCamera* m_camera;
}
@end
#endif

