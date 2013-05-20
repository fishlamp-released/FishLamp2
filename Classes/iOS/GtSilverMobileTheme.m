//
//  GtSilverMobileTheme.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSilverMobileTheme.h"


@implementation GtSilverMobileTheme



- (id) initWithSavedThemeInfo:(GtSavedThemeInfo*) info; 
{
	self.fontSize = GtThemeTextSizeMedium;

	if((self = [super initWithSavedThemeInfo:info]))
	{
		self.name = @"Silver";

		self.gradientEndColor = [UIColor grayColor] ; //GtRgbColor(41,41,42, 1.0);
		self.gradientStartColor = [UIColor lightGrayColor] ; // GtRgbColor(69,69,71,1.0);
		self.cellBackgroundColor = [UIColor lightGrayColor]; //GtRgbColor(41,41,42,1.0);
		self.valueTextColor = [UIColor darkGrayColor]; // GtRgbColor(160,160,165,1.0);
		self.tableHeaderTextColor = GtRgbColor(171,197,225,1.0);
		self.titleTextColor = [UIColor blackColor]; // [UIColor whiteColor];
	
		self.titleDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont boldSystemFontOfSize:[self calculateActualFontSize]]
			enabledColor:[UIColor whiteColor]
			enabledShadowColor:[UIColor blackColor]
			disabledColor:[UIColor darkGrayColor]
			disabledShadowColor:nil // [UIColor lightGrayColor]
			highlightedColor:[UIColor whiteColor]
			highlightedShadowColor:[UIColor blackColor]
			selectedColor:[UIColor lightBlueColor]
			selectedShadowColor:[UIColor blackColor]
			shadowOffset:CGSizeZero]);

		self.valueDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont systemFontOfSize:[self calculateActualFontSize]]
			enabledColor:self.valueTextColor
			enabledShadowColor:[UIColor blackColor]
			disabledColor:[UIColor darkGrayColor]
			disabledShadowColor:nil // [UIColor lightGrayColor]
			highlightedColor:[UIColor whiteColor]
			highlightedShadowColor:[UIColor blackColor]
			selectedColor:[UIColor lightBlueColor]
			selectedShadowColor:[UIColor blackColor]
			shadowOffset:CGSizeZero]);
	 
		self.placeholderDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont systemFontOfSize:[self calculateActualFontSize]]
			enabledColor:[UIColor grayColor]
			enabledShadowColor:[UIColor blackColor]
			disabledColor:nil
			disabledShadowColor:nil
			highlightedColor:nil
			highlightedShadowColor:nil
			selectedColor:nil
			selectedShadowColor:nil
			shadowOffset:CGSizeZero]);
	}
	
	return self;
}

- (void) applyThemeToTableViewCellTitleLabel:(GtLabel*) label
{
	label.backgroundColor = [UIColor clearColor];
	label.textDescriptor = self.titleDescriptor;
}

- (void) applyThemeToTableViewCellValueLabel:(GtLabel*) label
{
	label.backgroundColor = [UIColor clearColor];
	label.textDescriptor = self.valueDescriptor;
}

- (void) applyThemeToTableViewCellTitleWidget:(GtLabelWidget*) label
{
	label.textDescriptor = self.titleDescriptor;
}

- (void) applyThemeToTableViewCellValueWidget:(GtLabelWidget*) label
{
	label.textDescriptor = self.valueDescriptor;
}

- (void) applyThemeToTableViewCellTextField:(GtTextField*) field
{
	field.backgroundColor = [UIColor clearColor];
	field.textDescriptor = self.valueDescriptor;
}

- (void) applyThemeToTableViewCellTextView:(GtTextView*) field
{
	field.backgroundColor = [UIColor clearColor];
	field.textDescriptor = self.valueDescriptor;
}
- (void) applyThemeToNotificationViewController:(GtNotificationView*) object
{
	[object setNotificationViewStyle:GtNotificationViewStyleSquareCorners];
	[object roundRectView].borderAlpha = 1.0;
	[object roundRectView].fillColor = [UIColor blackColor];
	[object roundRectView].borderColor = [UIColor grayColor];
	[object roundRectView].fillAlpha = 0.85;

	object.layer.shadowColor = [UIColor blackColor].CGColor;
	object.layer.shadowOpacity = 1.0;
	object.layer.shadowRadius = 10.0;
	object.layer.shadowOffset = CGSizeMake(0,3);
	
	[[object roundRectView] setCornerRadius:0];
	[[object roundRectView] setBorderLineWidth:1.0];

#if VIEW_AUTOLAYOUT
	if(GtRectLayoutEqualToRectLayout([object autoLayoutMode], GtRectLayoutNone))
	{
		[object setAutoLayoutMode:GtRectLayoutMake(GtRectLayoutHorizontalFill,GtRectLayoutVerticalBottom)];
	}
#endif
}
- (void) applyThemeToPhotoDetailsViewController:(GtNotificationView*) view
{
	[self applyThemeToNotificationViewController:view];
}
- (void) applyThemeToUserNotificationView:(GtUserNotificationView*) object
{
	[self applyThemeToNotificationViewController:object];
	[[object roundRectView] setCornerRadius:0.0f];
	
}
- (void) applyThemeToPinEditingView:(GtPinEditingView*) view
{
}
- (void) applyThemeToProgressView:(GtOldProgressView*) object
{
#if VIEW_AUTOLAYOUT
	if(!GtRectLayoutIsValid([object autoLayoutMode]) || GtRectLayoutEqualToRectLayout(object.autoLayoutMode, GtRectLayoutNone))
	{
		[object setAutoLayoutMode: GtRectLayoutCentered];
	}
#endif
}

- (void) applyThemeToTableViewHeaderView:(GtTableViewHeaderView*) object
{
	[object textLabel].font = [UIFont boldSystemFontOfSize:[UIFont systemFontSize]];
	[object textLabel].textColor = self.tableHeaderTextColor;
	[object textLabel].shadowColor = [UIColor gray20Color];
	[[object textLabel] addGlow];
}
- (void) applyThemeToTableViewCellBackgroundView:(GtTableViewCellBackgroundView*) object
{
	[object setFillColor:self.cellBackgroundColor];		  
	[object setBorderColor:[UIColor darkGrayColor]];
}
- (void) applyThemeToTableViewCellBackgroundWidget:(GtTableViewCellSectionWidget*) object
{
	[object setFillColor:self.cellBackgroundColor];		  
	[object setBorderColor:[UIColor darkGrayColor]];
}
- (void) applyThemeToGradientView:(GtGradientView*) object
{
	[object setGradientColors:self.gradientStartColor endColor:self.gradientEndColor];
}

- (void) applyThemeToTextEditView:(GtTextEditView*) view
{
//	[view setGradientColors:self.gradientStartColor endColor:self.gradientEndColor];

	view.textViewFrameView.fillColor = self.cellBackgroundColor;
	view.textViewFrameView.borderColor = [UIColor darkGrayColor];
	view.textDescriptor = self.valueDescriptor;
}

- (void) applyThemeToGradientWidget:(GtGradientWidget*) object
{
	[object setGradientColors:self.gradientStartColor endColor:self.gradientEndColor];
}

- (void) applyThemeToGradientButton:(GtGradientButton*) button
{
	button.buttonColorizer = GtButtonDarkGray;
}

- (void) applyThemeToFatButton:(GtGradientButton*) button
{
	button.buttonColorizer = GtButtonDarkGray;
}

- (void) applyThemeToToolbarButton:(GtToolbarButton*) button
{
	button.buttonColorizer = GtButtonBlack; 
}

- (void) applyThemeToUserHeaderView:(GtUserHeaderView*) view
{
	view.nameLabel.textDescriptor = self.titleDescriptor;
}


@end
