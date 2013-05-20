//
//  GtViewFader.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtViewAnimator.h"

#define GtFadeDuration 0.3

@interface GtViewFader : NSObject<GtViewAnimatorProtocol> {

}

GtDefaultProperty(GtViewFader, ViewFader);

- (void) createWindowWithSubview:(UIView*) subview outWindow:(UIWindow**) outWindow;
- (void) releaseWindow:(UIWindow*) window;

@end
