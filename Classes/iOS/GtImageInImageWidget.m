//
//	GtImageInImageWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/9/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageInImageWidget.h"


@implementation GtImageInImageWidget

@synthesize topImageWidget = m_topImageWidget;
@synthesize topImageScale = m_topImageScale;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		m_topImageScale = 1.0;
	}
	return self;
}

+ (GtImageInImageWidget*) imageInImageWidget:(CGRect) frame
{
	return GtReturnAutoreleased([[GtImageInImageWidget alloc] initWithFrame:frame]);
}

- (void) setTopImageWidget:(GtImageWidget*) widget
{
	if(m_topImageWidget)
	{
		[m_topImageWidget removeFromParent];
	}
	GtAssignObject(m_topImageWidget, widget);
	[self addSubwidget:widget];
	[self setNeedsLayout];
}

- (void) dealloc
{
	GtRelease(m_topImageWidget);
	GtSuperDealloc();
}

- (void) clear
{
	[super clear];
	[m_topImageWidget clear];
}

- (void) layoutSubwidgets
{
	[super layoutSubwidgets];
//	  switch(self.contentMode)
//	  {
//		  case GtWidgetContentModeScaleToFill:
//		  case GtWidgetContentModeScaleAspectFit:
//			  m_topImageWidget.frameOptimizedForSize = GtRectCenterRectInRect(self.frame, [m_topImageWidget resizeToImageSizeWithMaxSize:self.frame.size]);
//		  break;
//		  case GtWidgetContentModeScaleAspectFill:
//		  break;
//		  case GtWidgetContentModeScaleAspectFitOptimalSize:
//			  [m_topImageWidget resizeToImageSize];
//		  break;
//	  }
	
	if(m_topImageWidget.image)
	{
		[m_topImageWidget resizeToImageSize];
		m_topImageWidget.frame = 
			GtRectLayoutRectInRect(m_topImageWidget.layoutMode, self.frame, GtRectScale(m_topImageWidget.frame, m_topImageScale));
	}
}

@end
