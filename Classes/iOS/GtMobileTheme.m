//
//	GtMobileThemes.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMobileTheme.h"

@implementation GtMobileTheme 

@synthesize titleDescriptor = m_titleDescriptor;
@synthesize valueDescriptor = m_valueDescriptor;
@synthesize placeholderDescriptor = m_placeholderDescriptor;
@synthesize gradientStartColor = m_gradientStartColor;
@synthesize gradientEndColor = m_gradientEndColor;
@synthesize cellBackgroundColor = m_cellBackgroundColor;
@synthesize valueTextColor = m_valueTextColor;
@synthesize tableHeaderTextColor = m_tableHeaderTextColor;
@synthesize titleTextColor = m_titleTextColor;

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}

- (void) applyThemeToStatusBar
{
    [[UIApplication sharedApplication] setStatusBarStyle:DeviceIsPad() ? UIStatusBarStyleBlackOpaque : UIStatusBarStyleBlackTranslucent animated:NO];
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
}

- (void) applyThemeToNavigationController:(UINavigationController*) navigationController
{
	navigationController.navigationBar.barStyle = UIBarStyleBlack;
	navigationController.navigationBar.translucent = YES;
	navigationController.wantsFullScreenLayout = YES;
}

- (void) dealloc
{
	GtRelease(m_gradientStartColor);
	GtRelease(m_gradientEndColor);
	GtRelease(m_cellBackgroundColor);
	GtRelease(m_valueTextColor);
	GtRelease(m_tableHeaderTextColor);
	GtRelease(m_titleTextColor);
	GtRelease(m_placeholderDescriptor);
	GtRelease(m_titleDescriptor);
	GtRelease(m_valueDescriptor);
	GtSuperDealloc();
}

-(CGFloat) calculateActualFontSize;
{
	CGFloat fontSize = 0;
	switch(self.fontSize)
	{
		case GtThemeTextSizeLarge:
			fontSize = [UIFont systemFontSize] + 4.0f;
		break;
		
		case GtThemeTextSizeSmall:
			fontSize = [UIFont smallSystemFontSize];
		break;
		
		case GtThemeTextSizeMedium:
			fontSize = DeviceIsPad() ? [UIFont systemFontSize] : [UIFont smallSystemFontSize];
		break;
	}

	return fontSize;
}

@end
