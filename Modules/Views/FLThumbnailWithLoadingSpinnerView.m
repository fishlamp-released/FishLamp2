//
//	FLThumbnailWithLoadingSpinnerView.m
//	FishLamp
//
//	Created by Mike Fullerton on 6/9/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLThumbnailWithLoadingSpinnerView.h"

@implementation FLThumbnailWithLoadingSpinnerView

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
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		_spinner.hidesWhenStopped = YES;
		_spinner.frameOptimizedForSize = FLRectCenterRectInRect(self.bounds, _spinner.frame);
		[_spinner startAnimating];
		[self addSubview:_spinner];
	}

	[_spinner startAnimating];
}

- (void) stopSpinner
{
	if(_spinner)
	{
		[_spinner removeFromSuperview];
		FLReleaseWithNil(_spinner);
	}
}

- (BOOL) spinnerIsAnimating
{
	return _spinner && [_spinner isAnimating];
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
