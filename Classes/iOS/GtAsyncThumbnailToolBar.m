//
//  GtAsyncThumbnailToolBar.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/4/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAsyncThumbnailToolBar.h"

#import "UIImage+GtColorize.h"

@implementation GtAsyncThumbnailToolBar

@synthesize backgroundView = m_backgroundView;
@synthesize title = m_titleLabel;

- (id) initWithFrame:(CGRect) frame
{
    if((self = [super initWithFrame:frame]))
    {
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    
        m_buttons = [[GtOrderedCollection alloc] init];
        self.autoresizesSubviews = NO;
        
        m_thumbnailButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
        m_thumbnailButton.enabled = YES;
        m_thumbnailButton.showsTouchWhenHighlighted = YES;
        [self addSubview:m_thumbnailButton];
        
        m_titleLabel = [[GtAttributedStringView alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 20)];
        m_titleLabel.verticalTextAlignment = GtVerticalTextAlignmentCenter;
        
        GtAttributedString* component = [GtAttributedString attributedString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [m_titleLabel addAttributedString:component forKey:@"user"];
        
        component = [GtAttributedString attributedString];
        component.textColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = NO;
        [m_titleLabel addAttributedString:component forKey:@"d1"];

        component = [GtAttributedString attributedString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [m_titleLabel addAttributedString:component forKey:@"gallery"];
        
        component = [GtAttributedString attributedString];
        component.textColor = [UIColor lightGrayColor];
        component.highlightedTextColor = [UIColor blueColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        [m_titleLabel addAttributedString:component forKey:@"d2"];
        
        component = [GtAttributedString attributedString];
        component.textColor = [UIColor whiteColor];
        component.highlightedTextColor = [UIColor grayColor];
        component.textFont = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
        component.touchable = YES;
        [m_titleLabel addAttributedString:component forKey:@"photo"];

        [self addSubview:m_titleLabel];
        
        UIView* view = GtReturnAutoreleased([[UIView alloc] initWithFrame:self.bounds]);
        view.backgroundColor = [UIColor blackColor];
        view.alpha = 0.5f;
        self.backgroundView = view;
    
        m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        m_spinner.hidesWhenStopped = YES;
        [m_thumbnailButton addSubview:m_spinner];
    }

    return self;
}

- (void) dealloc
{
    GtRelease(m_titleLabel);
    GtRelease(m_backgroundView);
    GtRelease(m_spinner);
    GtRelease(m_thumbnailButton);
    GtRelease(m_buttons);
    GtSuperDealloc();
}

#define kButtonSpace 20.0f

- (void) layoutSubviews
{
    [super layoutSubviews];
    
    m_backgroundView.frame = self.bounds;
    
    CGFloat buttonSize = self.bounds.size.height - 8.0f;
    
    CGRect buttonRect = CGRectMake(4, 4, buttonSize,buttonSize);
    
    m_thumbnailButton.frame = buttonRect;
    
    buttonRect.origin.x = GtRectGetRight(self.bounds);
    
    for(int i = m_buttons.count - 1; i >= 0; i--)
    {
        buttonRect.origin.x = (buttonRect.origin.x - kButtonSpace - buttonRect.size.width);
        UIView* button = [m_buttons objectAtIndex:i];
        button.frame = buttonRect;
    }
    
    CGRect titleRect;
    titleRect.origin.x = GtRectGetRight(m_thumbnailButton.frame) + 4;
    titleRect.origin.y = 4.0f;
    titleRect.size.width = buttonRect.origin.x - titleRect.origin.x;
    titleRect.size.height = buttonRect.size.height;
    m_titleLabel.frame = titleRect; 
    [m_titleLabel setNeedsDisplay];
    
    m_spinner.frame = GtRectCenterRectInRect(m_thumbnailButton.bounds, m_spinner.frame);
}

- (void) startSpinner
{
    [m_spinner startAnimating];
}

- (void) stopSpinner
{
    [m_spinner stopAnimating];
}

- (void) setThumbnail:(UIImage*) thumbnail
{
    [m_thumbnailButton setImage:thumbnail forState:UIControlStateNormal];
    [self setNeedsLayout];
}

- (UIImage*) thumbnail
{
    return [m_thumbnailButton imageForState:UIControlStateNormal];
}

- (void) setBackgroundView:(UIView*) view
{
    if(m_backgroundView)
    {
        [m_backgroundView removeFromSuperview];
    }

    GtAssignObject(m_backgroundView, view);
    
    if(m_backgroundView)
    {
        m_backgroundView.frame = self.bounds;
        [self insertSubview:m_backgroundView atIndex:0];
    }
}

- (void) addButtonForKey:(NSString*) key
    imageName:(NSString*) imageName
    iconColor:(GtIconColor) iconColor
    target:(id) target
    action:(SEL) action
{
    UIImage* image = nil;
    
    switch(iconColor)
    {
        case GtIconColorWhite:
            image = [UIImage imageNamed:imageName];
        break;
        
        case GtIconColorBlack:
            image = [UIImage whiteImageNamed:imageName];
        break;

        case GtIconColorGray:
            image = [UIImage whiteImageNamed:imageName];
        break;
    
    }
    
    GtAssertNotNil(image);
    GtAssertNotNil(target);
    GtAssertNotNil(action);

	UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
	button.frame = CGRectMake(0,0, image.size.width, image.size.height);
	[button setImage:image forState:UIControlStateNormal];
	[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
	button.enabled = YES;
	button.showsTouchWhenHighlighted = YES;
	
    [self addSubview:button];
    [m_buttons addOrReplaceObject:button forKey:key];
    
    [self setNeedsLayout];
}

@end

