//
//	GtModalPopoverController.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/23/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtModalShield.h"
#import "GtCallbackObject.h"
#import "GtCallback.h"

@interface GtModalPopoverController : UIPopoverController<UIPopoverControllerDelegate> {
	BOOL m_isModal;
	GtModalShield* m_shield;
	GtCallback m_wasDismissedCallback;
}
@property (readwrite, assign, nonatomic) GtCallback wasDismissedCallback;

@property (readonly, assign, nonatomic,getter=isModal) BOOL modal;

- (id) initWithContentViewController:(UIViewController*) controller isModal:(BOOL) isModal;

- (UINavigationController*) navigationController; // if content controller is a GtNavigationControllerViewController, return it's rootNavigationController; 

+ (GtModalPopoverController*) presentViewController:(UIViewController*) contentController
	inViewController:(UIViewController*) inViewController
	permittedArrowDirections:(UIPopoverArrowDirection)arrowDirections
	fromRect:(CGRect) rect
	animated:(BOOL) animated
	isModal:(BOOL) isModal;

+ (GtModalPopoverController*) modalPopoverControllerForViewController:(UIViewController*) controller;
	
@end

