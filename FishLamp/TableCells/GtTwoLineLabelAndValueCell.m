//
//  GtTwoLineLabelAndValueCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/28/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtTwoLineLabelAndValueCell.h"


@implementation GtTwoLineLabelAndValueCell

#define SPACE_BETWEEN_LABEL_AND_TEXT 0
#define TEXT_TOP (LABEL_TOP + LABEL_HEIGHT + SPACE_BETWEEN_LABEL_AND_TEXT)
#define A_LITTLE_EXTRA 6

- (CGFloat) cellHeight
{
	return MAX([self.rowData textHeight], GtDefaultSingleLineMinHeight) + 
		LABEL_TOP + LABEL_HEIGHT + SPACE_BETWEEN_LABEL_AND_TEXT + A_LITTLE_EXTRA;
}

+ (NSUInteger) defaultCellHeight
{
	return GtDefaultSingleLineMinHeight + LABEL_TOP + LABEL_HEIGHT + SPACE_BETWEEN_LABEL_AND_TEXT + A_LITTLE_EXTRA;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier 	
{
	if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
	{
		self.value.lineBreakMode = UILineBreakModeWordWrap;
		self.value.numberOfLines = 0;
	}
	
	return self;
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	CGRect superviewBounds = [self.label.superview bounds];
	
	CGRect labelFrame = superviewBounds;
	labelFrame.origin.y = LABEL_TOP;
	labelFrame.size.height = LABEL_HEIGHT;
	self.label.frame = CGRectInset(labelFrame, 10, 0);
	
	if(self.value)
	{
		CGRect valueFrame = superviewBounds;
		valueFrame.origin.y = TEXT_TOP;
		valueFrame.size.height = MAX([self.rowData textHeight], GtDefaultSingleLineMinHeight);
		
		if(valueFrame.origin.y + valueFrame.size.height > superviewBounds.size.height)
		{
			valueFrame.size.height = superviewBounds.size.height - valueFrame.origin.y;
			
		}
		
        valueFrame.origin.x += 10;
        valueFrame.size.width -= 20;
        
		self.value.frame = valueFrame; // CGRectInset(valueFrame, 10, 0);
	}
}


@end
