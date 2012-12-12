//
//	ThumbnailCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/10/09.
//	Copyright 2009 Greentongue Software. All rights reserved.
//


#import "FLThumbnailCell.h"
#import "FLGeometry.h"

@implementation FLThumbnailCell

@synthesize thumbnailView = _thumbnailImageView;

- (CGRect) thumbFrame
{
	return CGRectMake(0,0,ThumbnailHeight,ThumbnailHeight);
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier		
{
	if ((self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])) 
	{
	//	self.backgroundColor = [UIColor whiteColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	//	self.frame = [self thumbFrame];
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;	
		
		/*
		_thumbnailImageView = [[UIImageView alloc] initWithFrame:[self thumbFrame]] ;
		_thumbnailImageView.contentMode = UIViewContentModeScaleAspectFit;
		_thumbnailImageView.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:_thumbnailImageView];
		
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_spinner.hidesWhenStopped = YES;
		_spinner.frame = FLRectOptimizeForSize(FLRectCenterRectInRect(_thumbnailImageView.bounds, _spinner.frame));
		[_spinner startAnimating];
		[_thumbnailImageView addSubview:_spinner];
		*/
		
	}
	return self;
}

- (void) dealloc
{
	FLReleaseWithNil(_spinner);
	FLReleaseWithNil(_thumbnailImageView);
	super_dealloc_();
}

- (void) startSpinner
{
	[_spinner startAnimating];
	[self bringSubviewToFront:_spinner];
}

- (void) stopSpinner
{
	[_spinner stopAnimating];
}

- (BOOL) spinnerIsAnimating
{
	return [_spinner isAnimating];
}

- (void) clearThumbnail:(BOOL) startSpinner
{
	_thumbnailImageView.image = nil;
	if(startSpinner)
	{
		[self startSpinner];
	}
}

- (void) setThumbnail:(UIImage*) image
{
	if(!image)
	{
		[self clearThumbnail:YES];
	}
	else
	{
		[self stopSpinner];
		_thumbnailImageView.image = image;
	}
}

- (void) setLoading:(BOOL) loading
{
/*
	if(loading && !_disableSpinner && !_thumbnailImageView)
	{
		[self startSpinner];
	}
*/
}

- (CGFloat) rowHeight
{
	return ThumbnailHeight;
}

- (UIImage*) image
{
	return _thumbnailImageView.image;
}

@end

