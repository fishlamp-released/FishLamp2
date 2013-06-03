//
//	FLThumbnailWidget.m
//	FishLamp
//
//	Created by Mike Fullerton on 3/7/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLThumbnailWidget.h"
#import "UIImage+Resize.h"

@implementation FLThumbnailWidget

- (id) initWithFrame:(CGRect) frame
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

- (void) layoutSubWidgets
{
	self.topImageWidget.frame = self.frame;
	self.bottomImageWidget.frame = self.frame;
	self.topImageWidget.hidden = (self.topImageWidget.image == nil);
	self.bottomImageWidget.hidden = !self.topImageWidget.hidden;
	
	[super layoutSubWidgets];
}

- (void) dealloc
{
	FLRelease(_highlightedView);
	FLSuperDealloc();
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
				CGRect frame = FLRectScale(self.frame, Scale);
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
				
				frame = FLRectCenterOnPoint(FLRectScale(frame, Scale), FLRectGetCenter(self.frame));
			
				frame = [tableView convertRect:frame fromView:self.view];
			
				_highlightedView = [[UIImageView alloc] initWithFrame:frame];
				_highlightedView.backgroundColor = [UIColor clearColor];
				_highlightedView.contentMode = UIViewContentModeScaleAspectFill;
				_highlightedView.image = self.topImageWidget.image ? self.topImageWidget.image : self.bottomImageWidget.image;
				_highlightedView.layer.shadowColor = [UIColor blackColor].CGColor;
				_highlightedView.layer.shadowOpacity = .8;
				_highlightedView.layer.shadowRadius = 20.0;
				_highlightedView.layer.shadowOffset = CGSizeMake(0,3);
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
		FLReleaseWithNil(_highlightedView);
	}
}


@end
