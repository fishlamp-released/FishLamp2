//
//	GtWideSingleLineLabelAndValueCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/28/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtWideSingleLineLabelAndValueCell.h"


@implementation GtWideSingleLineLabelAndValueCell 


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier		
{
	if((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]))
	{
		[self.valueLabel setTextAlignment: UITextAlignmentRight];
		self.cellHeight = GtWideSingleLineLabelAndValueCellDefaultHeight;
		
		self.label.lineBreakMode = UILineBreakModeTailTruncation;
	}
	return self;
}

- (void) layoutLabels:(CGRect) contentViewBounds
{
	CGRect valueRect = GtRectCenterRectInRectVertically(contentViewBounds, self.valueLabel.labelView.frame);
	
	CGRect titleRect = GtRectCenterRectInRectVertically(contentViewBounds, self.label.frame);
	titleRect.origin.x = contentViewBounds.origin.x;
	titleRect = GtRectSetWidth(titleRect, MIN(titleRect.size.width, contentViewBounds.size.width - valueRect.size.width));
	
	valueRect = GtRectJustifyRectInRectRight(contentViewBounds, valueRect);
	
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
	self.spinner.frame = GtRectJustifyRectInRectRight(self.valueLabel.view.frame, self.spinner.frame);
}

+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell
{
	return GtReturnAutoreleased([[GtWideSingleLineLabelAndValueCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtWideSingleLineLabelAndValueCell"]);
}


+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label
{
	GtWideSingleLineLabelAndValueCell* cell = [GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell];
	if(GtStringIsNotEmpty(label))
	{
		cell.textLabelText = label;
	}
	
	return cell;
}

+ (GtWideSingleLineLabelAndValueCell*) wideSingleLineLabelAndValueCell:(NSString*) label value:(NSString*) value
{
	GtWideSingleLineLabelAndValueCell* cell = [GtWideSingleLineLabelAndValueCell wideSingleLineLabelAndValueCell:label];
	if(GtStringIsNotEmpty(value))
	{
		cell.valueLabel.text = value;
	}
	return cell;
}



@end