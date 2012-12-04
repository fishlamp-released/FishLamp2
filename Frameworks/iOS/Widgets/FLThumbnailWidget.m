//
//	FLThumbnailWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLThumbnailWidget.h"
#import "FLImage+Resize.h"

@implementation FLThumbnailWidget

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.topImageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
		self.bottomImageWidget.imageContentMode = FLWidgetImageContentModeScaleAspectFill;
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

- (void) layoutWidgets
{
	self.topImageWidget.frame = self.frame;
	self.bottomImageWidget.frame = self.frame;
	self.topImageWidget.hidden = (self.topImageWidget.image == nil);
	self.bottomImageWidget.hidden = !self.topImageWidget.hidden;
	
	[super layoutWidgets];
}

- (void) dealloc
{
	release_(_highlightedView);
	super_dealloc_();
}

#define Scale 1.2

- (void) setHighlighted:(BOOL) highlighted
{
	[super setHighlighted:highlighted];

	if(self.isHighlighted)
	{
		if(!_highlightedView)
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
				FLRect frame = FLRectScale(self.frame, Scale);
				UIImage* image = self.topImageWidget.image ? self.topImageWidget.image : self.bottomImageWidget.image;
				
				FLSize imageSize = image.size;
				
				if(imageSize.height > imageSize.width)
				{
					imageSize = [image proportionalSizeWithMaxSize:FLSizeMake(self.frame.size.width, 1024.0)];
					
				}
				else
				{
					imageSize = [image proportionalSizeWithMaxSize:FLSizeMake(1024.0, self.frame.size.height)];
				
				}
				frame.size = imageSize;
				
				frame = FLRectCenterOnPoint(FLRectScale(frame, Scale), FLRectGetCenter(self.frame));
			
				frame = [tableView convertRect:frame fromView:self.view];
			
				_highlightedView = [[UIImageView alloc] initWithFrame:frame];
				_highlightedView.backgroundColor = [UIColor clearColor];
				_highlightedView.contentMode = UIViewContentModeScaleAspectFill;
				_highlightedView.image = self.topImageWidget.image ? self.topImageWidget.image : self.bottomImageWidget.image;
				_highlightedView.layer.shadowColor = [UIColor blackColor].CGColor;
				_highlightedView.layer.shadowOpacity = .8;
				_highlightedView.layer.shadowRadius = 20.0;
				_highlightedView.layer.shadowOffset = FLSizeMake(0,3);
				_highlightedView.layer.borderColor = [UIColor blackColor].CGColor;			 
				_highlightedView.layer.borderWidth = 1.0f;
				
				[tableView addSubview:_highlightedView];
			}
		//	  [_highlightedView doPopInAnimation:0.2f];
		}
	}
	else
	{
		[_highlightedView removeFromSuperview];
		FLReleaseWithNil_(_highlightedView);
	}
}


@end
