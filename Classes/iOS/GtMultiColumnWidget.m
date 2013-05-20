//
//	GtMultiColumnWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiColumnWidget.h"

@implementation GtMultiColumnWidget

@synthesize visibleColumnCount = m_visibleColumnCount;
@synthesize style = m_style;
@synthesize columnWidth = m_columnWidth;
@synthesize resizeColumnsToFit = m_resizeColumns;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.style = GtMultiColumnWidgetStyleDynamic;
	}
	
	return self;
}

- (void) setVisibleColumnCount:(NSUInteger) columnCount
{
	m_visibleColumnCount = columnCount;
	
	NSUInteger i = 0;
	for(GtWidget* widget in self.subwidgets)
	{
		widget.hidden = (i++ >= m_visibleColumnCount);
	}
}

- (void) addSubwidget:(GtWidget *)widget
{	
	[super addSubwidget:widget];
	++m_visibleColumnCount;
}

- (void) removeSubwidget:(GtWidget*) widget
{
	[super removeSubwidget:widget];
	
	if(!widget.hidden)
	{
		--m_visibleColumnCount;
	}
}

- (void) layoutSubwidgets
{
	CGFloat columnWidth = self.style == GtMultiColumnWidgetStyleDynamic ? 
		(self.frame.size.width / (CGFloat) m_visibleColumnCount) :
		m_columnWidth;
		
	CGFloat height = self.frame.size.height;

	NSUInteger i = 0;
	CGFloat left = self.style == GtMultiColumnWidgetStyleRightJustified ? 
		GtRectGetRight(self.frame) - (m_columnWidth * m_visibleColumnCount) : 
		self.frame.origin.x;
	CGFloat top = self.frame.origin.y;
	
	for(GtWidget* widget in self.subwidgets)
	{
		if(!widget.isHidden)
		{
			if(m_resizeColumns)
			{
				widget.frameOptimizedForSize = CGRectMake(left + (i++ * columnWidth), top, columnWidth, height);
				[widget setNeedsLayout];
			}
			else
			{
				widget.frameOptimizedForSize = GtRectCenterRectInRect(CGRectMake(left + (i++ * columnWidth), top, columnWidth, height), widget.frame);
			}
		}
	}
}

@end