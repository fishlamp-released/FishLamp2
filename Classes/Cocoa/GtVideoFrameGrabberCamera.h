//
//	GtVideoFrameGrabberCamera.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/20/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if GT_CUSTOM_CAMERA
#if __IPHONE_4_0

#import <Foundation/Foundation.h>
#import "GtCamera.h"

@class GtVideoFrameGrabberCamera;

typedef void (^GtVideoFrameGrabberCameraBlock)(GtVideoFrameGrabberCamera* camera, NSError* error);

@interface GtVideoFrameGrabberCamera : GtCamera {
	NSMutableArray* m_frames;
	NSTimeInterval m_interval;
	NSTimeInterval m_nextFrame;
	NSUInteger m_frame;
	NSUInteger m_frameCount;
	BOOL m_capturing;
	GtVideoFrameGrabberCameraBlock m_block;
}

- (void) captureFrames:(NSUInteger) count 
	interval:(NSTimeInterval) interval
	block:(GtVideoFrameGrabberCameraBlock) block; 

@end
#endif
#endif