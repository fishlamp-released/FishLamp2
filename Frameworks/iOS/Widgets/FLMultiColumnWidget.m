//
//	FLMultiColumnWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/8/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLMultiColumnWidget.h"

@implementation FLMultiColumnWidget

@synthesize visibleColumnCount = _visibleColumnCount;
@synthesize style = _style;
@synthesize columnWidth = _columnWidth;
@synthesize resizeColumnsToFit = _resizeColumns;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.style = FLMultiColumnWidgetStyleDynamic;
	}
	
	return self;
}

- (void) setVisibleColumnCount:(NSUInteger) columnCount
{
	_visibleColumnCount = columnCount;
	
	NSUInteger i = 0;
	for(FLWidget* widget in self.subWidgets)
	{
		widget.hidden = (i++ >= _visibleColumnCount);
	}
}

- (void) addWidget:(FLWidget *)widget
{	
	[super addWidget:widget];
	++_visibleColumnCount;
}

- (void) willRemoveSubWidget:(FLWidget*) widget
{
    [super willRemoveSubWidget:widget];
	
	if(!widget.hidden)
	{
		--_visibleColumnCount;
	}
}

- (void) layoutSubWidgets
{
	CGFloat columnWidth = self.style == FLMultiColumnWidgetStyleDynamic ? 
		(self.frame.size.width / (CGFloat) _visibleColumnCount) :
		_columnWidth;
		
	CGFloat height = self.frame.size.height;

	NSUInteger i = 0;
	CGFloat left = self.style == FLMultiColumnWidgetStyleRightJustified ? 
		FLRectGetRight(self.frame) - (_columnWidth * _visibleColumnCount) : 
		self.frame.origin.x;
	CGFloat top = self.frame.origin.y;
	
	for(FLWidget* widget in self.subWidgets)
	{
		if(!widget.isHidden)
		{
			if(_resizeColumns)
			{
				widget.frameOptimizedForSize = CGRectMake(left + (i++ * columnWidth), top, columnWidth, height);
				[widget setNeedsLayout];
			}
			else
			{
				widget.frameOptimizedForSize = FLRectCenterRectInRect(CGRectMake(left + (i++ * columnWidth), top, columnWidth, height), widget.frame);
			}
		}
	}
}

@end