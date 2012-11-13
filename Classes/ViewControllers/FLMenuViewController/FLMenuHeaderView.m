//
//  FLMenuHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/11.
//  Copyright 2011 Greentongue Software. All rights reserved.
//

#import "FLMenuHeaderView.h"
#import "UILabel+FLExtras.h"

@implementation FLMenuSectionHeaderView

- (void) setMenuHeaderTitle:(NSString *)menuItemTitle
{
    _label.text = menuItemTitle;
}

- (NSString*) menuHeaderTitle
{
    return _label.text;
}

- (void) configureLabel:(UILabel*) label
{
    label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
    label.textColor = FLRgbColor(171,197,225,1.0);
}

- (id) initWithFrame:(FLRect)frame
{
    if((self = [super initWithFrame:CGRectMake(0, 0, 100, 36)]))
    {
        self.autoresizesSubviews = NO;
        self.wantsApplyTheme = YES;

		
        _gradientView = [[FLGradientView alloc] initWithFrame:frame];
        [self addSubview:_gradientView];
        
        _label = [[UILabel alloc] initWithFrame:frame];
        _label.textAlignment = UITextAlignmentLeft;
        _label.backgroundColor = [UIColor clearColor];
        _label.shadowColor = [UIColor blackColor];
        
        [self configureLabel:_label];
        [_label addGlow];
        
        [self addSubview:_label];
    }
    
    return self;
}

- (void) _setGradientFrame:(FLGradientView*) gradient
{
    gradient.newFrame  = self.bounds;
}

- (void) layoutSubviews
{
    [super layoutSubviews];
    [self _setGradientFrame:_gradientView];
    _label.frameOptimizedForSize = CGRectInset(self.bounds, 10, 0);
}

- (void) dealloc
{
    release_(_label);
    release_(_gradientView);
    super_dealloc_();
}
@end

@implementation FLMenuHeaderView

- (id) initWithFrame:(FLRect)frame
{
    if((self = [super initWithFrame:CGRectMake(0, 0, 100, 36)]))
    {
        self.backgroundColor = [UIColor blackColor];
    }
 
    return self;
}

- (void) applyTheme:(FLTheme*) theme {
}

- (void) _setGradientFrame:(FLGradientView*) gradient
{
    gradient.wantsApplyTheme = NO;
    [gradient.gradient setColorRange:[FLColorRange colorRange:FLRgbColor(112,112,114,1.0) endColor:FLRgbColor(55,55,57,1.0)] forControlState:UIControlStateNormal];
    gradient.frameOptimizedForSize  = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height / 2.0f);
}

- (void) configureLabel:(UILabel*) label
{
    label.font = [UIFont boldSystemFontOfSize:[UIFont buttonFontSize]];
    label.textColor = [UIColor whiteColor];
    
//    label.textColor = FLRgbColor(203, 102, 10,1.0);
    label.textAlignment = UITextAlignmentCenter;
}


@end