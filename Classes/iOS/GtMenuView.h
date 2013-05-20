//
//  GtMenuView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuItemView.h"
#import "GtMenuHeaderView.h"

#import "GtCellViewLayout.h"

@protocol GtMenuViewDelegate;

@interface GtMenuView : UIView<GtCellViewLayoutDelegate> {
@private 
    id<GtMenuViewDelegate> m_delegate;
    GtMenuHeaderView* m_titleView;
    BOOL m_madeSelection;
    BOOL m_touching;
    NSMutableArray* m_menuItems;
    CGSize m_menuItemSize;
}

@property (readwrite, assign, nonatomic) id<GtMenuViewDelegate> delegate;

@property (readwrite, assign, nonatomic) CGSize menuItemSize;
@property (readwrite, retain, nonatomic) NSString* menuTitle;

- (void) clearDelegates;

- (void) addDivider;
              
- (void) addMenuItem:(GtMenuItemView*) menuItem;              

- (NSInteger) indexForMenuItemView:(GtMenuItemView*) menuItemView; 

- (CGFloat) findOptimalWidth;
                 
@end

@protocol GtMenuViewDelegate <NSObject>
- (void)menuViewTouchesBegan:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesMoved:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesEnded:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesCancelled:(GtMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end
