//
//  GtDarkMobileTheme.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/7/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDarkMobileTheme.h"

@implementation UIFont (Georgia)

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

@end

#if NEW_FONTS

#define BOLD_FONT_OF_SIZE boldGeorgiaFontOfSize
#define FONT_OF_SIZE georgiaFontOfSize
#else
#define BOLD_FONT_OF_SIZE boldSystemFontOfSize
#define FONT_OF_SIZE systemFontOfSize


#endif


NSMutableDictionary* GtGetDarkMobileTheme()
{
    NSMutableDictionary* dictionary = [NSMutableDictionary dictionary];

    [dictionary setObject:^(id object) {
        [object setGradientColors:GtRgbColor(69,69,71,1.0) endColor:GtRgbColor(41,41,42, 1.0)];
        }
    forKey:NSStringFromClass([GtGradientView class])];


    return dictionary;
}




@implementation GtDarkMobileTheme


- (id) initWithSavedThemeInfo:(GtSavedThemeInfo*) info; 
{
	self.fontSize = GtThemeTextSizeMedium;

	if((self = [super initWithSavedThemeInfo:info]))
	{
		self.name = @"Dark";

		self.gradientEndColor = GtRgbColor(41,41,42, 1.0);
		self.gradientStartColor = GtRgbColor(69,69,71,1.0);
		self.cellBackgroundColor = GtRgbColor(41,41,42,1.0);
		self.valueTextColor = GtRgbColor(160,160,165,1.0);
		self.tableHeaderTextColor = GtRgbColor(171,197,225,1.0);
		self.titleTextColor =  [UIColor whiteColor];
	
		self.titleDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont BOLD_FONT_OF_SIZE:[self calculateActualFontSize]]
                                                                              enabledColor:[UIColor whiteColor]
                                                                        enabledShadowColor:[UIColor blackColor]
                                                                             disabledColor:[UIColor grayColor]
                                                                       disabledShadowColor:nil // [UIColor lightGrayColor]
                                                                          highlightedColor:[UIColor whiteColor]
                                                                    highlightedShadowColor:[UIColor blackColor]
                                                                             selectedColor:[UIColor lightBlueColor]
                                                                       selectedShadowColor:[UIColor blackColor]
                                                                              shadowOffset:CGSizeZero]);

		self.valueDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont FONT_OF_SIZE:[self calculateActualFontSize]]
                                                                              enabledColor:self.valueTextColor
                                                                        enabledShadowColor:[UIColor blackColor]
                                                                             disabledColor:[UIColor grayColor]
                                                                       disabledShadowColor:nil // [UIColor lightGrayColor]
                                                                          highlightedColor:[UIColor whiteColor]
                                                                    highlightedShadowColor:[UIColor blackColor]
                                                                             selectedColor:[UIColor lightBlueColor]
                                                                       selectedShadowColor:[UIColor blackColor]
                                                                              shadowOffset:CGSizeZero]);
	 
		self.placeholderDescriptor = GtReturnAutoreleased([[GtTextDescriptor alloc] initWithFont:[UIFont FONT_OF_SIZE:[self calculateActualFontSize]]
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
- (void) applyThemeToNotificationViewController:(GtNotificationViewController*) controller
{
	[controller.notificationView setNotificationViewStyle:GtNotificationViewStyleSquareCorners];
	[controller.notificationView roundRectView].borderAlpha = 1.0;
	[controller.notificationView roundRectView].fillColor = [UIColor blackColor];
	[controller.notificationView roundRectView].borderColor = [UIColor grayColor];
	[controller.notificationView roundRectView].fillAlpha = 0.85;

	controller.notificationView.layer.shadowColor = [UIColor blackColor].CGColor;
	controller.notificationView.layer.shadowOpacity = 1.0;
	controller.notificationView.layer.shadowRadius = 10.0;
	controller.notificationView.layer.shadowOffset = CGSizeMake(0,3);
	
	[[controller.notificationView roundRectView] setCornerRadius:0];
	[[controller.notificationView roundRectView] setBorderLineWidth:1.0];

	if(GtRectLayoutEqualToRectLayout([controller autoLayoutMode], GtRectLayoutNone))
	{
		[controller setAutoLayoutMode:GtRectLayoutMake(GtRectLayoutHorizontalFill,GtRectLayoutVerticalBottom)];
	}
}
- (void) applyThemeToPhotoDetailsViewController:(GtNotificationViewController*) view
{
	[self applyThemeToNotificationViewController:view];
}
- (void) applyThemeToUserNotificationViewController:(GtUserNotificationViewController*) controller
{
	[self applyThemeToNotificationViewController:controller];
	[[controller.userNotificationView roundRectView] setCornerRadius:0.0f];
}
- (void) applyThemeToPinEditingView:(GtPinEditingView*) view
{
}
- (void) applyThemeToProgressViewController:(GtProgressViewController*) controller
{
	if(!GtRectLayoutIsValid([controller autoLayoutMode]) || GtRectLayoutEqualToRectLayout(controller.autoLayoutMode, GtRectLayoutNone))
	{
		[controller setAutoLayoutMode: GtRectLayoutCentered];
	}
}

- (void) applyThemeToTableViewHeaderView:(GtTableViewHeaderView*) object
{
	[object textLabel].font = [UIFont BOLD_FONT_OF_SIZE:[UIFont systemFontSize]];
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
