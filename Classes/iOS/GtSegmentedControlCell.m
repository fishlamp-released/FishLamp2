//
//	GtSegmentedControlCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/24/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSegmentedControlCell.h"


@implementation GtSegmentedControlCell

@synthesize segmentedControl = m_control;

- (id) initWithSegmentedControlStyle:(UISegmentedControlStyle) style items:(NSArray*) items
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtSegmentedControlCell"]))
	{
		self.cellHeight = 40.0f;
		self.selectionStyle = UITableViewCellSelectionStyleNone;
		self.backgroundColor = [UIColor clearColor];
		self.sectionWidget.drawMode = GtTableViewCellSectionDrawModeNone;

		m_control.backgroundColor = [UIColor clearColor];
		m_control = [[UISegmentedControl alloc] initWithItems:items];
		m_control.segmentedControlStyle = style;
		m_control.tintColor = [UIColor darkGrayColor];
		
		[self addSubview:m_control];
		
		if(m_control.numberOfSegments)
		{
			m_control.selectedSegmentIndex = 0;
		}
	}
	
	return self;
}

+ (GtSegmentedControlCell*) segmentedControlCell:(UISegmentedControlStyle) style items:(NSArray*) items;
{
	return GtReturnAutoreleased([[GtSegmentedControlCell alloc] initWithSegmentedControlStyle:style items:items]);
}

- (void) dealloc
{
	GtRelease(m_control);
	GtSuperDealloc();
}

- (void) enabledStateDidChange
{
	m_control.enabled = self.canEditData;
	[super enabledStateDidChange];
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	m_control.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, GtRectSetSize(m_control.frame, m_control.numberOfSegments * 80, 40.0f));
}


@end
