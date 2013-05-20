//
//	GtThumbnailWithLoadingSpinnerView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/9/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailWithLoadingSpinnerView.h"

@implementation GtThumbnailWithLoadingSpinnerView

- (id) initWithFrame:(CGRect) rect
{
	if((self = [super initWithFrame:rect]))
	{
		self.contentMode = UIViewContentModeScaleAspectFit;
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = NO;
	}
	
	return self;
}

- (void) startSpinner
{
	if(!m_spinner)
	{
		m_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		m_spinner.hidesWhenStopped = YES;
		m_spinner.frameOptimizedForSize = GtRectCenterRectInRect(self.bounds, m_spinner.frame);
		[m_spinner startAnimating];
		[self addSubview:m_spinner];
	}

	[m_spinner startAnimating];
}

- (void) stopSpinner
{
	if(m_spinner)
	{
		[m_spinner removeFromSuperview];
		GtReleaseWithNil(m_spinner);
	}
}

- (BOOL) spinnerIsAnimating
{
	return m_spinner && [m_spinner isAnimating];
}

- (void) clearThumbnail:(BOOL) startSpinner
{
	self.image = nil;
	if(startSpinner)
	{
		[self startSpinner];
	}
}

- (void) setImage:(UIImage*) image
{
	if(image)
	{
		[self stopSpinner];
	}
	
	super.image = image;
}


@end
