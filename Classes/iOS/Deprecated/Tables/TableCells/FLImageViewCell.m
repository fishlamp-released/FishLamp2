//
//	FLImageViewCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/11/11.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLImageViewCell.h"


@implementation FLImageViewCell

- (id) initWithImage:(UIImage*) image
{
	if((self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FLImageViewCell"]))
	{
		self.backgroundColor = [UIColor clearColor];
		self.sectionWidget.drawMode = FLTableViewCellSectionDrawModeNone;
		
		_imageCellView = [[UIImageView alloc] initWithFrame:CGRectZero];
		_imageCellView.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_imageCellView];
		self.image = image;
	}
	return self;
}

- (UIImage*) image
{
	return _imageCellView.image;
}

- (void) setImage:(UIImage*) image
{
	_imageCellView.image = image;
	[_imageCellView resizeToImageSize];
	[self setNeedsLayout];
}

- (void) dealloc
{
	FLRelease(_imageCellView);
	FLSuperDealloc();
}

- (void) setNeedsLayout
{
	[super setNeedsLayout];
	
	_imageCellView.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _imageCellView.frame);
}

- (void) calculateCellHeightInTable:(UITableView*) tableView
{
   self.cellHeight = self.image.size.height; 
}


+ (FLImageViewCell*) imageViewCell:(UIImage*) image
{
	return FLAutorelease([[FLImageViewCell alloc] initWithImage:image]);
}

@end
