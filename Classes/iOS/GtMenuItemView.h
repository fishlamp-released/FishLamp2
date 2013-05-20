//
//  GtMenuItemView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGradientView.h"
#import "GtCallback.h"

#import "GtGradientColorPair.h"

@class GtMenuView;

@interface GtMenuItemColors : NSObject  {
@private
    GtGradientColorPair* m_backgroundColors;
    GtGradientColorPair* m_highlightedColors;
}

@property (readonly, retain, nonatomic) GtGradientColorPair* backgroundGradientColors;
@property (readonly, retain, nonatomic) GtGradientColorPair* highlightedGradientColors;

- (id) initWithBackgroundGradientColors:(GtGradientColorPair*) backgroundGradientColors
              highlightedGradientColors:(GtGradientColorPair*) highlightedGradientColors;

+ (GtMenuItemColors*) menuItemColors:(GtGradientColorPair*) backgroundGradientColors
           highlightedGradientColors:(GtGradientColorPair*) highlightedGradientColors;

+ (GtMenuItemColors*) defaultMenuItemColors;
+ (GtMenuItemColors*) deleteMenuItemColors;

@end

@protocol GtMenuItemViewDelegate;

typedef enum {
    GtMenuItemViewDisclosureArrowSideLeft,
    GtMenuItemViewDisclosureArrowSideRight
} GtMenuItemViewDisclosureArrowSide;

@interface GtMenuItemView : UIView {
@private
    GtCallback m_callback;
    
    id<GtMenuItemViewDelegate> m_delegate;
    
    GtGradientView* m_gradient;
    UIImageView* m_imageView;
    UILabel* m_label;
    GtMenuItemColors* m_colors;
    UIImageView* m_disclosureView;
    GtMenuItemViewDisclosureArrowSide m_arrowSide;
    GtMenuView* m_menuView;
    
    id m_subMenu;
    id m_userData;
    BOOL m_disabled;
    BOOL m_highlighted;
}

@property (readwrite, assign, nonatomic) id<GtMenuItemViewDelegate> delegate;

@property (readonly, assign, nonatomic) NSInteger indexInMenu;

@property (readonly, assign, nonatomic) GtMenuView* menuView;


@property (readonly, retain, nonatomic) UILabel* titleLabel;
@property (readonly, retain, nonatomic) UIImageView* imageView;
@property (readonly, retain, nonatomic) UIImageView* disclosureArrowView;

@property (readwrite, assign, nonatomic) BOOL disabled;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;

// callback is ignored if there's a submenu.
@property (readwrite, assign, nonatomic) GtCallback callback;
@property (readwrite, retain, nonatomic) id subMenu;

@property (readwrite, retain, nonatomic) NSString* title;
@property (readwrite, retain, nonatomic) UIImage* image;
@property (readwrite, retain, nonatomic) GtMenuItemColors* colors;

@property (readwrite, retain, nonatomic) id userData;

- (id) initWithTitle:(NSString*) title target:(id) target action:(SEL) action;

+ (GtMenuItemView*) menuItemView:(NSString*) title target:(id) target action:(SEL) action;

- (void) beginSelectedAnimation;

@end

@protocol GtMenuItemViewDelegate <NSObject>
- (void) menuItemView:(GtMenuItemView*) view touchesEnded:(BOOL) wasSelected;
- (void) menuItemView:(GtMenuItemView*) view touchesMoved:(BOOL) touchIsInside;
- (void) menuItemViewTouchesCancelled:(GtMenuItemView*) view;
- (void) menuItemViewFinishedSelectAnimation:(GtMenuItemView*) view;
@end
