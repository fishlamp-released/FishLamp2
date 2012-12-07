//
//  FLAutoPositionedViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewController.h"
#import "FLContentMode.h"
#import "FLModalShield.h"

@interface UIView (FLAutoPositionedViewController) 
- (void) overrideViewPositionIfNeeded:(FLContentMode*) position; // does nothing by default.
@end

@interface FLAutoPositionedViewController : FLViewController {
@private
    FLContentMode _contentMode;
    CGFloat _viewAlpha;
}

// default view size, this is the size the view will START with
// but it'll probably be adusted by the view.
+ (FLSize) defaultAutoPostionedViewSize;

// this is passed onto the view. 
@property (readwrite, assign, nonatomic) CGFloat viewAlpha;

// this tells us how and where to position the view.
@property (readwrite, assign, nonatomic) FLContentMode contentMode;

// this will resize and reposition the view.
- (void) updateViewSizeAndPosition; // gets bounds from parentSuperviewController.view
- (void) updateViewSizeAndPosition:(CGRect) inBounds;


// override these.
- (void) sizeToFitInBounds:(CGRect) bounds;
- (UIView*) createAutoPositionedViewWithFrame:(CGRect) frame;

// this is the bounds that the view will be shown in, adjusted for contents
// of view determined by FLViewContentsDescriptor.
- (CGRect) maxVisibleRect:(BOOL) adjustingForKeyboard;

- (void) viewMayOverridePosition;

@end
