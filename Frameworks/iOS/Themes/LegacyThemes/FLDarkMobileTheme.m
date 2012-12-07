////
////  FLDarkMobileTheme.m
////  FishLamp
////
////  Created by Mike Fullerton on 6/7/11.
////  Copyright 2011 GreenTongue Software. All rights reserved.
////
//
//#import "FLDarkMobileTheme.h"
//#import "FLGradientView.h"
//
//#import "FLTextEditView.h"
//
//#import "FLLegacySimpleProgressView.h"
//#import "FLOldUserNotificationView.h"
//#import "FLLabelAndValueBaseCell.h"
//#import "FLCheckMarkTableViewCell.h"
//#import "FLBannerTableViewCell.h"
//
//#import "FLSliderValueCell.h"
//#import "FLTableViewHeaderView.h"
//#import "FLTableViewCellBackgroundView.h"
//#import "FLGradientView.h"
//#import "FLOnOffSwitchCell.h"
//#import "FLPinEditingView.h"
//
//#import "FLTextField.h"
//#import "FLTextView.h"
//#import "FLGradientButton.h"
//#import "FLGradientWidget.h"
//#import "FLLabelWidget.h"
//#import "FLTableViewCellSectionWidget.h"
//
//#import "FLButton.h"
//#import "FLAlert.h"
//
//@implementation UIFont (Georgia)
//
//+ (UIFont*) georgiaFontOfSize:(CGFloat) fontSize
//{
////	NSArray* familyNames = [UIFont familyNames];
////	familyNames = familyNames;
////	
////	NSArray* fontNames = [UIFont fontNamesForFamilyName:@"Georgia"];
////	fontNames = fontNames;
//	
//	return [UIFont fontWithName:@"Georgia" size:fontSize];
//}
//
//+ (UIFont*) boldGeorgiaFontOfSize:(CGFloat) fontSize
//{
////	NSArray* familyNames = [UIFont familyNames];
////	familyNames = familyNames;
////	
////	NSArray* fontNames = [UIFont fontNamesForFamilyName:@"Georgia"];
////	fontNames = fontNames;
//	
//	return [UIFont fontWithName:@"Georgia-Bold" size:fontSize];
//}
//
//
//@end
//
//#if NEW_FONTS
//
//#define BOLD_FONT_OF_SIZE boldGeorgiaFontOfSize
//#define FONT_OF_SIZE georgiaFontOfSize
//#else
//#define BOLD_FONT_OF_SIZE boldSystemFontOfSize
//#define FONT_OF_SIZE systemFontOfSize
//
//
//#endif
//
//
//NSMutableDictionary* FLGetDarkMobileTheme()
//{
//    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];
//
//    [dictionary setObject:^(id object) {
//        [object setColorRange:[FLColorRange colorRange:FLRgbColor(69,69,71,1.0) endColor:FLRgbColor(41,41,42, 1.0)] forControlState:UIControlStateNormal];
//        }
//    forKey:[FLGradientView class]];
//
//
//    return dictionary;
//}
//
//
//
//
//@implementation FLDarkMobileTheme
//
//
//- (id) initWithSavedThemeInfo:(FLSavedThemeInfo*) info; 
//{
//	self.fontSize = FLThemeTextSizeMedium;
//
//	if((self = [super initWithSavedThemeInfo:info]))
//	{
//		self.name = @"Dark";
//
//		self.gradientEndColor = FLRgbColor(41,41,42, 1.0);
//		self.gradientStartColor = FLRgbColor(69,69,71,1.0);
//		self.cellBackgroundColor = FLRgbColor(41,41,42,1.0);
//		self.valueTextColor = FLRgbColor(160,160,165,1.0);
//		self.tableHeaderTextColor = FLRgbColor(171,197,225,1.0);
//		self.titleTextColor =  [UIColor whiteColor];
//	
//		self.titleDescriptor = FLAutorelease(
//            [[FLTextDescriptor alloc] initWithFont:[UIFont BOLD_FONT_OF_SIZE:[self calculateActualFontSize]]
//                                      enabledColor:[UIColor whiteColor]
//                                enabledShadowColor:[UIColor blackColor]
//                                     disabledColor:[UIColor grayColor]
//                               disabledShadowColor:nil // [UIColor lightGrayColor]
//                                  highlightedColor:[UIColor whiteColor]
//                            highlightedShadowColor:[UIColor blackColor]
//                                     selectedColor:[UIColor lightBlueColor]
//                               selectedShadowColor:[UIColor blackColor]
//                                      shadowOffset:CGSizeZero]);
//
//		self.valueDescriptor = FLAutorelease(
//            [[FLTextDescriptor alloc] initWithFont:[UIFont FONT_OF_SIZE:[self calculateActualFontSize]]
//                                      enabledColor:self.valueTextColor
//                                enabledShadowColor:[UIColor blackColor]
//                                     disabledColor:[UIColor grayColor]
//                               disabledShadowColor:nil // [UIColor lightGrayColor]
//                                  highlightedColor:[UIColor whiteColor]
//                            highlightedShadowColor:[UIColor blackColor]
//                                     selectedColor:[UIColor lightBlueColor]
//                               selectedShadowColor:[UIColor blackColor]
//                                      shadowOffset:CGSizeZero]);
//	 
//		self.placeholderDescriptor = FLAutorelease(
//            [[FLTextDescriptor alloc] initWithFont:[UIFont FONT_OF_SIZE:[self calculateActualFontSize]]
//                                      enabledColor:[UIColor grayColor]
//                                enabledShadowColor:[UIColor blackColor]
//                                     disabledColor:nil
//                               disabledShadowColor:nil
//                                  highlightedColor:nil
//                            highlightedShadowColor:nil
//                                     selectedColor:nil
//                               selectedShadowColor:nil
//                                      shadowOffset:CGSizeZero]);
//	}
//	
//	return self;
//}
//
//- (void) applyThemeToTableViewCellTitleLabel:(FLLabel*) label
//{
//	label.backgroundColor = [UIColor clearColor];
//	label.textDescriptor = self.titleDescriptor;
//}
//
//- (void) applyThemeToTableViewCellValueLabel:(FLLabel*) label
//{
//	label.backgroundColor = [UIColor clearColor];
//	label.textDescriptor = self.valueDescriptor;
//}
//
//- (void) applyThemeToTableViewCellTitleWidget:(FLLabelWidget*) label
//{
//	label.textDescriptor = self.titleDescriptor;
//}
//
//- (void) applyThemeToTableViewCellValueWidget:(FLLabelWidget*) label
//{
//	label.textDescriptor = self.valueDescriptor;
//}
//
//- (void) applyThemeToTableViewCellTextField:(FLTextField*) field
//{
//	field.backgroundColor = [UIColor clearColor];
//	field.textDescriptor = self.valueDescriptor;
//}
//
//- (void) applyThemeToTableViewCellTextView:(FLTextView*) field
//{
//	field.backgroundColor = [UIColor clearColor];
//	field.textDescriptor = self.valueDescriptor;
//}
//- (void) applyThemeToNotificationView:(FLOldNotificationView*) object
//{
//	[object setNotificationViewStyle:FLOldNotificationViewStyleSquareCorners];
//	[object roundRectView].borderAlpha = 1.0;
//	[object roundRectView].fillColor = [UIColor blackColor];
//	[object roundRectView].borderColor = [UIColor grayColor];
//	[object roundRectView].fillAlpha = 0.85;
//
//	object.layer.shadowColor = [UIColor blackColor].CGColor;
//	object.layer.shadowOpacity = 1.0;
//	object.layer.shadowRadius = 10.0;
//	object.layer.shadowOffset = FLSizeMake(0,3);
//	
//	[[object roundRectView] setCornerRadius:0];
//	[[object roundRectView] setBorderLineWidth:1.0];
//
//#if VIEW_AUTOLAYOUT
//	if(FLContentModesAreEqual([object autoLayoutMode], FLContentModeNone))
//	{
//		[object setAutoLayoutMode:FLContentModeMake(FLContentModeHorizontalFill,FLContentModeVerticalBottom)];
//	}
//#endif
//}
//- (void) applyThemeToPhotoDetailsView:(FLOldNotificationView*) view
//{
//	[self applyThemeToNotificationView:view];
//}
////- (void) applyThemeToUserNotificationView:(FLOldUserNotificationView*) object
////{
////	[self applyThemeToNotificationView:object];
////	[[object roundRectView] setCornerRadius:0.0f];
////	
////}
//- (void) applyThemeToPinEditingView:(FLPinEditingView*) view
//{
//}
//- (void) applyThemeToProgressView:(FLLegacySimpleProgressView*) object
//{
//}
//
//- (void) applyThemeToTableViewHeaderView:(FLTableViewHeaderView*) object
//{
//	[object textLabel].font = [UIFont BOLD_FONT_OF_SIZE:[UIFont systemFontSize]];
//	[object textLabel].textColor = self.tableHeaderTextColor;
//	[object textLabel].shadowColor = [UIColor gray20Color];
//	[[object textLabel] addGlow];
//}
//- (void) applyThemeToTableViewCellBackgroundView:(FLTableViewCellBackgroundView*) object
//{
//	[object setFillColor:self.cellBackgroundColor];		  
//	[object setBorderColor:[UIColor darkGrayColor]];
//}
//- (void) applyThemeToTableViewCellBackgroundWidget:(FLTableViewCellSectionWidget*) object
//{
//	[object setFillColor:self.cellBackgroundColor];		  
//	[object setBorderColor:[UIColor darkGrayColor]];
//}
//- (void) applyThemeToGradientView:(FLGradientView*) object
//{
//	[object setColorRange:[FLColorRange colorRange:self.gradientStartColor endColor:self.gradientEndColor] forControlState:UIControlStateNormal];
//}
//
//- (void) applyThemeToTextEditView:(FLTextEditView*) view
//{
////	[view setGradientColors:self.gradientStartColor endColor:self.gradientEndColor];
//
//	view.textViewFrameView.fillColor = self.cellBackgroundColor;
//	view.textViewFrameView.borderColor = [UIColor darkGrayColor];
//	view.textDescriptor = self.valueDescriptor;
//}
//
//- (void) applyThemeToGradientWidget:(FLGradientWidget*) object
//{
//	[object setColorRange:[FLColorRange colorRange:self.gradientStartColor endColor:self.gradientEndColor] forControlState:UIControlStateNormal];
//}
//
//- (void) applyThemeToGradientButton:(id) button
//{
//	[button setButtonColorizer:FLGradientButtonDarkGray];
//}
//
//- (void) applyThemeToFatButton:(FLGradientButton*) button
//{
//	button.buttonColorizer = FLGradientButtonDarkGray;
//}
//
//- (void) applyThemeToToolbarButton:(FLToolbarButtonDeprecated*) button
//{
//	button.buttonColorizer = FLGradientButtonBlack; 
//}
//
//- (void) applyThemeToButton:(FLButton*) button {
////    [button applyThemeStyle:^(FLButton* theButton) {
////        [theButton setShapeToRoundRect:8.0f];
////        [theButton.shapeWidget setCornerRadius:12];
////        [theButton.shapeWidget setBorderColor:[UIColor gray15Color]];
////    }];
//}
//- (void) applyThemeToAlert:(FLAlert*) button {
//
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
//
//
//@end
