//
//	FLFramesCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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

