//
//	FLMobileThemes.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLMobileTheme.h"
#import "FLButton.h"
#import "FLAlert.h"

//@implementation FLMobileTheme 
//
//@synthesize titleDescriptor = _titleDescriptor;
//@synthesize valueDescriptor = _valueDescriptor;
//@synthesize placeholderDescriptor = _placeholderDescriptor;
//@synthesize gradientStartColor = _gradientStartColor;
//@synthesize gradientEndColor = _gradientEndColor;
//@synthesize cellBackgroundColor = _cellBackgroundColor;
//@synthesize valueTextColor = _valueTextColor;
//@synthesize tableHeaderTextColor = _tableHeaderTextColor;
//@synthesize titleTextColor = _titleTextColor;
//
//- (id) init
//{
//    if((self = [super init]))
//    {
//    }
//    
//    return self;
//}
//
//- (void) applyThemeToStatusBar
//{
//    [[UIApplication sharedApplication] setStatusBarStyle:DeviceIsPad() ? UIStatusBarStyleBlackOpaque : UIStatusBarStyleBlackTranslucent animated:NO];
//    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationNone];
//}
//
//- (void) applyThemeToNavigationController:(UINavigationController*) navigationController
//{
//	navigationController.navigationBar.barStyle = UIBarStyleBlack;
//	navigationController.navigationBar.translucent = YES;
//	navigationController.wantsFullScreenLayout = YES;
//}
//
//- (void) applyThemeToButton:(FLButton*) button
//{
//}
//
//- (void) applyThemeToAlert:(FLAlert*) button
//{
//}
//
//
//- (void) dealloc
//{
//	release_(_gradientStartColor);
//	release_(_gradientEndColor);
//	release_(_cellBackgroundColor);
//	release_(_valueTextColor);
//	release_(_tableHeaderTextColor);
//	release_(_titleTextColor);
//	release_(_placeholderDescriptor);
//	release_(_titleDescriptor);
//	release_(_valueDescriptor);
//	super_dealloc_();
//}
//
//-(CGFloat) calculateActualFontSize;
//{
//	CGFloat fontSize = 0;
//	switch(self.fontSize)
//	{
//		case FLThemeTextSizeLarge:
//			fontSize = [UIFont systemFontSize] + 4.0f;
//		break;
//		
//		case FLThemeTextSizeSmall:
//			fontSize = [UIFont smallSystemFontSize];
//		break;
//		
//		case FLThemeTextSizeMedium:
//			fontSize = DeviceIsPad() ? [UIFont systemFontSize] : [UIFont smallSystemFontSize];
//		break;
//	}
//
//	return fontSize;
//}
//
//@end
