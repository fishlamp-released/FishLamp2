//
//	GtMobileThemes.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtTheme.h"

#import "GtTextDescriptor.h"

#import "GtTextEditView.h"
#import "GtUserHeaderView.h"

#import "GtOldProgressView.h"
#import "GtUserNotificationView.h"
#import "GtLabelAndValueBaseCell.h"
#import "GtCheckMarkTableViewCell.h"
#import "GtBannerTableViewCell.h"

#import "GtSliderValueCell.h"
#import "GtTableViewHeaderView.h"
#import "GtTableViewCellBackgroundView.h"
#import "GtGradientView.h"
#import "GtOnOffSwitchCell.h"
#import "GtPinEditingView.h"

#import "GtTextField.h"
#import "GtTextView.h"
#import "GtGradientButton.h"
#import "GtGradientWidget.h"
#import "GtLabelWidget.h"
#import "GtTableViewCellSectionWidget.h"
#import "GtProgressViewController.h"


@protocol GtTableTheme <NSObject>
- (void) applyThemeToTableViewCellTitleLabel:(GtLabel*) label;
- (void) applyThemeToTableViewCellValueLabel:(GtLabel*) label;

- (void) applyThemeToTableViewCellTitleWidget:(GtLabelWidget*) label;
- (void) applyThemeToTableViewCellValueWidget:(GtLabelWidget*) label;

- (void) applyThemeToTableViewHeaderView:(GtTableViewHeaderView*) object;
- (void) applyThemeToTableViewCellBackgroundView:(GtTableViewCellBackgroundView*) object;
- (void) applyThemeToTableViewCellBackgroundWidget:(GtTableViewCellSectionWidget*) object;

- (void) applyThemeToTableViewCellTextField:(GtTextField*) field;
- (void) applyThemeToTableViewCellTextView:(GtTextView*) field;
@end

@protocol GtViewsTheme <NSObject>
- (void) applyThemeToUserNotificationViewController:(GtUserNotificationViewController*) object;
- (void) applyThemeToNotificationViewController:(GtNotificationViewController*) object;
- (void) applyThemeToProgressViewController:(GtProgressViewController*) object;
- (void) applyThemeToGradientView:(GtGradientView*) object;
- (void) applyThemeToGradientWidget:(GtGradientWidget*) object;
- (void) applyThemeToPinEditingView:(GtPinEditingView*) view;
@end

@protocol GtButtonsTheme <NSObject>
- (void) applyThemeToGradientButton:(GtGradientButton*) button;
- (void) applyThemeToFatButton:(GtGradientButton*) button;
- (void) applyThemeToToolbarButton:(GtToolbarButton*) button;
@end

@protocol GtPhotoViewsTheme <NSObject>
- (void) applyThemeToPhotoDetailsViewController:(GtNotificationViewController*) view;
@end

@protocol GtMobileTheme <
	GtTableTheme, 
	GtViewsTheme, 
	GtButtonsTheme, 
	GtPhotoViewsTheme,
	GtTextEditViewTheme,
	GtUserHeaderViewTheme>
@end


@interface GtMobileTheme : GtTheme {
@private
	GtTextDescriptor* m_titleDescriptor;
	GtTextDescriptor* m_valueDescriptor;
	GtTextDescriptor* m_placeholderDescriptor;
	UIColor* m_gradientStartColor;
	UIColor* m_gradientEndColor;
	UIColor* m_cellBackgroundColor;
	UIColor* m_valueTextColor;
	UIColor* m_tableHeaderTextColor;
	UIColor* m_titleTextColor;
}

-(CGFloat) calculateActualFontSize;


@property (readwrite, retain, nonatomic) GtTextDescriptor* titleDescriptor;
@property (readwrite, retain, nonatomic) GtTextDescriptor* valueDescriptor;
@property (readwrite, retain, nonatomic) GtTextDescriptor* placeholderDescriptor;

@property (readwrite, retain, nonatomic) UIColor* gradientStartColor;
@property (readwrite, retain, nonatomic) UIColor* gradientEndColor;
@property (readwrite, retain, nonatomic) UIColor* cellBackgroundColor;
@property (readwrite, retain, nonatomic) UIColor* valueTextColor;
@property (readwrite, retain, nonatomic) UIColor* tableHeaderTextColor;
@property (readwrite, retain, nonatomic) UIColor* titleTextColor;

- (void) applyThemeToStatusBar;
- (void) applyThemeToNavigationController:(UINavigationController*) navigationController;

@end




