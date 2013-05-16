//
//  GtMediaPicker.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/5/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//


#if DEBUG
#define TEST_PICTURE_UI 1
#endif

#import "GtPhoto.h"
#import "GtBusyView.h"
#import "GtManagedActionContext.h"

@interface GtMediaPicker : NSObject<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
	UIImagePickerController* m_picker;
	id m_delegate;
	GtManagedActionContext* m_actionContext;
}

+ (GtMediaPicker*) instance;

- (void) beginTakePhoto:(UIViewController*) inController 
               animated:(BOOL) animated 
			   delegate:(id) delegate;
			   
- (void) beginChoosePhotoFromLibrary:(UIViewController*) inController 
							animated:(BOOL) animated 
							delegate:(id) delegate;

- (void) dismissPicker:(BOOL) animated;

@end

@protocol GtMediaPickerDelegate <NSObject>

- (void) mediaPicker:(GtMediaPicker*) picker 
	didFinishPickingImage:(GtPhoto*) image 
	        isCameraImage:(BOOL) isCameraImage;

@optional
- (void) mediaPickerDidCancel:(GtMediaPicker*) picker;
- (void) mediaPicker:(GtMediaPicker*) picker configureActionProgress:(GtAction*) action;

// TODO: add didFinishPickingMovie

@end
