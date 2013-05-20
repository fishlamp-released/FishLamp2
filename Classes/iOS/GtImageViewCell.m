//
//	GtImageViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtImageViewCell.h"


@implementation GtImageViewCell

- (id) initWithImage:(UIImage*) image
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"GtImageViewCell"]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.sectionWidget.drawMode = GtTableViewCellSectionDrawModeNone;
		
		m_imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
		m_imageView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:m_imageView];
		self.image = image;
	}
	return self;
}

#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

- (UIImage*) image
{
	return m_imageView.image;
}

- (void) setImage:(UIImage*) image
{
	m_imageView.image = image;
	[m_imageView resizeToImageSize];
	[self setNeedsLayout];
}

- (void) dealloc
{
	GtRelease(m_imageView);
	GtSuperDealloc();
}

- (void) setNeedsLayout
{
	[super setNeedsLayout];
	
	m_imageView.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_imageView.frame);
}

- (void) calculateCellHeightInTable:(UITableView*) tableView
{
   self.cellHeight = self.image.size.height; 
}


+ (GtImageViewCell*) imageViewCell:(UIImage*) image
{
	return GtReturnAutoreleased([[GtImageViewCell alloc] initWithImage:image]);
}

@end
