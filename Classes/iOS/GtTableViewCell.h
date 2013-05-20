//
//	GtContentBehaviorTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtWidget.h"
#import "GtTableViewCellAccessoryWidget.h"
#import "GtTableViewCellSectionWidget.h"
#import "GtTableCellBackgroundWidget.h"
#import "GtLabelWidget.h"
#import "GtLabel.h"

@class GtTableView;

@interface GtTableViewCell : UITableViewCell<GtTableViewRowHeightCalculator> {
@private
	GtWidget* m_widget;
	GtTableCellBackgroundWidget* m_background;
	GtTableViewCellAccessoryWidget* m_accessory;
	GtTableViewCellSectionWidget* m_sectionWidget;
	GtLabel* m_textLabel;
	GtThemeState m_themeState;
	UIEdgeInsets m_sectionMargins;
	UIEdgeInsets m_sectionPadding;
	CGFloat m_cellHeight;
	UITableViewCellSelectionStyle m_customSelectionStyle;
	UITableViewCellAccessoryType m_customAccessoryType;
	struct { 
		unsigned int tableWantsBorder: 1;
		unsigned int disabled: 1;
	} m_widgetCellState;
}

@property (readwrite, assign, nonatomic) UITableViewCellSelectionStyle customSelectionStyle;
@property (readwrite, assign, nonatomic) UITableViewCellAccessoryType customAccessoryType;

@property (readwrite, assign, nonatomic) BOOL disabled;
@property (readwrite, assign, nonatomic) CGFloat cellHeight;

@property (readwrite, assign, nonatomic) UIEdgeInsets sectionMargins;
@property (readonly, assign, nonatomic) BOOL willDrawSection; 
@property (readwrite, assign, nonatomic) UIEdgeInsets sectionPadding; // padding is ignored if sections not drawn

@property (readonly, retain, nonatomic) GtTableViewCellSectionWidget* sectionWidget;
@property (readonly, retain, nonatomic) GtTableViewCellAccessoryWidget* accessoryWidget;

@property(nonatomic,readonly,retain) GtLabel	  *label; // lazy created, if you call this is well be created.
@property (readwrite, retain, nonatomic) NSString* textLabelText; // will create label if needed.

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (id) tableViewCell:(NSString *)reuseIdentifier;

- (CGRect) layoutRect;
- (CGFloat) layoutRectWidthFromTableView:(UITableView*) tableView;

- (GtWidget*) widget;
- (void) setWidget:(GtWidget*) Widget;

- (void) positionAndSizeTextLabel;

- (void) willShowInTable:(GtTableView*) tableView atIndexPath:(NSIndexPath*) indexPath;
- (void) calculateCellHeightInTable:(UITableView *)tableView;

- (void) enabledStateDidChange;

+ (CGSize) calculateLabelSize:(UILabel*) label
	layoutRectWidth:(CGFloat) layoutRectWidth
	returnValidHeight:(BOOL) returnValidHeight;

- (CGSize) textLabelSizeForContentViewWidth:(CGFloat) width;

- (void) updateTextLabelSizeWithLayoutRectWidth:(CGFloat) layoutRectWidth;

@end

@interface GtSimpleTextItemTableViewCell : GtTableViewCell
@end

#ifdef __IPHONE_5_0
typedef NSInteger NSIndexPathRowType;
#else
typedef NSUInteger NSIndexPathRowType;
#endif