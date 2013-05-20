//
//  GtTwoColumnWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwoColumnWidget.h"


@implementation GtTwoColumnWidget

@synthesize leftColumn = m_leftColumn;
@synthesize rightColumn = m_rightColumn;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
// init left column
		m_leftColumn = [[GtWidget alloc] initWithFrame:frame];
		[self addSubwidget:m_leftColumn];

		m_rightColumn = [[GtWidget alloc] initWithFrame:frame];
		[self addSubwidget:m_rightColumn];
	}
	
	return self;
}

- (void) layoutSubwidgets
{
    [super layoutSubwidgets];
    
    CGRect bounds = self.frame;
    bounds.size.width *= 0.5f;
    
    m_leftColumn.frameOptimizedForSize = bounds;
    bounds.origin.x += bounds.size.width;
	m_rightColumn.frameOptimizedForSize = bounds;
		
}

- (void) dealloc
{
	GtRelease(m_leftColumn);
	GtRelease(m_rightColumn);
	GtSuperDealloc();
}
@end
