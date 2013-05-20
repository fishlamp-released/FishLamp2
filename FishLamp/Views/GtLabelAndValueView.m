//
//  GtLabelAndValueView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtLabelAndValueView.h"
#import "GtColors.h"

#define SpaceBetweenLabels 4.0

@implementation GtLabelAndValueView

@synthesize label = m_label;
@synthesize value = m_value;
@synthesize labelWidth = m_labelWidth;

- (id) initWithFrame:(CGRect) frame
{
	if(self = [super initWithFrame:frame])
	{
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingNone;
		/*	
			UIViewAutoresizingFlexibleLeftMargin |
								UIViewAutoresizingFlexibleWidth |
								UIViewAutoresizingFlexibleRightMargin |
								UIViewAutoresizingFlexibleTopMargin |
								UIViewAutoresizingFlexibleHeight |
								UIViewAutoresizingFlexibleBottomMargin;
		*/
		self.autoresizesSubviews = NO;
	
		m_label = [GtAlloc(UILabel) initWithFrame:CGRectZero];
		m_label.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		m_label.textColor = [UIColor blueLabelColor];
		m_label.textAlignment = UITextAlignmentRight;
		[self addSubview:m_label];
		GtRelease(m_label);
		
		m_value = [GtAlloc(UILabel) initWithFrame:CGRectZero];
		m_value.font = [UIFont boldSystemFontOfSize:[UIFont smallSystemFontSize]];
		m_value.textColor = [UIColor blackColor];
		
		[self addSubview:m_value];
		GtRelease(m_value);
		
		self.labelWidth = GtDefaultLabelWidth;
	}
	
	return self;
}

- (void)layoutSubviews
{
	[super layoutSubviews];

	CGRect bounds = self.bounds;
	
	CGRect labelFrame = bounds;
	labelFrame.size.height = GtDefaultLabelHeight;
	labelFrame.size.width = self.labelWidth;
	m_label.frame = labelFrame;
	
	CGRect valueFrame = bounds;
	valueFrame.size.height = GtDefaultLabelHeight;
	valueFrame.size.width = bounds.size.width - labelFrame.size.width - SpaceBetweenLabels;
	valueFrame.origin.x = labelFrame.size.width + SpaceBetweenLabels;
	
	m_value.frame = valueFrame;
	
}

@end



#endif