//
//	FLMediaPicker.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/5/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLSimpleMediaPicker.h"

@interface FLSimpleMediaPicker ()
@property (readwrite, strong, nonatomic) FLOperationContext* operationContextManager;
@property (readwrite, strong, nonatomic) UIImagePickerController* picker;
@property (readwrite, assign, nonatomic) UIViewController* viewController;
#if USE_POPOVERS
@property (readwrite, strong, nonatomic) FLModalPopoverController* popoverController;
#endif
@end

@implementation FLSimpleMediaPicker

#if USE_POPOVERS
@synthesize popoverController = _popoverController;
#endif
@synthesize viewController = _viewController;
@synthesize pickedCount = _pickedCount;
@synthesize operationContextManager = _operationContext;
@synthesize picker = _picker;

- (id) init {
    self = [super init];
    if(self) {
    	_picker = [[UIImagePickerController alloc] init];
        _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _picker.delegate = self;
    }
    
    return self;
}


- (void) dealloc {
    _picker.delegate = nil;

#if FL_MRC
#if USE_POPOVERS
    [_popoverController release];
#endif
    [_operationContext release];
    [_picker release];
	[super dealloc];
#endif
}

- (void) presentModallyInViewController:(UIViewController*) viewController
                               animated:(BOOL) animated {
	self.viewController = viewController;
	_animated = animated;
	[self.viewController presentModalViewController:self.picker animated:animated];
}

#if USE_POPOVERS
- (FLModalPopoverController*) presentModallyInPopoverFromViewController:(UIViewController*) viewController
                                                                animate:(BOOL) animated {
	self.viewController = viewController;
	_animated = animated;
	
	self.popoverController = [FLModalPopoverController presentViewController:self.picker
		inViewController:viewController 
		permittedArrowDirections:0 
		fromRect:CGRectZero 
		animated:animated 
		isModal:YES];
	
	return self.popoverController;
}

- (FLModalPopoverController*) presentInPopoverFromViewController:(UIViewController*) viewController 
                                        permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
                                                        fromRect:(FLRect) rect
                                                         animate:(BOOL) animated {
	self.viewController = viewController;
	self.animated = animated;
	
	self.popoverController = [FLModalPopoverController presentViewController:self.picker
		inViewController:viewController 
		permittedArrowDirections:arrowDirections 
		fromRect:rect 
		animated:animated 
		isModal:YES];
	
	return _popoverController;
}
#endif

- (void) hideMediaPicker {

    if(!_hidden) {
        _hidden = YES;
        [self.viewController dismissViewControllerAnimated:_animated completion:^{
            [self postObservation:@selector(simpleMediaPickerDidClose:)];
        }];
    }

#if USE_POPOVERS
	else {
		[_popoverController dismissPopoverAnimated:animated];
	}
#endif
}

- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info {

	++_pickedCount;
    FLSimplePhoto* simplePhoto = [FLSimplePhoto simplePhoto:[info objectForKey:UIImagePickerControllerOriginalImage]
                                                       exif:[info objectForKey:UIImagePickerControllerMediaMetadata]
                                                   assetURL:[info objectForKey:UIImagePickerControllerReferenceURL]];
    
    
    [self postObservation:@selector(simpleMediaPicker:didPickPhoto:) withObject:simplePhoto];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
	[self hideMediaPicker];
}

- (void) done:(id) sender {
	[self hideMediaPicker];
}

- (void)navigationController:(UINavigationController *)navigationController 
	willShowViewController:(UIViewController *)viewController 
	animated:(BOOL)animated {
	
    UIBarButtonItem* newItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                             target:self
                                                                             action:@selector(done:)];
	viewController.navigationItem.rightBarButtonItem = newItem;
	FLReleaseWithNil_(newItem);
}


@end



