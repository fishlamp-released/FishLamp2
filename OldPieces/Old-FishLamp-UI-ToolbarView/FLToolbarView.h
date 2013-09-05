//
//  FLToolbarView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 3/8/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaUIRequired.h"
#import "FLToolbarItemGroup.h"

#define kDefaultHorizontalPadding 30.0f

@class FLToolbarView;

@interface FLToolbarView : FLCompatibleView  {
@private
    FLToolbarItemGroup* _leftItems;
    FLToolbarItemGroup* _rightItems;
    FLToolbarItemGroup* _centerItems;
    SDKView* _backgroundView;
}

- (id) init; // makes a 320x44 bar by default.
+ (FLToolbarView*) toolbarView;

@property (readwrite, retain, nonatomic) SDKView* backgroundView;

- (void) addBackgroundGradientView;
- (void) addFramedBlackBackground;

@property (readonly, retain, nonatomic) FLToolbarItemGroup* leftItems;
@property (readonly, retain, nonatomic) FLToolbarItemGroup* rightItems;
@property (readonly, retain, nonatomic) FLToolbarItemGroup* centerItems;

- (void) visitAllToolbarItems:(FLToolbarViewBlock) visitor;

- (void) viewControllerTitleDidChange:(SDKViewController*) viewController;

@end





