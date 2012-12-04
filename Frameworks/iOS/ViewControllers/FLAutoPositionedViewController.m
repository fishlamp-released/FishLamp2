//
//  FLAutoPositionedViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/23/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAutoPositionedViewController.h"
#import "FLKeyboardManager.h"

@implementation  UIView (FLAutoPositionedViewController) 

- (void) overrideViewPositionIfNeeded:(FLContentMode*) position {
}

@end


@interface FLAutoPositionedViewController ()
@end

@implementation FLAutoPositionedViewController

@synthesize contentMode = _contentMode;
@synthesize viewAlpha = _viewAlpha;

- (id) init {
    self = [super init];
    if(self) {
        self.contentMode = FLContentModeCentered;   
    }
    return self;   
}

+ (FLSize) defaultAutoPostionedViewSize {
    return FLSizeMake(200,200);
}

- (BOOL) viewEnclosesStatusBar {
    return NO;
}

- (void) viewMayOverridePosition {
    [self.view overrideViewPositionIfNeeded:&_contentMode];
}

- (void) viewDidLoad {
    [super viewDidLoad];
    [self viewMayOverridePosition];
}

- (void) viewWillAppear:(BOOL) animated {
    [self updateViewSizeAndPosition:self.parentViewController.view.bounds];
    [super viewWillAppear:animated];
}

- (void) willPresentInViewController {
    [super willPresentInViewController];
    [self updateViewSizeAndPosition:self.parentViewController.view.bounds];
}

- (void) didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
    [super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
    [self updateViewSizeAndPosition:self.parentViewController.view.bounds];
}

- (void) updateViewSizeAndPosition {
    [self updateViewSizeAndPosition:self.parentViewController.view.bounds];
}

- (void) updateViewSizeAndPosition:(FLRect) inBounds {
    [self sizeToFitInBounds:inBounds];
    self.view.frameOptimizedForLocation = FLRectPositionRectInRectWithContentMode(
        [self contentViewFrameInBounds:inBounds], self.view.frame, self.contentMode);
}

- (void) sizeToFitInBounds:(FLRect) bounds {
    [self.view sizeToFit];
}

- (FLRect) maxVisibleRect:(BOOL) adjustingForKeyboard {
	if(self.view.superview) {

// TODO: why is this here?
        FLAssertIsImplemented_();

		FLRect maxVisibleRect = self.view.superview.bounds;

		FLRect keyboardRect = CGRectZero;
		if(adjustingForKeyboard) {
			keyboardRect = FLRectJustifyRectInRectBottom(maxVisibleRect, [[FLKeyboardManager instance] keyboardRectForView:self.view.superview]);
		}

		maxVisibleRect.origin.y = self.contentViewInsetTop; 
		maxVisibleRect.size.height -= (maxVisibleRect.origin.y);
		
        if(adjustingForKeyboard){
            maxVisibleRect.size.height -= keyboardRect.size.height;
        }
        else {
            maxVisibleRect.size.height -= self.contentViewInsetBottom;
        }
		return maxVisibleRect;
	}
	
	return CGRectZero;
}

- (UIView*) createAutoPositionedViewWithFrame:(FLRect) frame {
    return nil;
}

- (UIView*) createView {
    return [self createAutoPositionedViewWithFrame:FLRectMakeWithSize([[self class] defaultAutoPostionedViewSize])];
}
@end
