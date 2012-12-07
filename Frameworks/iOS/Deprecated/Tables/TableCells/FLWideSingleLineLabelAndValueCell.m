//
//	FLWideSingleLineLabelAndValueCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLWideSingleLineLabelAndValueCell.h"


@implementation FLWideSingleLineLabelAndValueCell 


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier		
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		[self.valueLabel setTextAlignment: UITextAlignmentRight];
		self.cellHeight = FLWideSingleLineLabelAndValueCellDefaultHeight;
		
		self.label.lineBreakMode = UILineBreakModeTailTruncation;
	}
	return self;
}

- (void) layoutLabels:(CGRect) contentViewBounds
{
	CGRect valueRect = FLRectCenterRectInRectVertically(contentViewBounds, self.valueLabel.labelView.frame);
	
	CGRect titleRect = FLRectCenterRectInRectVertically(contentViewBounds, self.label.frame);
	titleRect.origin.x = contentViewBounds.origin.x;
	titleRect = FLRectSetWidth(titleRect, MIN(titleRect.size.width, contentViewBounds.size.width - valueRect.size.width));
	
	valueRect = FLRectJustifyRectInRectRight(contentViewBounds, valueRect);
	
	self.label.frameOptimizedForSize = titleRect;
	self.valueLabel.view.frameOptimizedForSize = valueRect;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	[self.valueLabel.labelView sizeToFitText];
	[self.label sizeToFitText];
	
	[self layoutLabels:self.layoutRect];
}

- (void) adjustSpinnerFrame
{
	[super adjustSpinnerFrame];
	self.spinner.frame = FLRectJustifyRectInRectRight(self.valueLabel.view.frame, self.spinner.frame);
}

+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell
{
	return FLAutorelease([[FLWideSingleLineLabelAndValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLWideSingleLineLabelAndValueCell"]);
}


+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label
{
	FLWideSingleLineLabelAndValueCell* cell = [FLWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell];
	if(FLStringIsNotEmpty(label))
	{
		cell.textLabelText = label;
	}
	
	return cell;
}

+ (FLWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label value:(NSString*) value
{
	FLWideSingleLineLabelAndValueCell* cell = [FLWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:label];
	if(FLStringIsNotEmpty(value))
	{
		cell.valueLabel.text = value;
	}
	return cell;
}



@end