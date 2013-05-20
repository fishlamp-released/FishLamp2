//
//	GtCameraPhotoViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtPhotoViewController.h"

#if GT_CUSTOM_CAMERA
@class GtCameraPhoto;

@interface GtCameraPhotoViewController : GtPhotoViewController<GtPhotoViewControllerDelegate> {
@private
	NSMutableArray* m_array;
//	  float m_angle;
	GtFolder* m_folder;
}

- (id) initWithArrayOfCameraPhotos:(NSMutableArray*) array folder:(GtFolder*) folder;

- (IBAction) handleDeletePress:(id) sender;
- (IBAction) rotateLeft:(id) sender;
- (IBAction) rotateRight:(id) sender;

@end
#endif