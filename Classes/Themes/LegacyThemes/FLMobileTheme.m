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
//	mrc_release_(_gradientStartColor);
//	mrc_release_(_gradientEndColor);
//	mrc_release_(_cellBackgroundColor);
//	mrc_release_(_valueTextColor);
//	mrc_release_(_tableHeaderTextColor);
//	mrc_release_(_titleTextColor);
//	mrc_release_(_placeholderDescriptor);
//	mrc_release_(_titleDescriptor);
//	mrc_release_(_valueDescriptor);
//	mrc_super_dealloc_();
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
