//
//  FLUserHeaderView.m
//  FishLamp
//
//  Created by Mike Fullerton on 6/5/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLUserHeaderView.h"
#import "FLRoundRectView.h"

@implementation FLUserHeaderView

@synthesize thumbnailView = _thumbnail;
@synthesize nameLabel = _nameLabel;
@synthesize logoView = _logo;

- (void) applyTheme:(FLTheme*) theme
{
//	view.nameLabel.textDescriptor = self.titleDescriptor;
}

- (id) initWithFrame:(FLRect) frame
{
	if((self = [super initWithFrame:frame])) {
        self.wantsApplyTheme = YES;

		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin;
		self.backgroundColor = [UIColor clearColor];
	
		_thumbnail = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,50,50)];
		_thumbnail.contentMode = UIViewContentModeScaleAspectFit;
		_thumbnail.backgroundColor = [UIColor whiteColor];
		[self addSubview:_thumbnail];
		
		_thumbnail.layer.cornerRadius = FLRoundRectViewCornerRadiusDefault;
		_thumbnail.layer.borderWidth = 0.5;
		_thumbnail.layer.borderColor = [UIColor lightGrayColor].CGColor;
		_thumbnail.clipsToBounds = YES;
		
		_nameLabel = [[FLLabel alloc] initWithFrame:CGRectMake(60,0,100,20)];
		_nameLabel.backgroundColor = [UIColor clearColor];
		_nameLabel.font = [UIFont systemFontOfSize:[UIFont systemFontSize]];
		_nameLabel.textColor = [UIColor blackColor];
		[self addSubview:_nameLabel];
		
		_logo = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,24,24)];
		_logo.contentMode = UIViewContentModeScaleAspectFit;
		[self addSubview:_logo];

	}
	return self;
}

- (void) dealloc
{
	release_(_logo);
	release_(_spinner);
	release_(_thumbnail);
	release_(_nameLabel);
	super_dealloc_();
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	_thumbnail.frameOptimizedForSize = FLRectCenterRectInRectVertically(self.bounds, _thumbnail.frame);
	
	_nameLabel.frameOptimizedForSize = FLRectCenterRectInRectVertically(self.bounds,
		FLRectSetWidth(
			FLRectSetLeft(_nameLabel.frame, FLRectGetRight(_thumbnail.frame) + 10.0f), 
				self.bounds.size.width - _thumbnail.frame.size.width - 20.0));
	
	_logo.frameOptimizedForLocation = FLRectCenterRectInRectVertically(self.bounds, FLRectJustifyRectInRectRight(self.bounds, _logo.frame));
	
	if(_spinner)
	{
		_spinner.frameOptimizedForLocation = FLRectCenterRectInRect(_thumbnail.bounds, _spinner.frame);
	}	
}

- (NSString*) name
{
	return _nameLabel.text;
}	

- (void) setName:(NSString*) name
{
	_nameLabel.text = name;
	[self setNeedsLayout];
}

- (void) setThumbnail:(UIImage*) image
{
	_thumbnail.image = image;
	if(_thumbnail.image)
	{
		[_thumbnail resizeProportionally:FLSizeMake(50,50)];
		
//		_thumbnail.frame = CGRectInset(_thumbnail.frame, -1, -1);
		
	}
	[self setNeedsLayout];
}

- (UIImage*) thumbnail
{
	return _thumbnail.image;
}

- (void) startSpinner
{
	if(!_spinner)
	{
		_spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
		[_spinner startAnimating];
		[_thumbnail addSubview:_spinner];
		[self setNeedsLayout];
	}
}

- (void) stopSpinner
{
	if(_spinner)
	{
		[_spinner removeFromSuperview];
		FLReleaseWithNil_(_spinner);
	}
}

@end
