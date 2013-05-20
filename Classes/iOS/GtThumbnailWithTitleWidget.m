//
//  GtThumbnailWithTitleWidget.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/12/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailWithTitleWidget.h"

@implementation GtThumbnailWithTitleWidget

@synthesize imageFrameWidget = m_imageFrame;
@synthesize titleLabelWidget = m_label;

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		CGFloat thumbheight = MIN(80, frame.size.height - 20);
		
		m_imageFrame = [[GtImageFrameWidget alloc] initWithFrame:CGRectMake(0,0, thumbheight, thumbheight)];
		m_imageFrame.contentMode = GtWidgetContentModeScaleAspectFill;
		m_imageFrame.imageWidget = [GtImageWidget widget];
		m_imageFrame.imageWidget.highlighter = GtWidgetBlueTintImageHighlighter;
				
		m_imageFrame.showFrame = YES;
		m_imageFrame.showStack = YES;
		[self addSubwidget:m_imageFrame];
		
		m_label = [[GtLabelWidget alloc] initWithFrame:CGRectMake(0,0,frame.size.width, 18)];
		m_label.textAlignment = UITextAlignmentCenter;
		m_label.themeAction = @selector(applyThemeToTableViewCellTitleLabel:);
	//	m_label.viewLayoutMargins = UIEdgeInsetsMake((frame.size.height / 2.0f) - 10.0f, 10.0f, 0, 0);
		[self addSubwidget:m_label];
	}
	
	return self;
}

- (void) dealloc
{
	GtRelease(m_imageFrame);
	GtRelease(m_label);
	GtSuperDealloc();
}

- (void) setTitle:(NSString*) title
{
	m_label.text = title;
	[self setNeedsLayout];
}
- (void) setThumbnail:(UIImage*) image
{
	m_imageFrame.imageWidget.image = image;
}

- (void) layoutSubwidgets 
{
	[super layoutSubwidgets];
	
//	if(DeviceIsPad())
	{
		CGRect layoutFrame = DeviceIsPad() ? 
			CGRectInset(self.frame, 10, 10) :
			CGRectInset(self.frame, 0,0);
	
		m_imageFrame.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(layoutFrame, GtRectJustifyRectInRectTop(layoutFrame,m_imageFrame.frame));
		
		
		m_label.frameOptimizedForSize = GtRectCenterRectInRectHorizontally(layoutFrame, GtRectJustifyRectInRectBottom(layoutFrame, CGRectMake(0,0, self.frame.size.width, 18)));
	}
//	else
//	{
//
//	}
}

@end
