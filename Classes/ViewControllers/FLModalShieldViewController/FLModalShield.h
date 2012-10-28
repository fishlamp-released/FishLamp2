//
//	FLViewControllerModalShield.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLNavigationBarShieldView;

@interface FLModalShieldView : UIView
@end

@interface FLFingerprintView : FLModalShieldView
@end

@interface FLModalShield : NSObject {
@private
	FLFingerprintView* _viewShield;
	FLNavigationBarShieldView* _barShield;
}

- (NSArray*) passThroughViewsForPopover;

- (void) showShieldInViewController:(UIViewController*) viewController;
- (void) hideShield; // deleting the FLModalShield will also hide the shield.

@end
