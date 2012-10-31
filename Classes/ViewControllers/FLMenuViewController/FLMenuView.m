//
//  FLMenuView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright 2011 Greentongue Software. All rights reserved.
//

#import "FLMenuView.h"
#import "FLVerticalGridArrangement.h"


@interface UIView (FLMenuView)
- (void) handleTouch:(FLPoint) point;
- (void) handleSelect:(FLPoint) point;
- (CGFloat) optimalWidth;
- (void) handleCancel;
- (void) _clearMenuViewDelegates;
@end

@implementation UIView (FLMenuView)

- (void) handleTouch:(FLPoint) point {
    for(UIView* view in self.subviews) {
        [view handleTouch:[view convertPoint:point fromView:self]];
    }
}

- (void) handleSelect:(FLPoint) point {
    for(UIView* view in self.subviews) {
        [view handleSelect:[view convertPoint:point fromView:self]];
    }
}

- (void) handleCancel {
    for(UIView* view in self.subviews) {
        [view handleCancel];
    }
}

- (CGFloat) optimalWidth {
    CGFloat width = 0;
    
    for(UIView* view in self.subviews) {
        width = MAX(width, [view optimalWidth]);
    }
    
    return width;
}

- (void) _clearMenuViewDelegates {
    for(UIView* view in self.subviews) {
        [view _clearMenuViewDelegates];
    }
}

@end

@implementation FLMenuView

@synthesize delegate = _delegate;
@synthesize menuItemSize = _menuItemSize;

- (void) clearDelegates {
    self.delegate = nil;
    [self _clearMenuViewDelegates];
}

- (CGFloat) findOptimalWidth {
    return [super optimalWidth];
}

- (NSString*) menuTitle {
    return _titleView.menuHeaderTitle;
}

- (void) setMenuTitle:(NSString *)menuTitle {
    _titleView.menuHeaderTitle = menuTitle;
    _titleView.hidden = FLStringIsEmpty(menuTitle);
}

- (id) initWithFrame:(FLRect) frame {
    if((self = [super initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.backgroundColor = [UIColor clearColor];
        _menuItemSize = FLSizeMake(100, 50);
        
        FLVerticalGridArrangement* layout = [FLVerticalGridArrangement verticalGridArrangement];
        layout.onWillArrange = ^(id theLayout, FLRect bounds) {
            [theLayout setColumnCount:bounds.size.width / _menuItemSize.width];
            [theLayout setCellHeight:_menuItemSize.height];
        };
        
        self.arrangement = layout;

        _titleView = [[FLMenuHeaderView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, 40)];
        _titleView.hidden = YES;
        [self addSubview:_titleView];
        
        _menuItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) setMenuItemSize:(FLSize) menuItemSize {
    _menuItemSize = menuItemSize;
    [self layoutSubviewsWithArrangement:self.arrangement adjustViewSize:YES];
}

- (void) dealloc {
    mrc_release_(_menuItems);
    mrc_release_(_titleView);
    mrc_super_dealloc_();
}

//- (FLSize) layoutSubviewsWithArrangement
//{
//    if(self.autoSetWidth)
//    {
//        self.frameOptimizedForSize = FLRectSetWidth(self.frame, [self optimalWidth]);
//    }
//
//    FLSize size = [super layoutSubviewsWithArrangement];
//    self.frameOptimizedForLocation = FLRectSetSizeWithSize(self.frame, size);
//    
//    return size;
//}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ : %@: %@", [super description], self.menuTitle, [self.subviews description]];
}

- (void) _touch:(NSSet *)touches withEvent:(UIEvent *)event {
    if(!_touching) {
        _touching = YES;
        _madeSelection = NO;
    }
    
    if(!_madeSelection) {
        UITouch* touch = [touches anyObject];
        FLPoint point = [touch locationInView:self];
        [self handleTouch:point];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate menuViewTouchesBegan:self touches:touches withEvent:event];
    [self _touch:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate menuViewTouchesMoved:self touches:touches withEvent:event];
    [self _touch:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate menuViewTouchesEnded:self touches:touches withEvent:event];
    _touching = NO;
    
    if(!_madeSelection) {
        _madeSelection = YES;
        
        UITouch* touch = [touches anyObject];
        FLPoint point = [touch locationInView:self];

        [self handleSelect:point];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [_delegate menuViewTouchesCancelled:self touches:touches withEvent:event];
    _touching = NO;
    [self handleCancel];
}

- (NSInteger) indexForMenuItemView:(FLMenuItemView*) menuItemView {
    return [_menuItems indexOfObject:menuItemView];
}

- (void) addMenuItem:(FLMenuItemView*) menuItem {
    [self addSubview:menuItem];
    [_menuItems addObject:menuItem];
}

- (void) addMenuItem:(FLMenuItemView*) menuItem configureMenuItem:(FLObjectBlock) configure {
    [self addMenuItem:menuItem];
  
    if(configure) {
        configure(menuItem);
    }
}

- (void) addDivider {
}


@end
