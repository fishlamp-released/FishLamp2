//
//	GtViewFader.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewAnimatorProtocol.h"

#define GtFadeDuration 0.3

@interface GtViewFader : NSObject<GtViewAnimatorProtocol> {

}

GtDefaultProperty(GtViewFader, ViewFader);

- (void) createWindowWithSubview:(UIView*) subview outWindow:(UIWindow**) outWindow;
- (void) releaseWindow:(UIWindow*) window;

- (void) insertSubview:(UIView*) view belowSubview:(UIView*) subView superview:(UIView*) superview;
- (void) insertSubview:(UIView*) view aboveSubview:(UIView*) subView superview:(UIView*) superview;

@end


@interface GtNewViewFader : NSObject {
	UIView* m_view;
}

- (void) addSubview:(UIView*) view 
		  superview:(UIView*) superview;
		  
- (void) removeFromSuperview:(UIView*) view;

@end