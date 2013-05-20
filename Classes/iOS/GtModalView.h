//
//	GtProgressViewBaseClass.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/26/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtModalShield.h"

@interface GtModalView : UIView {
@private
	GtModalShield* m_shield;
	NSTimeInterval m_showDelay;
	BOOL m_modal;
}

@property (readwrite, assign, nonatomic, getter=isModal) BOOL modal;
@property (readwrite, assign, nonatomic) NSTimeInterval showDelay;

- (void) showInSuperview:(UIView*) superview delay:(NSTimeInterval) delay;
- (void) showInViewController:(UIViewController*) viewController isModal:(BOOL) isModal delay:(NSTimeInterval) delay;
- (void) hideModalView;

@end
