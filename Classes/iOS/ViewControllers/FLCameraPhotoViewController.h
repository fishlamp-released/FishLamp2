//
//	FLCameraPhotoViewController.h
//	FishLamp
//
//	Created by Mike Fullerton on 7/31/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLPhotoViewController.h"

#if FL_CUSTOM_CAMERA
@class FLCameraPhoto;

@interface FLCameraPhotoViewController : FLPhotoViewController<FLPhotoViewControllerDelegate> {
@private
	NSMutableArray* _array;
//	  float _angle;
	FLFolder* _folder;
}

- (id) initWithArrayOfCameraPhotos:(NSMutableArray*) array folder:(FLFolder*) folder;

- (IBAction) handleDeletePress:(id) sender;
- (IBAction) rotateLeft:(id) sender;
- (IBAction) rotateRight:(id) sender;

@end
#endif