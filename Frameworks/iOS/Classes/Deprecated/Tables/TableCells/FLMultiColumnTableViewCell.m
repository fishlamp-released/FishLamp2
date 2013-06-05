//
//	FLMultiColumnBlockTableViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/5/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMultiColumnTableViewCell.h"

@implementation FLMultiColumnTableViewCell

- (FLMultiColumnWidget*) widget
{
	return (FLMultiColumnWidget*) [super widget];
}	

- (void) setWidget:(FLMultiColumnWidget*) widget
{
	[super setWidget:widget];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier]))
	{
		FLMultiColumnWidget* widget = [[FLMultiColumnWidget alloc] init];
		widget.style = FLMultiColumnWidgetStyleDynamic;
		widget.resizeColumnsToFit = YES;
		[super setWidget:widget];
		FLRelease(widget);
	}
	
	return self;
}

- (BOOL) tableViewDragSelectStartValueForPoint:(CGPoint) point
{
	point = [self convertPoint:point fromView:self.superview];

	FLMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{
		for(FLWidget* subwidget in widget.subWidgets)
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
	memset(_selectedStates, sizeof(BOOL) * 32, 0);

	FLMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{
		NSUInteger count = 0;
		for(FLWidget* subwidget in widget.subWidgets)
		{
			_selectedStates[count++] = subwidget.isSelected;
		}
	}
		
}

- (void) tableViewDragSelectRectChanged:(CGRect) rect startValue:(BOOL) startValue
{
	rect = [self convertRect:rect fromView:self.superview];

	FLMultiColumnWidget* widget = self.widget;
	if(!widget.isHidden)
	{	
		NSUInteger count = 0;
		for(FLWidget* subwidget in widget.subWidgets)
		{
			if(CGRectIntersectsRect(rect, subwidget.frame))
			{
				subwidget.selected = !startValue;
			}
			else
			{
				subwidget.selected = _selectedStates[count];
			}
			
			count++;
		}
	}
}

@end