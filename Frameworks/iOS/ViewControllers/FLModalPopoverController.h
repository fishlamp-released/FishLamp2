//
//	FLModalPopoverController.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
	fromRect:(CGRect) rect
	animated:(BOOL) animated
	isModal:(BOOL) isModal;

+ (FLModalPopoverController*) modalPopoverControllerForViewController:(UIViewController*) controller;
	
@end

