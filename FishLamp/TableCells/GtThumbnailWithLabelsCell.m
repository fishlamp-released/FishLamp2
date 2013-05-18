//
//  PhotoDetailsThumbnailCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtThumbnailWithLabelsCell.h"

@implementation GtThumbnailWithLabelsCell

#define RowLeft 100.0
#define RowTop 10.0
#define RowHeight 20.0

#define LabelLeft 80.0
#define LabelTop 10.0

- (void) privateInit
{
/*
	m_row1 = [[GtSingleLineLabelAndValueViewFormatter alloc] initWithView:self];
	m_row2 = [[GtSingleLineLabelAndValueViewFormatter alloc] initWithView:self];
	
	m_row1.rightLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
	m_row2.rightLabel.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];

	m_row1.location = CGPointMake(RowLeft, RowTop);
	m_row2.location = CGPointMake(RowLeft, RowTop + RowHeight);
*/

	m_row1 = [GtAlloc(GtLabelAndValueView) initWithFrame:CGRectMake(LabelLeft,LabelTop, 180, GtDefaultLabelHeight)];
	m_row2 = [GtAlloc(GtLabelAndValueView) initWithFrame:CGRectMake(LabelLeft,GtDefaultLabelHeight+LabelTop, 180, GtDefaultLabelHeight)];
	[self.contentView addSubview:m_row1];
	[self.contentView addSubview:m_row2];
	GtRelease(m_row1);
	GtRelease(m_row2);
	
	self.backgroundColor = [UIColor whiteColor];
	self.autoresizesSubviews = NO;
	self.autoresizingMask = UIViewAutoresizingNone;
}

- (CGFloat) cellHeight
{
	return ThumbnailHeight+3;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
	{
		[self privateInit];
	}
    return self;
}

#if FISHLAMP_IPHONE_2_SDK
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
	if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{
    }
    return self;
}
#endif

- (void) updateTextRow1:(NSString*) label
	value:(NSString*) value
{
	m_row1.label.text = label;
	m_row1.value.text = value;
}
	
- (void) updateTextRow2:(NSString*) label
	value:(NSString*) value
{
	m_row2.label.text = label;
	m_row2.value.text = value;
}

- (void) layoutSubviews
{
/*
	if(m_displayDataRow)
	{
		GtDisplayDataBinding* binding1 = [m_displayDataRow dataBindingForId:GtRowOneBindingID];
		[self updateTextRow1:binding1.label value:binding1.displayStringFromValue];

		GtDisplayDataBinding* binding2 = [m_displayDataRow dataBindingForId:GtRowTwoBindingID];
		[self updateTextRow2:binding2.label value:binding2.displayStringFromValue];
	}
*/	
	
	
/*
	CGRect parentFrame = self.superview.bounds;
	self.frame = CGRectInset(parentFrame, 10, 10);

	CGRect frame = self.bounds;
	frame.origin.x += 100;
	frame.size.width -= 100;
	
	m_row1.frame = frame;
	
	frame.origin.y += 20;
	
	m_row2.frame = frame;
*/
	[super layoutSubviews];
}

- (CGFloat) rowHeight
{
	return ThumbnailHeight;// [super rowHeight] + 3;
}

- (CGRect) thumbFrame
{
	CGRect myFrame = [super thumbFrame];
	myFrame.origin.x += 10;
	myFrame.origin.y += 1;
	return myFrame;
}

- (void) dealloc
{
	[super dealloc];
}

@end

#endif