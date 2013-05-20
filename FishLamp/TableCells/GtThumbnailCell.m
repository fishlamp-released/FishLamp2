//
//  ThumbnailCell.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/10/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

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
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) 
	{
		self.backgroundColor = [UIColor whiteColor];
		self.selectionStyle = UITableViewCellSelectionStyleNone;
	//	self.frame = [self thumbFrame];
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;	
		
		m_imageView = [GtAlloc(UIImageView) initWithFrame:[self thumbFrame]] ;
		m_imageView.contentMode = UIViewContentModeScaleAspectFit;
		m_imageView.backgroundColor = [UIColor clearColor];
		[self.contentView addSubview:m_imageView];
		
		m_spinner = [GtAlloc(UIActivityIndicatorView) initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		m_spinner.hidesWhenStopped = YES;
		m_spinner.frame = GtCenterRectInRect([self thumbFrame], m_spinner.frame);
		[m_spinner startAnimating];
		[m_imageView addSubview:m_spinner];
	}
    return self;
}

#if FISHLAMP_IPHONE_2_SDK
- (id)initWithFrame:(CGRect)frame reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithFrame:frame reuseIdentifier:reuseIdentifier]) 
	{
		// calls initWithStyle
	}
    return self;
}
#endif

- (void) dealloc
{
	GtRelease(m_spinner);
	GtRelease(m_imageView);
	[super dealloc];
}

- (void) startSpinner
{
	[m_spinner startAnimating];
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

@end

#endif