//
//	GtThumbnailWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailWidget.h"
#import "UIImage+Resize.h"

@implementation GtThumbnailWidget

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.topImageWidget.contentMode = GtWidgetContentModeScaleAspectFill;
		self.bottomImageWidget.contentMode = GtWidgetContentModeScaleAspectFill;
	}
	return self;
}

- (void) setForegroundThumbnail:(UIImage*) thumbnail
{
	self.topImageWidget.image = thumbnail;
	[self setNeedsLayout];
}

- (UIImage*) foregroundThumbnail
{
	return self.topImageWidget.image;
}

- (UIImage*) backgroundThumbnail
{
	return self.bottomImageWidget.image;
}

- (void) setBackgroundThumbnail:(UIImage*) thumbnail
{
	self.bottomImageWidget.image = thumbnail;
	[self setNeedsDisplay];
}

- (void) layoutSubwidgets
{
	self.topImageWidget.frame = self.frame;
	self.bottomImageWidget.frame = self.frame;
	self.topImageWidget.hidden = (self.topImageWidget.image == nil);
	self.bottomImageWidget.hidden = !self.topImageWidget.hidden;
	
	[super layoutSubwidgets];
}

- (void) dealloc
{
	GtRelease(m_highlightedView);
	GtSuperDealloc();
}

#define Scale 1.2

- (void) setHighlighted:(BOOL) highlighted
{
	[super setHighlighted:highlighted];

	if(self.isHighlighted && self.isUserInteractionEnabled)
	{
		if(!m_highlightedView)
		{
			UITableView* tableView = nil;
			UIView* view = self.view;
			while(view != nil)
			{
				if([view isKindOfClass:[UITableView class]])
				{
					tableView = (UITableView*) view;
					break;
				}
				
				view = view.superview;
			}
			
			if(tableView)
			{
				CGRect frame = GtRectScale(self.frame, Scale);
				UIImage* image = self.topImageWidget.image ? self.topImageWidget.image : self.bottomImageWidget.image;
				
				CGSize imageSize = image.size;
				
				if(imageSize.height > imageSize.width)
				{
					imageSize = [image proportionalSizeWithMaxSize:CGSizeMake(self.frame.size.width, 1024.0)];
					
				}
				else
				{
					imageSize = [image proportionalSizeWithMaxSize:CGSizeMake(1024.0, self.frame.size.height)];
				
				}
				frame.size = imageSize;
				
				frame = GtRectCenterOnPoint(GtRectScale(frame, Scale), GtRectGetCenter(self.frame));
			
				frame = [tableView convertRect:frame fromView:self.view];
			
				m_highlightedView = [[UIImageView alloc] initWithFrame:frame];
				m_highlightedView.backgroundColor = [UIColor clearColor];
				m_highlightedView.contentMode = UIViewContentModeScaleAspectFill;
				m_highlightedView.image = self.topImageWidget.image ? self.topImageWidget.image : self.bottomImageWidget.image;
				m_highlightedView.layer.shadowColor = [UIColor blackColor].CGColor;
				m_highlightedView.layer.shadowOpacity = .8;
				m_highlightedView.layer.shadowRadius = 20.0;
				m_highlightedView.layer.shadowOffset = CGSizeMake(0,3);
				m_highlightedView.layer.borderColor = [UIColor blackColor].CGColor;			 
				m_highlightedView.layer.borderWidth = 1.0f;
				
				[tableView addSubview:m_highlightedView];
			}
		//	  [m_highlightedView doPopInAnimation:0.2f];
		}
	}
	else
	{
		[m_highlightedView removeFromSuperview];
		GtReleaseWithNil(m_highlightedView);
	}
}


@end
