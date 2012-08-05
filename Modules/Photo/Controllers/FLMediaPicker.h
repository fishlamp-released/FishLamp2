//
//	FLMediaPicker.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/5/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLImageAsset.h"
#import "FLLegacyProgressView.h"
#import "FLManagedActionContext.h"
#import "FLWeakReference.h"

// Note: I hate this code and want to delete it. So there.

@class FLModalPopoverController;
@class FLAction;
@class FLOverlayCameraView;

@protocol FLMediaPickerDelegate;

@interface FLMediaPicker : NSObject<UIImagePickerControllerDelegate, 
									UINavigationControllerDelegate,
									FLActionContextDelegate,
									CLLocationManagerDelegate,
									UIPopoverControllerDelegate> {
	UIImagePickerController* m_picker;
	CLLocationManager* m_locationManager;
	
	id<FLMediaPickerDelegate> m_delegate;
	FLManagedActionContext* m_actionContext;
	NSString* m_helpFileName;
	
	UIViewController* m_controller;
	FLModalPopoverController* m_popoverController;
		
	NSUInteger m_savedImageCount;
	ALAssetsLibrary* m_assetsLibrary;
    
    FLOverlayCameraView* m_overlayView;

	struct {
		unsigned int animated:1;
		unsigned int busy:1;
        unsigned int locationEnabled:1;
	} m_flags;
}

+ (FLMediaPicker*) instance;

- (void) beginTakePhoto:(UIViewController*) inController 
			   animated:(BOOL) animated 
			   delegate:(id<FLMediaPickerDelegate>) delegate
               geoTagPhoto:(BOOL) geoTagPhoto;

#if DEPRECATED_ASSETS_PICKER
- (void) beginChoosePhotoFromLibraryWithDelegate:(id<FLMediaPickerDelegate>) inDelegate;
#endif

- (void) presentModallyInViewController:(UIViewController*) viewController animated:(BOOL) animated;
- (FLModalPopoverController*) presentModallyInPopoverFromViewController:(UIViewController*) viewController animate:(BOOL) animated;
- (FLModalPopoverController*) presentInPopoverFromViewController:(UIViewController*) viewController 
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animate:(BOOL) animated;
	
@property (readonly, assign, nonatomic) UIImagePickerControllerSourceType sourceType;
@property (readonly, retain, nonatomic) UIImagePickerController* picker;

@property (readonly, assign, nonatomic) NSUInteger savedImageCount;
@property (readwrite, assign, nonatomic) BOOL animated;
@property (readonly, assign, nonatomic) BOOL busy;

@end

@protocol FLMediaPickerDelegate <NSObject>

- (void) mediaPicker:(FLMediaPicker*) picker 
	didFinishPickingImage:(id<FLImageAsset>) image 
			isCameraImage:(BOOL) isCameraImage;
			
@optional

- (void) mediaPicker:(FLMediaPicker*) picker 
	configureActionProgress:(FLAction*) action;

@end
