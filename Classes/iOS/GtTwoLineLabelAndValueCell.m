//
//	GtTwoLineLabelAndValueCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwoLineLabelAndValueCell.h"

#define kHeightOffset -2

@implementation GtTwoLineLabelAndValueCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		if(self.valueLabel.viewIsLabelView)
		{
			UILabel* label = (UILabel*) self.valueLabel.labelView;
			label.lineBreakMode = UILineBreakModeTailTruncation; 
			label.numberOfLines = 0;
		}
	}
	
	return self;
}

+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell
{
	return GtReturnAutoreleased([[GtTwoLineLabelAndValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
}

+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label
{
	GtTwoLineLabelAndValueCell* cell = [GtTwoLineLabelAndValueCell twoLineLabelAndValueCell];
	if(GtStringIsNotEmpty(label))
	{
		cell.textLabelText = label;
	}
	
	return cell;
}

+ (GtTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label value:(NSString*) value
{
	GtTwoLineLabelAndValueCell* cell = [GtTwoLineLabelAndValueCell twoLineLabelAndValueCell:label];
	if(GtStringIsNotEmpty(value))
	{
		cell.valueLabelText = value;
	}
	return cell;
}


- (void) calculateCellHeightInTable:(UITableView *)tableView
{	
	CGSize labelSize = [self textLabelSizeForContentViewWidth:[self layoutRectWidthFromTableView:tableView]];

	CGSize valueSize = [self valueTextSizeForContentViewWidth:[self layoutRectWidthFromTableView:tableView]];

	self.cellHeight = labelSize.height + valueSize.height + kHeightOffset + self.sectionPadding.top + self.sectionPadding.bottom;
}

- (void) positionAndSizeTextLabel
{
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	CGRect layoutRect = self.layoutRect;

	CGRect labelRect = layoutRect;
	labelRect.size.height = [self textLabelSizeForContentViewWidth:layoutRect.size.width].height;
	self.label.frameOptimizedForSize = labelRect;
	
	CGRect valueRect = layoutRect;
	valueRect = GtRectAlignRectVertically(labelRect, valueRect);
	valueRect.origin.y += kHeightOffset;
	valueRect.size.height = GtRectGetBottom(layoutRect) - valueRect.origin.y;
	self.valueLabel.view.frameOptimizedForSize = valueRect;
}

@end
