//
//  GtMenuItemView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuItemView.h"
#import "UIImage+Resize.h"
#import "UIImage+GtColorize.h"
#import "GtCallback.h"
#import "GtTableViewCellAccessoryWidget.h"
#import "GtMenuView.h"

@interface UIView (GtMenuView)
- (void) _clearMenuViewDelegates;
@end

@implementation GtMenuItemView

@synthesize callback = m_callback;
@synthesize colors = m_colors;
@synthesize subMenu = m_subMenu;
@synthesize highlighted = m_highlighted;
@synthesize delegate = m_delegate;
@synthesize titleLabel = m_label;
@synthesize imageView = m_imageView;
@synthesize userData = m_userData;
@synthesize disclosureArrowView = m_disclosureView;
@synthesize disabled = m_disabled;
@synthesize menuView = m_menuView;

- (UIImage*) image
{
    return m_imageView.image;
}

- (void) _clearMenuViewDelegates
{
    self.delegate = nil;
    self.callback = GtCallbackZero;
    [super _clearMenuViewDelegates];
}

#define Height 12.0f

- (void) setImage:(UIImage*) image
{
    if(image)
    {
        if(!m_imageView)
        {
            m_imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
            [self addSubview:m_imageView];
        }
        
        m_imageView.image = image;
    
//        if(m_imageView.image.size.height > Height)
//        {
//            [m_imageView resizeProportionally:[m_imageView.image proportionalBoundsWithMaxSize:CGSizeMake(1024.0f, Height)].size];
//        }
//        else
        {
            [m_imageView resizeToImageSize];
        }
    
        m_imageView.hidden = NO;
        
        [self setNeedsLayout];
    }
    else
    {
        m_imageView.image = nil;
        m_imageView.hidden = YES;
    }
}

- (NSInteger) indexInMenu
{
    return [m_menuView indexForMenuItemView:self];
}

- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        GtAssert([self.superview isKindOfClass:[GtMenuView class]], @"expecting to be in a GtMenuView");
    }
    m_menuView = (GtMenuView*) self.superview;
}

- (void) setTitle:(NSString *)menuItemTitle
{
    m_label.text = menuItemTitle;
    m_label.textColor = [UIColor whiteColor];
}

- (NSString*) title
{
    return m_label.text;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@: %@", [super description], m_label.text];
}

- (UIImage*) _backImage
{
    static UIImage* s_image = nil;
    if(!s_image)
    {
        s_image = [UIImage imageNamed:@"back.png"];
        s_image = [s_image colorizeImage:[UIColor gray85Color] blendMode:kCGBlendModeOverlay];
        GtRetain(s_image);
    }
    
    return s_image;
}

- (id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.autoresizesSubviews = NO;
        self.backgroundColor = [UIColor clearColor];
        
        self.colors = [GtMenuItemColors defaultMenuItemColors];
        
        m_gradient = [[GtGradientView alloc] initWithFrame:frame];
        m_gradient.alpha = 0.5;
        [self addSubview:m_gradient];
        
        m_label = [[UILabel alloc] initWithFrame:frame];
        m_label.backgroundColor = [UIColor clearColor];
        m_label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
        m_label.textColor = [UIColor whiteColor];
        m_label.shadowColor = [UIColor blackColor];
        
        [self addSubview:m_label];
                
        m_disclosureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
        m_disclosureView.image = [self _backImage];
        m_disclosureView.contentMode = UIViewContentModeScaleAspectFit;
        m_disclosureView.hidden = YES;
        [self addSubview:m_disclosureView];
    }
    
    return self;
}

- (id) initWithTitle:(NSString*) title target:(id) target action:(SEL) action
{
    if((self = [self initWithFrame:CGRectMake(0,0,100,20)]))
    {
        self.title = title;
        self.callback = GtCallbackMake(target, action);
    }

    return self;
}

+ (GtMenuItemView*) menuItemView:(NSString*) title target:(id) target action:(SEL) action
{
    return GtReturnAutoreleased([[GtMenuItemView alloc] initWithTitle:title target:target action:action]);
}


- (void) dealloc
{   
    GtRelease(m_userData);
    GtRelease(m_disclosureView);
    GtRelease(m_subMenu);
    GtRelease(m_colors);
    GtRelease(m_label);
    GtRelease(m_imageView);
    GtSuperDealloc();
}

- (void) setDisabled:(BOOL) disabled
{
    m_disabled = disabled;
    m_label.textColor = m_disabled ? 
        [UIColor grayColor] :
        [UIColor whiteColor];
        
    if(m_disclosureView)
    {
        if(m_subMenu && !m_disabled)
        {
            m_disclosureView.hidden = NO;
        }
        else
        {
            m_disclosureView.hidden = YES;
        }
    }
}

- (void) setSubMenu:(id) subMenu
{
    GtAssignObject(m_subMenu, subMenu);
    m_disclosureView.hidden =  m_subMenu == nil;
    
    [self setNeedsLayout];
}

//#define kLeftArrowTextLeft 30.0
//#define kTextLabelHeight 20.0f

#define kTextHeight 20.0f
#define kArrowLeft 8.0f
#define kTextLeft 32.0
#define kTextRight 32.0

- (CGFloat) optimalWidth
{
    CGSize size = [m_label sizeToFitText];
    return size.width + kTextLeft + kTextRight;
}

- (void) layoutSubviews
{
    m_gradient.newFrame = self.bounds;
    
    m_label.frameOptimizedForSize = GtRectCenterRectInRectVertically(self.bounds, 
        CGRectMake(kTextLeft, 0, self.frame.size.width - kTextLeft - kTextRight, kTextHeight));
   
    switch(m_arrowSide)
    {
        case GtMenuItemViewDisclosureArrowSideLeft:
            m_disclosureView.frameOptimizedForLocation = GtRectCenterRectInRectVertically(self.bounds, GtRectSetLeft(m_disclosureView.frame, kArrowLeft));
        break;
        
        case GtMenuItemViewDisclosureArrowSideRight:

// TODO: arrow on right
//            m_disclosureView.frameOptimizedForLocation = GtRectCenterRectInRectVertically(self.bounds, GtRectSetLeft(m_disclosureView.frame, self.bounds.size.width - m_disclosureView.frame.size.width - kArrowLeft));
        break;
    
    }
    
    if(m_imageView)
    {
        m_imageView.frameOptimizedForLocation = GtRectCenterRectInRectVertically(self.bounds, 
            GtRectSetLeft(m_imageView.frame, self.bounds.size.width - m_imageView.frame.size.width - 10.0));
    }
    
    [super layoutSubviews];
}

- (void) blinkTwo
{
    [m_gradient setGradientColors:m_colors.backgroundGradientColors];
    
    if(m_delegate)
    {
        [m_delegate menuItemViewFinishedSelectAnimation:self];
    }
    else
    {
        self.highlighted = NO;
        GtInvokeCallback(self.callback, self);
    }
}

- (void) blinkOne
{
    [m_gradient setGradientColors:m_colors.highlightedGradientColors];
    [self performSelector:@selector(blinkTwo) withObject:nil afterDelay:0.1];
}

- (void) beginSelectedAnimation
{
    [m_gradient setGradientColors:m_colors.backgroundGradientColors];
    [self performSelector:@selector(blinkOne) withObject:nil afterDelay:0.1];
}

- (void) handleSelect:(CGPoint) point 
{
    if(!self.disabled)
    {
        if(m_delegate)
        {
            [m_delegate menuItemView:self touchesEnded:CGRectContainsPoint(self.bounds, point)];
        }
        else
        {
            if(CGRectContainsPoint(self.bounds, point))
            {
                [self beginSelectedAnimation];
            }
            else
            {
                self.highlighted = NO;
            }
        }
    }
}

- (void) setColors:(GtMenuItemColors*) colors
{
    GtAssignObject(m_colors, colors);
    self.highlighted = self.isHighlighted;
}

- (void) setHighlighted:(BOOL)highlighted
{
    m_highlighted = highlighted;
    if(m_highlighted && !self.disabled)
    {
        [m_gradient setGradientColors:m_colors.highlightedGradientColors];
    }
    else
    {
        [m_gradient setGradientColors:m_colors.backgroundGradientColors];
    }
}

- (void) handleTouch:(CGPoint) point
{
    if(!self.disabled)
    {
        if(m_delegate)
        {
            [m_delegate menuItemView:self touchesMoved:CGRectContainsPoint(self.bounds, point)];
        }
        else
        {
            self.highlighted = CGRectContainsPoint(self.bounds, point);
        }
    }
}

- (void) handleCancel
{
    if(m_delegate)
    {
        [m_delegate menuItemViewTouchesCancelled:self];
    }
    else
    {
        self.highlighted = NO;
    }
}

@end

@implementation GtMenuItemColors

@synthesize backgroundGradientColors = m_backgroundColors;
@synthesize highlightedGradientColors = m_highlightedColors;

- (id) initWithBackgroundGradientColors:(GtGradientColorPair*) backgroundGradientColors
              highlightedGradientColors:(GtGradientColorPair*) highlightedGradientColors
{
    if((self = [super init]))
    {
        m_backgroundColors = GtRetain(backgroundGradientColors);
        m_highlightedColors = GtRetain(highlightedGradientColors);
    }
    
    return self;
}

+ (GtMenuItemColors*) menuItemColors:(GtGradientColorPair*) backgroundGradientColors
           highlightedGradientColors:(GtGradientColorPair*) highlightedGradientColors
{
    return GtReturnAutoreleased([[GtMenuItemColors alloc] initWithBackgroundGradientColors:backgroundGradientColors highlightedGradientColors:highlightedGradientColors]);
}

- (void) dealloc
{
    GtRelease(m_backgroundColors);
    GtRelease(m_highlightedColors);
    GtSuperDealloc();
}

+ (GtMenuItemColors*) defaultMenuItemColors
{
    return [[[GtMenuItemColors alloc] initWithBackgroundGradientColors:[GtGradientColorPair  grayGradientColors] highlightedGradientColors:[GtGradientColorPair brightBlueGradientColors]] autorelease];
}

+ (GtMenuItemColors*) deleteMenuItemColors
{
    return [[[GtMenuItemColors alloc] initWithBackgroundGradientColors:[GtGradientColorPair  deleteButtonRedGradientColors] highlightedGradientColors:[GtGradientColorPair brightBlueGradientColors]] autorelease];
}



@end
