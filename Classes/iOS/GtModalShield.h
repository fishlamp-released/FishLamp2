//
//	GtViewControllerModalShield.h
//	FishLamp
//
//	Created by Mike Fullerton on 2/21/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

@class GtNavigationBarShieldView;

@interface GtModalShieldView : UIView
@end

@interface GtFingerprintView : GtModalShieldView
@end

@interface GtModalShield : NSObject {
@private
	GtFingerprintView* m_viewShield;
	GtNavigationBarShieldView* m_barShield;
}

- (NSArray*) passThroughViewsForPopover;

- (void) showShieldInViewController:(UIViewController*) viewController;
- (void) hideShield; // deleting the GtModalShield will also hide the shield.

@end
