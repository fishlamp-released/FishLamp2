//
//  FLToolbarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/8/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLToolbarItemGroup.h"

#define kDefaultHorizontalPadding 30.0f

@class FLToolbarView;

@interface FLToolbarView : UIView  {
@private
    FLToolbarItemGroup* _leftItems;
    FLToolbarItemGroup* _rightItems;
    FLToolbarItemGroup* _centerItems;
    UIView* _backgroundView;
}

- (id) init; // makes a 320x44 bar by default.
+ (FLToolbarView*) toolbarView;

@property (readwrite, retain, nonatomic) UIView* backgroundView;

- (void) addBackgroundGradientView;
- (void) addFramedBlackBackground;

@property (readonly, retain, nonatomic) FLToolbarItemGroup* leftItems;
@property (readonly, retain, nonatomic) FLToolbarItemGroup* rightItems;
@property (readonly, retain, nonatomic) FLToolbarItemGroup* centerItems;

- (void) visitAllToolbarItems:(FLToolbarViewBlock) visitor;

- (void) viewControllerTitleDidChange:(UIViewController*) viewController;

@end





