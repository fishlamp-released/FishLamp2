//
//	FLViewControllerModalShield.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
