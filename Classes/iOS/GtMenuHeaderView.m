//
//  GtMenuHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMenuHeaderView.h"
#import "UILabel+GtExtras.h"

@implementation GtMenuSectionHeaderView

- (void) setMenuHeaderTitle:(NSString *)menuItemTitle
{
    m_label.text = menuItemTitle;
}

- (NSString*) menuHeaderTitle
{
    return m_label.text;
}

- (void) configureLabel:(UILabel*) label
{
    label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    label.textColor = GtRgbColor(171,197,225,1.0);
}

- (id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:CGRectMake(0, 0, 100, 36)]))
    {
        self.autoresizesSubviews = NO;
        
        m_gradientView = [[GtGradientView alloc] initWithFrame:frame];
        [self addSubview:m_gradientView];
        
        m_label = [[UILabel alloc] initWithFrame:frame];
        m_label.textAlignment = UITextAlignmentLeft;
        m_label.backgroundColor = [UIColor clearColor];
        m_label.shadowColor = [UIColor blackColor];
        
        [self configureLabel:m_label];
        [m_label addGlow];
        
        [self addSubview:m_label];
    }
    
    return self;
}

- (void) _setGradientFrame:(GtGradientView*) gradient
{
    gradient.newFrame  = self.bounds;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self _setGradientFrame:m_gradientView];
    m_label.frameOptimizedForSize = CGRectInset(self.bounds, 10, 0);
}

- (void) dealloc
{
    GtRelease(m_label);
    GtRelease(m_gradientView);
    GtSuperDealloc();
}
@end

@implementation GtMenuHeaderView

- (id) initWithFrame:(CGRect)frame
{
    if((self = [super initWithFrame:CGRectMake(0, 0, 100, 36)]))
    {
        self.backgroundColor = [UIColor blackColor];
    }
 
    return self;
}


- (void) _setGradientFrame:(GtGradientView*) gradient
{
    gradient.themeAction = nil;
    [gradient setGradientColors:GtRgbColor(112,112,114,1.0) endColor:GtRgbColor(55,55,57,1.0)];
    gradient.frameOptimizedForSize  = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2.0f);
}

- (void) configureLabel:(UILabel*) label
{
    label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    label.textColor = [UIColor whiteColor];
    
//    label.textColor = GtRgbColor(203, 102, 10,1.0);
    label.textAlignment = UITextAlignmentCenter;
}


@end