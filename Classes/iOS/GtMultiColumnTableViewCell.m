//
//	GtMultiColumnBlockTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiColumnTableViewCell.h"

@implementation GtMultiColumnTableViewCell

- (GtMultiColumnWidget*) widget
{
	return (GtMultiColumnWidget*) [super widget];
}	

- (void) setWidget:(GtMultiColumnWidget*) widget
{
	[super setWidget:widget];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
		GtMultiColumnWidget* widget = [[GtMultiColumnWidget alloc] init];
		widget.style = GtMultiColumnWidgetStyleDynamic;
		widget.resizeColumnsToFit = YES;
		[super setWidget:widget];
		GtRelease(widget);
	}
	
	return self;
}

- (BOOL) tableViewDragSelectStartValueForPoint:(CGPoint) point
{
	point = [self convertPoint:point fromView:self.superview];

	GtMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{
		for(GtWidget* subwidget in widget.subwidgets)
		{
			if(!subwidget.isHidden && CGRectContainsPoint(subwidget.frame, point))
			{
				return subwidget.isSelected;
			}
		}
	}
	
	return NO;
}

- (void) tableViewDragSelectSaveSelectedState
{
	memset(m_selectedStates, sizeof(BOOL) * 32, 0);

	GtMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{
		NSUInteger count = 0;
		for(GtWidget* subwidget in widget.subwidgets)
		{
			m_selectedStates[count++] = subwidget.isSelected;
		}
	}
		
}

- (void) tableViewDragSelectRectChanged:(CGRect) rect startValue:(BOOL) startValue
{
	rect = [self convertRect:rect fromView:self.superview];

	GtMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{	
		NSUInteger count = 0;
		for(GtWidget* subwidget in widget.subwidgets)
		{
			if(CGRectIntersectsRect(rect, subwidget.frame))
			{
				subwidget.selected = !startValue;
			}
			else
			{
				subwidget.selected = m_selectedStates[count];
			}
			
			count++;
		}
	}
}

@end