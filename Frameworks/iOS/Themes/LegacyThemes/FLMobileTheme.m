//
//	FLMobileThemes.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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
//	FLRelease(_gradientStartColor);
//	FLRelease(_gradientEndColor);
//	FLRelease(_cellBackgroundColor);
//	FLRelease(_valueTextColor);
//	FLRelease(_tableHeaderTextColor);
//	FLRelease(_titleTextColor);
//	FLRelease(_placeholderDescriptor);
//	FLRelease(_titleDescriptor);
//	FLRelease(_valueDescriptor);
//	FLSuperDealloc();
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
