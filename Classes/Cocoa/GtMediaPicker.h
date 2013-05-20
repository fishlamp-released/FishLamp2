//
//	GtMediaPicker.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/5/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageAsset.h"
#import "GtOldProgressView.h"
#import "GtManagedActionContext.h"
#import "GtWeakReference.h"

// Note: I hate this code and want to delete it. So there.

@class GtModalPopoverController;
@class GtAction;
@class GtOverlayCameraView;

@protocol GtMediaPickerDelegate;

@interface GtMediaPicker : NSObject<UIImagePickerControllerDelegate, 
									UINavigationControllerDelegate,
									GtActionContextDelegate,
									CLLocationManagerDelegate,
									UIPopoverControllerDelegate> {
	UIImagePickerController* m_picker;
	CLLocationManager* m_locationManager;
	
	id<GtMediaPickerDelegate> m_delegate;
	GtManagedActionContext* m_actionContext;
	NSString* m_helpFileName;
	
	UIViewController* m_controller;
	GtModalPopoverController* m_popoverController;
		
	NSUInteger m_savedImageCount;
	ALAssetsLibrary* m_assetsLibrary;
    
    GtOverlayCameraView* m_overlayView;

	struct {
		unsigned int animated:1;
		unsigned int busy:1;
        unsigned int locationEnabled:1;
	} m_flags;
}

+ (GtMediaPicker*) instance;

- (void) beginTakePhoto:(UIViewController*) inController 
			   animated:(BOOL) animated 
			   delegate:(id<GtMediaPickerDelegate>) delegate
               geoTagPhoto:(BOOL) geoTagPhoto;

#if DEPRECATED_ASSETS_PICKER
- (void) beginChoosePhotoFromLibraryWithDelegate:(id<GtMediaPickerDelegate>) inDelegate;
#endif

- (void) presentModallyInViewController:(UIViewController*) viewController animated:(BOOL) animated;
- (GtModalPopoverController*) presentModallyInPopoverFromViewController:(UIViewController*) viewController animate:(BOOL) animated;
- (GtModalPopoverController*) presentInPopoverFromViewController:(UIViewController*) viewController 
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animate:(BOOL) animated;
	
@property (readonly, assign, nonatomic) UIImagePickerControllerSourceType sourceType;
@property (readonly, retain, nonatomic) UIImagePickerController* picker;

@property (readonly, assign, nonatomic) NSUInteger savedImageCount;
@property (readwrite, assign, nonatomic) BOOL animated;
@property (readonly, assign, nonatomic) BOOL busy;

@end

@protocol GtMediaPickerDelegate <NSObject>

- (void) mediaPicker:(GtMediaPicker*) picker 
	didFinishPickingImage:(id<GtImageAsset>) image 
			isCameraImage:(BOOL) isCameraImage;
			
@optional

- (void) mediaPicker:(GtMediaPicker*) picker 
	configureActionProgress:(GtAction*) action;

@end
