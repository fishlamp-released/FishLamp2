//
//	FLContentBehaviorTableViewCell.h
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLWidget.h"
#import "FLTableViewCellAccessoryWidget.h"
#import "FLTableViewCellSectionWidget.h"
#import "FLTableCellBackgroundWidget.h"
#import "FLLabelWidget.h"
#import "FLLabel.h"

@class FLTableView;

@interface FLTableViewCell : UITableViewCell<FLTableViewRowHeightCalculator> {
@private
	FLWidget* _widget;
//	FLTableCellBackgroundWidget* _background;
	FLTableViewCellAccessoryWidget* _accessory;
	FLTableViewCellSectionWidget* _sectionWidget;
	FLLabel* _replacementLabel; // TODO: this sucks
	UIEdgeInsets _sectionMargins;
	UIEdgeInsets _sectionPadding;
	CGFloat _cellHeight;
	UITableViewCellSelectionStyle _customSelectionStyle;
	UITableViewCellAccessoryType _customAccessoryType;
	struct { 
		unsigned int tableWantsBorder: 1;
		unsigned int disabled: 1;
	} _widgetCellState;
}

@property (readwrite, assign, nonatomic) UITableViewCellSelectionStyle customSelectionStyle;
@property (readwrite, assign, nonatomic) UITableViewCellAccessoryType customAccessoryType;

@property (readwrite, assign, nonatomic) BOOL disabled;
@property (readwrite, assign, nonatomic) CGFloat cellHeight;

@property (readwrite, assign, nonatomic) UIEdgeInsets sectionMargins;
@property (readonly, assign, nonatomic) BOOL willDrawSection; 
@property (readwrite, assign, nonatomic) UIEdgeInsets sectionPadding; // padding is ignored if sections not drawn

@property (readonly, retain, nonatomic) FLTableViewCellSectionWidget* sectionWidget;
@property (readonly, retain, nonatomic) FLTableViewCellAccessoryWidget* accessoryWidget;

@property(nonatomic,readonly,retain) FLLabel	  *label; // lazy created, if you call this is well be created.
@property (readwrite, retain, nonatomic) NSString* textLabelText; // will create label if needed.

- (id) initWithReuseIdentifier:(NSString *)reuseIdentifier;
+ (id) tableViewCell:(NSString *)reuseIdentifier;

- (FLRect) layoutRect;
- (CGFloat) layoutRectWidthFromTableView:(UITableView*) tableView;

- (FLWidget*) widget;
- (void) setWidget:(FLWidget*) Widget;

- (void) positionAndSizeTextLabel;

- (void) willShowInTable:(FLTableView*) tableView atIndexPath:(NSIndexPath*) indexPath;
- (void) calculateCellHeightInTable:(UITableView *)tableView;

- (void) enabledStateDidChange;

+ (FLSize) calculateLabelSize:(UILabel*) label
	layoutRectWidth:(CGFloat) layoutRectWidth
	returnValidHeight:(BOOL) returnValidHeight;

- (FLSize) textLabelSizeForContentViewWidth:(CGFloat) width;

- (void) updateTextLabelSizeWithLayoutRectWidth:(CGFloat) layoutRectWidth;

@end

@interface FLSimpleTextItemTableViewCell : FLTableViewCell
@end

#ifdef __IPHONE_5_0
typedef NSInteger NSIndexPathRowType;
#else
typedef NSUInteger NSIndexPathRowType;
#endif