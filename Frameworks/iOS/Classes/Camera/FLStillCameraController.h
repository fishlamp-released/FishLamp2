//
//	FLStillCameraController.h
//	Snaplets
//
//	Created by Mike Fullerton on 11/5/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLStillCamera.h"
#import "FLCameraController.h"
#import "FLJpegFileImageAsset.h"
#if FL_CUSTOM_CAMERA
@protocol FLStillCameraControllerDelegate;

@interface FLStillCameraController : FLCameraController {
	FLStillCamera* _camera;
}

@property (readwrite, nonatomic, assign) id<FLCameraControllerDelegate, FLStillCameraControllerDelegate> delegate;

@end

@protocol FLStillCameraControllerDelegate <NSObject>
- (void) stillCameraController:(FLStillCameraController*) controller 
	didCapturePhoto:(FLCameraPhoto*) photo;
@end
#endif