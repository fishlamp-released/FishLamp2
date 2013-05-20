//
//	UIView+GtAutoLayout.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if VIEW_AUTOLAYOUT

#import <Foundation/Foundation.h>

#import "GtRectLayout.h"
#import "GtViewContentsDescriptor.h"

@interface UIView (GtViewAutoLayout)
- (void) setPositionInSuperview; // override point
@end

@interface UIView (GtViewAutoLayoutInternal)
- (void) setPositionInSuperviewWithRectLayout:(GtRectLayout) rectLayout;
- (void) setPositionInSuperviewWithRectLayout:(GtRectLayout) rectLayout superviewContents:(GtViewContentsDescriptor) superviewContents;
- (void) setSubviewPositions;
@end

#endif
