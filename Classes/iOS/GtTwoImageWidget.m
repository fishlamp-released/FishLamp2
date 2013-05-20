//
//	GtTwoImageWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/6/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtTwoImageWidget.h"

@implementation GtTwoImageWidget

@synthesize topImageWidget = m_topImageWidget;
@synthesize bottomImageWidget = m_bottomImageWidget;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_topImageWidget = [[GtImageWidget alloc] initWithFrame:frame];
		m_topImageWidget.layoutMode = GtRectLayoutCentered;
		m_topImageWidget.contentMode = GtWidgetContentModeScaleAspectFit;
		
		m_bottomImageWidget = [[GtImageWidget alloc] initWithFrame:frame];
		m_bottomImageWidget.layoutMode = GtRectLayoutCentered;
		m_bottomImageWidget.contentMode = GtWidgetContentModeScaleAspectFit;
		
		[self addSubwidget:m_bottomImageWidget];
		[self addSubwidget:m_topImageWidget];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_topImageWidget);
	GtRelease(m_bottomImageWidget);
	GtSuperDealloc();
}

- (void) releaseImages
{
	m_topImageWidget.image = nil;
	m_bottomImageWidget = nil;
}

@end
