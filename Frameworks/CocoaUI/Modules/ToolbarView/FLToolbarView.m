//
//  FLToolbarView.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/8/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLToolbarView.h"
#import "FLArrangement.h"
#import "UIImage+FLColorize.h"
#import "FLGradientView.h"
#import "UIViewController+FLAdditions.h"

#import "FLGradientView.h"
#import "FLSingleRowColumnArrangement.h"

#if IOS
#import "UILabel+FLExtras.h"
#endif


@implementation FLToolbarView

@synthesize backgroundView = _backgroundView;
@synthesize leftItems = _leftItems;
@synthesize rightItems = _rightItems;
@synthesize centerItems = _centerItems;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame])) {
		self.backgroundColor = [UIColor clearColor];
#if IOS
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth |
                                UIViewAutoresizingFlexibleRightMargin;
		self.exclusiveTouch = YES;
#endif
		self.autoresizesSubviews = NO;
		self.userInteractionEnabled = YES;

        _leftItems = [[FLToolbarItemGroup alloc] initWithToolbarView:self alignment:FLToolbarItemAlignmentLeft];
        _centerItems = [[FLToolbarItemGroup alloc] initWithToolbarView:self  alignment:FLToolbarItemAlignmentCenter];
        _rightItems = [[FLToolbarItemGroup alloc] initWithToolbarView:self  alignment:FLToolbarItemAlignmentRight];
    }

	return self;
}

- (void) addBackgroundGradientView {
    FLGradientView* gradient = [[FLGradientView alloc] initWithFrame:self.bounds];
#if IOS
    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
#endif
    gradient.alphaValue = 0.6f;
    self.backgroundView = gradient;
    FLRelease(gradient);
}

- (void) addFramedBlackBackground
{
    FLGradientView* gradient = [FLGradientView viewWithFrame:self.bounds];
#if IOS
    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
#endif
    self.backgroundView = gradient;
    [gradient setColorRange:[FLColorRange lightLightGrayGradientColorRange]  forControlState:UIControlStateNormal];
    
}

- (id) init
{
    return [self initWithFrame:CGRectMake(0,0,320,44)];
}

+ (FLToolbarView*) toolbarView
{
    return FLAutorelease([[FLToolbarView alloc] init]);
}

- (void) dealloc
{
    FLRelease(_backgroundView);
	FLRelease(_leftItems);
	FLRelease(_centerItems);
	FLRelease(_rightItems);
	super_dealloc_();
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    if(_backgroundView) {
        _backgroundView.frame = self.bounds;
    }
    
    CGFloat left = self.bounds.origin.x;
    CGFloat right  = FLRectGetRight(self.bounds);
    if(_leftItems && _leftItems.count) {   
        [_leftItems updateSizeInBounds:self.bounds];
        left = FLRectGetRight(_leftItems.frame);
    }
    
    if(_rightItems && _rightItems.count) {
        [_rightItems updateSizeInBounds:self.bounds];
        
        _rightItems.frame = FLRectJustifyRectInRectRight(self.bounds, _rightItems.frame);

        right = _rightItems.frame.origin.x;
    }
    
    if(_centerItems && _centerItems.count) {

        [_centerItems updateSizeInBounds:self.bounds];

        CGRect frame = _centerItems.frame;
        
        frame = FLRectCenterRectInRect(self.bounds, frame);

        if(FLRectGetRight(frame) > right) {
            frame.origin.x = right - frame.size.width;
        }
        
        if(frame.origin.x < left) {
            frame.origin.x = left;
            
            if(FLRectGetRight(frame) > right) {
                frame.size.width = right - left;
            }
        }
        
        _centerItems.frame = frame;
    }
}

- (void) setBackgroundView:(UIView*) backgroundView
{
    if(_backgroundView) {
        [_backgroundView removeFromSuperview];
    }

    FLAssignObjectWithRetain(_backgroundView, backgroundView);
    [self insertSubview:_backgroundView atIndex:0];
    [self setNeedsLayout];
}

- (void) visitAllToolbarItems:(FLToolbarViewBlock) visitor
{
    [_leftItems visitToolbarItems:visitor];
    [_centerItems visitToolbarItems:visitor];
    [_rightItems visitToolbarItems:visitor];
}

- (void) drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    [self visitAllToolbarItems:^(id item) { 
        if(CGRectIntersectsRect(rect, [item frame])){
            [item drawRect:rect];
        }
    }];
}

- (void) viewControllerTitleDidChange:(UIViewController*) viewController
{
    [self visitAllToolbarItems:^(id toolbarItem) {
        [toolbarItem toolbarTitleDidChange:viewController.title];
        }];

// TODO: fix this or delete it

//    self.title = viewController.title;
//    if(self.backButton)
//    {
//        [self backButton].title = viewController.backButtonTitle;
//    }
    [self setNeedsLayout];
}

- (void) viewControllerViewWillAppear:(UIViewController*) viewController
{
    [self viewControllerTitleDidChange:viewController];
}

#if IOS
- (void) viewController:(UIViewController*) viewController
willBePushedOnNavigationController:(UINavigationController *)controller
{

// TODO: fix this or delete it

//    if(self.automaticallyShowBackButton && !self.backButton)
//    {
//        [self addBackButton:viewController.backButtonTitle target:controller action:@selector(respondToBackButtonPress:)];
//    }
}
#endif

@end







