//
//	FLVideoFrameGrabberCamera.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//
#if FL_CUSTOM_CAMERA
#if __IPHONE_4_0

#import <Foundation/Foundation.h>
#import "FLCamera.h"

@class FLVideoFrameGrabberCamera;

typedef void (^FLVideoFrameGrabberCameraBlock)(FLVideoFrameGrabberCamera* camera, NSError* error);

@interface FLVideoFrameGrabberCamera : FLCamera {
	NSMutableArray* _frames;
	NSTimeInterval _interval;
	NSTimeInterval _nextFrame;
	NSUInteger _frame;
	NSUInteger _frameCount;
	BOOL _capturing;
	FLVideoFrameGrabberCameraBlock _block;
}

- (void) captureFrames:(NSUInteger) count 
	interval:(NSTimeInterval) interval
	block:(FLVideoFrameGrabberCameraBlock) block; 

@end
#endif
#endif