//
//	FLModalPopoverController.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLModalShield.h"
#import "FLCallbackObject.h"
#import "FLCallback_t.h"

@interface FLModalPopoverController : UIPopoverController<UIPopoverControllerDelegate> {
	BOOL _isModal;
	FLModalShield* _shield;
	FLCallback_t _wasDismissedCallback;
}
@property (readwrite, assign, nonatomic) FLCallback_t wasDismissedCallback;

@property (readonly, assign, nonatomic,getter=isModal) BOOL modal;

- (id) initWithContentViewController:(UIViewController*) controller isModal:(BOOL) isModal;

- (UINavigationController*) navigationController; // if content controller is a FLNavigationControllerViewController, return it's rootNavigationController; 

+ (FLModalPopoverController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) inViewController
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(FLRect) rect
	animated:(BOOL) animated
	isModal:(BOOL) isModal;

+ (FLModalPopoverController*) modalPopoverControllerForViewController:(UIViewController*) controller;
	
@end

