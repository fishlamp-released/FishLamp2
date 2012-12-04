//
//	FLTwoLineLabelAndValueCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLTwoLineLabelAndValueCell.h"

#define kHeightOffset -2

@implementation FLTwoLineLabelAndValueCell

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

+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell
{
	return autorelease_([[FLTwoLineLabelAndValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([self class])]);
}

+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label
{
	FLTwoLineLabelAndValueCell* cell = [FLTwoLineLabelAndValueCell twoLineLabelAndValueCell];
	if(FLStringIsNotEmpty(label))
	{
		cell.textLabelText = label;
	}
	
	return cell;
}

+ (FLTwoLineLabelAndValueCell*) twoLineLabelAndValueCell:(NSString*) label value:(NSString*) value
{
	FLTwoLineLabelAndValueCell* cell = [FLTwoLineLabelAndValueCell twoLineLabelAndValueCell:label];
	if(FLStringIsNotEmpty(value))
	{
		cell.valueLabelText = value;
	}
	return cell;
}


- (void) calculateCellHeightInTable:(UITableView *)tableView
{	
	FLSize labelSize = [self textLabelSizeForContentViewWidth:[self layoutRectWidthFromTableView:tableView]];

	FLSize valueSize = [self valueTextSizeForContentViewWidth:[self layoutRectWidthFromTableView:tableView]];

	self.cellHeight = labelSize.height + valueSize.height + kHeightOffset + self.sectionPadding.top + self.sectionPadding.bottom;
}

- (void) positionAndSizeTextLabel
{
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	FLRect layoutRect = self.layoutRect;

	FLRect labelRect = layoutRect;
	labelRect.size.height = [self textLabelSizeForContentViewWidth:layoutRect.size.width].height;
	self.label.frameOptimizedForSize = labelRect;
	
	FLRect valueRect = layoutRect;
	valueRect = FLRectAlignRectVertically(labelRect, valueRect);
	valueRect.origin.y += kHeightOffset;
	valueRect.size.height = FLRectGetBottom(layoutRect) - valueRect.origin.y;
	self.valueLabel.view.frameOptimizedForSize = valueRect;
}

@end
