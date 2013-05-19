//
//  FLMenuView.h
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMenuItemView.h"
#import "FLMenuHeaderView.h"

#import "FLArrangement.h"

@protocol FLMenuViewDelegate;

@interface FLMenuView : UIView {
@private 
    __unsafe_unretained id<FLMenuViewDelegate> _delegate;
    FLMenuHeaderView* _titleView;
    BOOL _madeSelection;
    BOOL _touching;
    NSMutableArray* _menuItems;
    CGSize _menuItemSize;
}

@property (readwrite, assign, nonatomic) id<FLMenuViewDelegate> delegate;

@property (readwrite, assign, nonatomic) CGSize menuItemSize;
@property (readwrite, retain, nonatomic) NSString* menuTitle;

- (void) clearDelegates;

- (void) addDivider;
              
- (void) addMenuItem:(FLMenuItemView*) menuItem;              
- (void) addMenuItem:(FLMenuItemView*) menuItem configureMenuItem:(FLObjectBlock) configure;              

- (NSInteger) indexForMenuItemView:(FLMenuItemView*) menuItemView; 

- (CGFloat) findOptimalWidth;
                 
@end

@protocol FLMenuViewDelegate <NSObject>
- (void)menuViewTouchesBegan:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesMoved:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesEnded:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)menuViewTouchesCancelled:(FLMenuView*) menu touches:(NSSet *)touches withEvent:(UIEvent *)event;
@end
