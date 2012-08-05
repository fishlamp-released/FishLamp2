//
//  FLMenuItemView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright 2011 Greentongue Software. All rights reserved.
//

#import "FLGradientView.h"
#import "FLCallback.h"
#import "FLColorRange.h"

@class FLMenuView;

//@interface FLViewGradients (FLMenuItem)
//
//+ (FLViewGradients*) defaultMenuItemColors;
//+ (FLViewGradients*) deleteMenuItemColors;
//
//@end

@protocol FLMenuItemViewDelegate;

typedef enum {
    FLMenuItemViewDisclosureArrowSideLeft,
    FLMenuItemViewDisclosureArrowSideRight
} FLMenuItemViewDisclosureArrowSide;

@interface FLMenuItemView : UIView {
@private
    FLCallback _callback;
    
    id<FLMenuItemViewDelegate> _delegate;
    
    FLGradientView* _gradientView;
    UIImageView* _imageView;
    UILabel* _label;
    UIImageView* _disclosureView;
    FLMenuItemViewDisclosureArrowSide _arrowSide;
    FLMenuView* _menuView;
    
    id _subMenu;
    id _userData;
    BOOL _disabled;
    BOOL _highlighted;
}

@property (readwrite, assign, nonatomic) id<FLMenuItemViewDelegate> delegate;

@property (readonly, assign, nonatomic) NSInteger indexInMenu;

@property (readonly, assign, nonatomic) FLMenuView* menuView;

@property (readonly, retain, nonatomic) UILabel* titleLabel;
@property (readonly, retain, nonatomic) UIImageView* imageView;
@property (readonly, retain, nonatomic) UIImageView* disclosureArrowView;

@property (readwrite, assign, nonatomic) BOOL disabled;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

// callback is ignored if there's a submenu.
@property (readwrite, assign, nonatomic) FLCallback callback;
@property (readwrite, retain, nonatomic) id subMenu;

@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, retain, nonatomic) FLViewGradients* gradientColors;

@property (readwrite, retain, nonatomic) id userData;

- (id) initWithTitle:(NSString*) title target:(id) target action:(SEL) action;

- (id) initWithTitle:(NSString*) title submenu:(id) submenu;

+ (FLMenuItemView*) menuItemView:(NSString*) title target:(id) target action:(SEL) action;

+ (FLMenuItemView*) menuItemView:(NSString*) title submenu:(id) submenu;


- (void) beginSelectedAnimation;

@end

@protocol FLMenuItemViewDelegate <NSObject>
- (void) menuItemView:(FLMenuItemView*) view touchesEnded:(BOOL) wasSelected;
- (void) menuItemView:(FLMenuItemView*) view touchesMoved:(BOOL) touchIsInside;
- (void) menuItemViewTouchesCancelled:(FLMenuItemView*) view;
- (void) menuItemViewFinishedSelectAnimation:(FLMenuItemView*) view;
@end
