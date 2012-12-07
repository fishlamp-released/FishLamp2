//
//  FLAsyncThumbnailToolBar.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAsyncThumbnailToolBar.h"

#import "FLImage+Colorize.h"

@implementation FLAsyncThumbnailToolBar

@synthesize backgroundView = _backgroundView;
@synthesize title = _titleLabel;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
        _buttons = [[FLOrderedCollection alloc] init];
        self.autoresizesSubviews = NO;
        
        _thumbnailButton = [UIButton buttonWithType:UIButtonTypeCustom];
        mrc_retain_(_thumbnailButton);
        
        _thumbnailButton.enabled = YES;
        _thumbnailButton.showsTouchWhenHighlighted = YES;
        [self addSubview:_thumbnailButton];
        
        _titleLabel = [[FLTouchableStringView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 20)];
        _titleLabel.verticalTextAlignment = FLVerticalTextAlignmentCenter;
        
        FLTouchableString* component = [FLTouchableString touchableString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [_titleLabel addAttributedString:component forKey:@"user"];
        
        component = [FLTouchableString touchableString];
        component.textColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = NO;
        [_titleLabel addAttributedString:component forKey:@"d1"];

        component = [FLTouchableString touchableString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [_titleLabel addAttributedString:component forKey:@"gallery"];
        
        component = [FLTouchableString touchableString];
        component.textColor = [UIColor lightGrayColor];
        component.highlightedTextColor = [UIColor blueColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        [_titleLabel addAttributedString:component forKey:@"d2"];
        
        component = [FLTouchableString touchableString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [_titleLabel addAttributedString:component forKey:@"photo"];

        [self addSubview:_titleLabel];
        
        UIView* view = FLAutorelease([[UIView alloc] initWithFrame:self.bounds]);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5f;
        self.backgroundView = view;
    
        _spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        _spinner.hidesWhenStopped = YES;
        [_thumbnailButton addSubview:_spinner];
    }

    return self;
}

- (void) dealloc
{
    FLRelease(_titleLabel);
    FLRelease(_backgroundView);
    FLRelease(_spinner);
    FLRelease(_thumbnailButton);
    FLRelease(_buttons);
    super_dealloc_();
}

#define kButtonSpace 20.0f

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    _backgroundView.frame = self.bounds;
    
    CGFloat buttonSize = self.bounds.size.height - 8.0f;
    
    CGRect buttonRect = CGRectMake(4, 4, buttonSize,buttonSize);
    
    _thumbnailButton.frame = buttonRect;
    
    buttonRect.origin.x = FLRectGetRight(self.bounds);
    
    for(int i = _buttons.count - 1; i >= 0; i--)
    {
        buttonRect.origin.x = (buttonRect.origin.x - kButtonSpace - buttonRect.size.width);
        UIView* button = [_buttons objectAtIndex:i];
        button.frame = buttonRect;
    }
    
    CGRect titleRect;
    titleRect.origin.x = FLRectGetRight(_thumbnailButton.frame) + 4;
    titleRect.origin.y = 4.0f;
    titleRect.size.width = buttonRect.origin.x - titleRect.origin.x;
    titleRect.size.height = buttonRect.size.height;
    _titleLabel.frame = titleRect; 
    [_titleLabel setNeedsDisplay];
    
    _spinner.frame = FLRectCenterRectInRect(_thumbnailButton.bounds, _spinner.frame);
}

- (void) startSpinner
{
    [_spinner startAnimating];
}

- (void) stopSpinner
{
    [_spinner stopAnimating];
}

- (void) setThumbnail:(UIImage*) thumbnail
{
    [_thumbnailButton setImage:thumbnail forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (UIImage*) thumbnail
{
    return [_thumbnailButton imageForState:UIControlStateNormal];
}

- (void) setBackgroundView:(UIView*) view
{
    if(_backgroundView)
    {
        [_backgroundView removeFromSuperview];
    }

    FLRetainObject_(_backgroundView, view);
    
    if(_backgroundView)
    {
        _backgroundView.frame = self.bounds;
        [self insertSubview:_backgroundView atIndex:0];
    }
}

- (void) addButtonForKey:(NSString*) key
    imageName:(NSString*) imageName
    iconColor:(FLIconColor) iconColor
    target:(id) target
    action:(SEL) action
{
    UIImage* image = nil;
    
    switch(iconColor)
    {
        case FLIconColorWhite:
            image = [UIImage imageNamed:imageName];
        break;
        
        case FLIconColorBlack:
            image = [UIImage whiteImageNamed:imageName];
        break;

        case FLIconColorGray:
            image = [UIImage whiteImageNamed:imageName];
        break;
    
    }
    
    FLAssertIsNotNil_(image);
    FLAssertIsNotNil_(target);
    FLAssertIsNotNil_(action);

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, image.size.width, image.size.height);
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.enabled = YES;
	button.showsTouchWhenHighlighted = YES;
	
    [self addSubview:button];
    [_buttons addOrReplaceObject:button forKey:key];
    
    [self setNeedsLayout];
}

@end

