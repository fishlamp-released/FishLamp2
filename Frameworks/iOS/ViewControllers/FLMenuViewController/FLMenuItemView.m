//
//  FLMenuItemView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMenuItemView.h"
#import "UIImage+Resize.h"
#import "UIImage+Colorize.h"
#import "FLCallback_t.h"
#import "FLTableViewCellAccessoryWidget.h"
#import "FLMenuView.h"
#import "FLColorRange.h"
#import "FLColorRange+FLThemes.h"
#import "FLViewGradients.h"

@interface UIView (FLMenuView)
- (void) _clearMenuViewDelegates;
@end

@implementation FLMenuItemView

@synthesize callback = _callback;
@synthesize subMenu = _subMenu;
@synthesize highlighted = _highlighted;
@synthesize delegate = _delegate;
@synthesize titleLabel = _label;
@synthesize imageView = _imageView;
@synthesize userData = _userData;
@synthesize disclosureArrowView = _disclosureView;
@synthesize disabled = _disabled;
@synthesize menuView = _menuView;

- (UIImage*) image
{
    return _imageView.image;
}

- (void) _clearMenuViewDelegates
{
    self.delegate = nil;
    self.callback = FLCallbackZero;
    [super _clearMenuViewDelegates];
}

#define Height 12.0f

- (void) setImage:(UIImage*) image
{
    if(image)
    {
        if(!_imageView)
        {
            _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,image.size.width, image.size.height)];
            [self addSubview:_imageView];
        }
        
        _imageView.image = image;
    
//        if(_imageView.image.size.height > Height)
//        {
//            [_imageView resizeProportionally:[_imageView.image proportionalBoundsWithMaxSize:CGSizeMake(1024.0f, Height)].size];
//        }
//        else
        {
            [_imageView resizeToImageSize];
        }
    
        _imageView.hidden = NO;
        
        [self setNeedsLayout];
    }
    else
    {
        _imageView.image = nil;
        _imageView.hidden = YES;
    }
}

- (FLViewGradients*) gradientColors {
    return _gradientView.gradient.gradientColors;
}

- (void) setGradientColors:(FLViewGradients*) colors {
    _gradientView.gradient.gradientColors = colors;
    self.highlighted = self.isHighlighted;
}

- (NSInteger) indexInMenu
{
    return [_menuView indexForMenuItemView:self];
}

- (void) didMoveToSuperview
{
    [super didMoveToSuperview];
    
    if(self.superview)
    {
        FLAssertWithComment([self.superview isKindOfClass:[FLMenuView class]], @"expecting to be in a FLMenuView");
    }
    _menuView = (FLMenuView*) self.superview;
}

- (void) setTitle:(NSString *)menuItemTitle
{
    _label.text = menuItemTitle;
    _label.textColor = [UIColor whiteColor];
}

- (NSString*) title
{
    return _label.text;
}

- (NSString*) description
{
    return [NSString stringWithFormat:@"%@: %@", [super description], _label.text];
}

- (UIImage*) _backImage
{
    static UIImage* s_image = nil;
    if(!s_image)
    {
        s_image = [UIImage imageNamed:@"back.png"];
        s_image = [s_image colorizeImage:[UIColor gray85Color] blendMode:kCGBlendModeOverlay];
        mrc_retain_(s_image);
    }
    
    return s_image;
}

- (void) applyTheme:(FLTheme*) theme {
    [super applyTheme:theme];
    
//    self.gradientColors = [NSColorRange colorRangeWithColorRangeName:theme.
}

- (id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.wantsApplyTheme = YES;
        self.autoresizesSubviews = NO;
        self.backgroundColor = [UIColor clearColor];
        
//        self.gradientColors = [FLViewGradients defaultMenuItemColors];
        
        _gradientView = [[FLGradientView alloc] initWithFrame:frame];
        _gradientView.gradient.alpha = 0.5;
        [self addSubview:_gradientView];
        
        _label = [[UILabel alloc] initWithFrame:frame];
        _label.backgroundColor = [UIColor clearColor];
        _label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
        _label.textColor = [UIColor whiteColor];
        _label.shadowColor = [UIColor blackColor];
        
        [self addSubview:_label];
                
        _disclosureView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 14, 14)];
        _disclosureView.image = [self _backImage];
        _disclosureView.contentMode = UIViewContentModeScaleAspectFit;
        _disclosureView.hidden = YES;
        [self addSubview:_disclosureView];
    }
    
    return self;
}

- (id) initWithTitle:(NSString*) title target:(id) target action:(SEL) action
{
    if((self = [self initWithFrame:CGRectMake(0,0,100,20)]))
    {
        self.title = title;
        self.callback = FLCallbackMake(target, action);
    }

    return self;
}

- (id) initWithTitle:(NSString*) title submenu:(id) submenu
{
    if((self = [self initWithFrame:CGRectMake(0,0,100,20)]))
    {
        self.title = title;
        self.subMenu = submenu;
    }

    return self;
}

+ (FLMenuItemView*) menuItemView:(NSString*) title target:(id) target action:(SEL) action
{
    return FLAutorelease([[FLMenuItemView alloc] initWithTitle:title target:target action:action]);
}

+ (FLMenuItemView*) menuItemView:(NSString*) title submenu:(id) submenu
{
    return FLAutorelease([[FLMenuItemView alloc] initWithTitle:title submenu:submenu]);
}

- (void) dealloc
{   
    FLRelease(_userData);
    FLRelease(_disclosureView);
    FLRelease(_subMenu);
    FLRelease(_label);
    FLRelease(_imageView);
    FLSuperDealloc();
}

- (void) setDisabled:(BOOL) disabled
{
    _disabled = disabled;
    _label.textColor = _disabled ? 
        [UIColor grayColor] :
        [UIColor whiteColor];
        
    if(_disclosureView)
    {
        if(_subMenu && !_disabled)
        {
            _disclosureView.hidden = NO;
        }
        else
        {
            _disclosureView.hidden = YES;
        }
    }
}

- (void) setSubMenu:(id) subMenu
{
    FLSetObjectWithRetain(_subMenu, subMenu);
    _disclosureView.hidden =  _subMenu == nil;
    
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
    CGSize size = [_label sizeToFitText];
    return size.width + kTextLeft + kTextRight;
}

- (void) layoutSubviews
{
    _gradientView.newFrame = self.bounds;
    
    _label.frameOptimizedForSize = FLRectCenterRectInRectVertically(self.bounds, 
        CGRectMake(kTextLeft, 0, self.frame.size.width - kTextLeft - kTextRight, kTextHeight));
   
    switch(_arrowSide)
    {
        case FLMenuItemViewDisclosureArrowSideLeft:
            _disclosureView.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, FLRectSetLeft(_disclosureView.frame, kArrowLeft));
        break;
        
        case FLMenuItemViewDisclosureArrowSideRight:

// TODO: arrow on right
//            _disclosureView.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, FLRectSetLeft(_disclosureView.frame, self.bounds.size.width - _disclosureView.frame.size.width - kArrowLeft));
        break;
    
    }
    
    if(_imageView)
    {
        _imageView.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, 
            FLRectSetLeft(_imageView.frame, self.bounds.size.width - _imageView.frame.size.width - 10.0));
    }
    
    [super layoutSubviews];
}

- (void) blinkTwo
{
    _gradientView.highlighted = NO;
    
    if(_delegate)
    {
        [_delegate menuItemViewFinishedSelectAnimation:self];
    }
    else
    {
        self.highlighted = NO;
        FLInvokeCallback(self.callback, self);
    }
}

- (void) blinkOne
{
    _gradientView.highlighted = YES;
    [self performSelector:@selector(blinkTwo) withObject:nil afterDelay:0.1];
}

- (void) beginSelectedAnimation
{
    _gradientView.highlighted = NO;
    [self performSelector:@selector(blinkOne) withObject:nil afterDelay:0.1];
}

- (void) handleSelect:(CGPoint) point 
{
    if(!self.disabled)
    {
        if(_delegate)
        {
            [_delegate menuItemView:self touchesEnded:CGRectContainsPoint(self.bounds, point)];
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

- (void) setHighlighted:(BOOL)highlighted
{
    _highlighted = highlighted;
    if(_highlighted && !self.disabled)
    {
        _gradientView.highlighted = YES;
    }
    else
    {
        _gradientView.highlighted = NO;
    }
}

- (void) handleTouch:(CGPoint) point
{
    if(!self.disabled)
    {
        if(_delegate)
        {
            [_delegate menuItemView:self touchesMoved:CGRectContainsPoint(self.bounds, point)];
        }
        else
        {
            self.highlighted = CGRectContainsPoint(self.bounds, point);
        }
    }
}

- (void) handleCancel
{
    if(_delegate)
    {
        [_delegate menuItemViewTouchesCancelled:self];
    }
    else
    {
        self.highlighted = NO;
    }
}

@end

@implementation  FLViewGradients (FLMenuItem)

//+ (FLViewGradients*) defaultMenuItemColors
//{
//    FLReturnSingletonStatic(^{
//        FLViewGradients* gradients = [FLViewGradients controlGradients];
//        gradients.normalColorRange = [FLColorRange grayGradientColorRange];
//        gradients.highlightedColorRange = [FLColorRange brightBlueGradientColorRange];
//        return gradients;
//    });
//}
//
//+ (FLViewGradients*) deleteMenuItemColors
//{
//    FLReturnSingletonStatic(^{
//        FLViewGradients* gradients = [FLViewGradients controlGradients];
//        gradients.normalColorRange = [FLColorRange redGradientColorRange];
//        gradients.highlightedColorRange = [FLColorRange brightBlueGradientColorRange];
//        return gradients;
//    });
//}



@end
