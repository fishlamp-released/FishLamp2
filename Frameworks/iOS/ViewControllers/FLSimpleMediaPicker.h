//
//	FLMediaPicker.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/5/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLImageAsset.h"
#import "FLLegacyProgressView.h"
#import "FLObservable.h"
#import "FLSimplePhoto.h"

#if USE_POPOVERS
#import "FLModalPopoverController.h"
#endif

@interface FLSimpleMediaPicker : FLObservable<UIImagePickerControllerDelegate,
									UINavigationControllerDelegate,
									UIPopoverControllerDelegate> {
	UIImagePickerController* _picker;

#if USE_POPOVERS
	FLModalPopoverController* _popoverController;
#endif
    __unsafe_unretained UIViewController* _viewController;
	
	NSUInteger _pickedCount;
	BOOL _animated;
    BOOL _hidden;
}

@property (readonly, assign, nonatomic) NSUInteger pickedCount;

- (void) presentModallyInViewController:(UIViewController*) viewController
                               animated:(BOOL) animated;

- (void) hideMediaPicker;

#if USE_POPOVERS
// e.g. apple's popovers in their sdk (not a fan of these).

- (FLModalPopoverController*) presentModallyInPopoverFromViewController:(UIViewController*) viewController
                                                                animate:(BOOL) animated;

- (FLModalPopoverController*) presentInPopoverFromViewController:(UIViewController*) viewController
                                        permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                                                        fromRect:(CGRect) rect
                                                         animate:(BOOL) animated;
#endif
@end

@protocol FLSimpleMediaPickerObserver <FLObserver>
@optional

- (void) simpleMediaPicker:(FLSimpleMediaPicker*) picker
              didPickPhoto:(FLSimplePhoto*) photo;

- (void) simpleMediaPickerDidClose:(FLSimpleMediaPicker*) picker;
@end
