//
//  GtMenuView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuView.h"
#import "GtVerticalGridViewLayout.h"

@interface UIView (GtMenuView)
- (void) handleTouch:(CGPoint) point;
- (void) handleSelect:(CGPoint) point;
- (CGFloat) optimalWidth;
- (void) handleCancel;
- (void) _clearMenuViewDelegates;
@end

@implementation UIView (GtMenuView)

- (void) handleTouch:(CGPoint) point
{
    for(UIView* view in self.subviews)
    {
        [view handleTouch:[view convertPoint:point fromView:self]];
    }
}

- (void) handleSelect:(CGPoint) point
{
    for(UIView* view in self.subviews)
    {
        [view handleSelect:[view convertPoint:point fromView:self]];
    }
}

- (void) handleCancel
{
    for(UIView* view in self.subviews)
    {
        [view handleCancel];
    }
}

- (CGFloat) optimalWidth
{
    CGFloat width = 0;
    
    for(UIView* view in self.subviews)
    {
        width = MAX(width, [view optimalWidth]);
    }
    
    return width;
}

- (void) _clearMenuViewDelegates
{
    for(UIView* view in self.subviews)
    {
        [view _clearMenuViewDelegates];
    }
}

@end

@implementation GtMenuView

@synthesize delegate = m_delegate;
@synthesize menuItemSize = m_menuItemSize;

- (void) clearDelegates
{
    self.delegate = nil;
    [self _clearMenuViewDelegates];
}

- (CGFloat) findOptimalWidth
{
    return [super optimalWidth];
}

- (NSString*) menuTitle
{
    return m_titleView.menuHeaderTitle;
}

- (void) setMenuTitle:(NSString *)menuTitle
{
    m_titleView.menuHeaderTitle = menuTitle;
    m_titleView.hidden = GtStringIsEmpty(menuTitle);
}

- (CGSize) cellViewLayoutGetCellSize:(GtCellViewLayout*) layout
{
    return m_menuItemSize;
}

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.userInteractionEnabled = YES;
        self.multipleTouchEnabled = YES;
        self.autoresizesSubviews = NO;
        self.autoresizingMask = UIViewAutoresizingNone;
        self.backgroundColor = [UIColor clearColor];
        m_menuItemSize = CGSizeMake(100, 50);
        self.viewLayout  = [GtVerticalGridViewLayout gridViewLayout:self];
        
        m_titleView = [[GtMenuHeaderView alloc] initWithFrame:CGRectMake(0,0, frame.size.width, 40)];
        m_titleView.hidden = YES;
        [self addSubview:m_titleView];
        
        m_menuItems = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void) setMenuItemSize:(CGSize) menuItemSize
{
    m_menuItemSize = menuItemSize;
    [self layoutSubviewsWithViewLayout];
}

- (void) dealloc
{
    GtRelease(m_menuItems);
    GtRelease(m_titleView);
    GtSuperDealloc();
}

//- (CGSize) layoutSubviewsWithViewLayout
//{
//    if(self.autoSetWidth)
//    {
//        self.frameOptimizedForSize = GtRectSetWidth(self.frame, [self optimalWidth]);
//    }
//
//    CGSize size = [super layoutSubviewsWithViewLayout];
//    self.frameOptimizedForLocation = GtRectSetSizeWithSize(self.frame, size);
//    
//    return size;
//}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@ : %@: %@", [super description], self.menuTitle, [self.subviews description]];
}

- (void) _touch:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!m_touching)
    {
        m_touching = YES;
        m_madeSelection = NO;
    }
    
    if(!m_madeSelection)
    {
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];
        [self handleTouch:point];
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_delegate menuViewTouchesBegan:self touches:touches withEvent:event];
    [self _touch:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_delegate menuViewTouchesMoved:self touches:touches withEvent:event];
    [self _touch:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_delegate menuViewTouchesEnded:self touches:touches withEvent:event];
    m_touching = NO;
    if(!m_madeSelection)
    {
        m_madeSelection = YES;
        
        UITouch* touch = [touches anyObject];
        CGPoint point = [touch locationInView:self];

        [self handleSelect:point];
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [m_delegate menuViewTouchesCancelled:self touches:touches withEvent:event];
    m_touching = NO;
    [self handleCancel];
}

- (NSInteger) indexForMenuItemView:(GtMenuItemView*) menuItemView
{
    return [m_menuItems indexOfObject:menuItemView];
}

- (void) addMenuItem:(GtMenuItemView*) menuItem
{
    [self addSubview:menuItem];
    [m_menuItems addObject:menuItem];
}

- (void) addDivider
{
}

//- (void) addMenuItem:(NSString*) title 
//              target:(id) target 
//              action:(SEL) action
//   configureMenuItem:(GtConfigureMenuItem) configureBlock
//{
//    GtMenuItemView* item = [[[GtMenuItemView alloc] initWithFrame:CGRectMake(0,0, m_menuItemSize.width, m_menuItemSize.height)] autorelease];
//    item.menuItemTitle = title;
//    item.callback = GtCallbackMake(target, action);
//    if(configureBlock)
//    {
//        configureBlock(item);
//    }
//    
//    if(!item.colors)
//    {
//        item.colors = [GtMenuItemColors defaultMenuItemColors];
//    }
//    
//    [self addSubview:item];
//    [m_menuItems addObject:item];
//    [self layoutSubviewsWithViewLayout];
//}
//
//- (void) addMenuItem:(NSString*) title 
//              target:(id) target 
//              action:(SEL) action
//{
//    [self addMenuItem:title target:target action:action configureMenuItem:nil];
//}



@end
