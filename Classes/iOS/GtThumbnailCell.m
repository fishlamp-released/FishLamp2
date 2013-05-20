//
//	ThumbnailCell.m
//	FishLamp
//
//	Created by Mike Fullerton on 7/10/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//


#import "GtThumbnailCell.h"
#import "GtGeometry.h"

@implementation GtThumbnailCell

@synthesize thumbnailView = m_imageView;

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
		m_imageView = [[UIImageView alloc] initWithFrame:[self thumbFrame]] ;
		m_imageView.contentMode = UIViewContentModeScaleAspectFit;
		m_imageView.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:m_imageView];
		
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		m_spinner.hidesWhenStopped = YES;
		m_spinner.frame = GtRectOptimizeForSize(GtRectCenterRectInRect(m_imageView.bounds, m_spinner.frame));
		[m_spinner startAnimating];
		[m_imageView addSubview:m_spinner];
		*/
		
	}
	return self;
}

- (void) dealloc
{
	GtReleaseWithNil(m_spinner);
	GtReleaseWithNil(m_imageView);
	GtSuperDealloc();
}

- (void) startSpinner
{
	[m_spinner startAnimating];
	[self bringSubviewToFront:m_spinner];
}

- (void) stopSpinner
{
	[m_spinner stopAnimating];
}

- (BOOL) spinnerIsAnimating
{
	return [m_spinner isAnimating];
}

- (void) clearThumbnail:(BOOL) startSpinner
{
	m_imageView.image = nil;
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
		m_imageView.image = image;
	}
}

- (void) setLoading:(BOOL) loading
{
/*
	if(loading && !m_disableSpinner && !m_imageView)
	{
		[self startSpinner];
	}
*/
}

- (CGFloat) rowHeight
{
	return ThumbnailHeight;
}
#pragma GCC diagnostic ignored "-Wdeprecated-implementations"

- (UIImage*) image
{
	return m_imageView.image;
}

@end

