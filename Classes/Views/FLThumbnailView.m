//
//	FLThumbnailView.m
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLThumbnailView.h"

@implementation FLThumbnailView

@synthesize backgroundImage = _backgroundImage;
@synthesize foregroundImage = _image;
@synthesize enabled = _enabled;

- (id)initWithFrame:(FLRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.userInteractionEnabled = NO;
		self.autoresizesSubviews = NO;
		self.autoresizingMask = UIViewAutoresizingNone; 
		self.backgroundColor = [UIColor whiteColor];
		self.alpha = 1.0;
		self.opaque = YES;
		self.contentMode = UIViewContentModeScaleAspectFill;
		self.clipsToBounds = YES;
		self.enabled = YES;
	}
	return self;
}

- (void) dealloc
{
	FLRelease(_disabledView);
	FLRelease(_image);
	FLRelease(_backgroundImage);
	FLSuperDealloc();
}

- (FLSize)sizeThatFits:(FLSize)size
{
	if(_image)
	{
		return _image.size;
	}
	else if(_backgroundImage)
	{
		return _backgroundImage.size;
	}
	
	return CGSizeZero;
}

- (void) updateImage
{
	if(_image)
	{
		[super setImage:_image];
	}
	else if(_backgroundImage)
	{
		[super setImage:_backgroundImage];
	}
	else
	{
		[super setImage:nil];
	}
}

- (void) setForegroundImage:(UIImage*) image
 {
	FLAssignObject(_image, image);
    [self updateImage];
}

- (void) setBackgroundImage:(UIImage *) image
{
	FLAssignObject(_backgroundImage, image);
    [self updateImage];
}

- (void) setImage:(UIImage*) image
{
	[self setForegroundImage:image];
}

- (void) clearImages
{
	self.foregroundImage = nil;
	self.backgroundImage = nil;
}

- (void) setEnabled:(BOOL) enabled
{
	if(_enabled != enabled)
	{
		_enabled = enabled;
	
		if(_enabled && _disabledView)
		{
			[_disabledView removeFromSuperview];
			FLReleaseWithNil(_disabledView);
		}
		else if(!_enabled && !_disabledView)
		{
			_disabledView = [[UIView alloc] initWithFrame:self.bounds];
			_disabledView.alpha = 0.8;
			_disabledView.backgroundColor = [UIColor grayColor];
			[self addSubview:_disabledView];
		}
	}
}

- (void) layoutSubviews
{
	[super layoutSubviews];
	
	if(_disabledView)
	{
		_disabledView.newFrame = self.bounds;
		[self bringSubviewToFront:_disabledView];
	}
}
@end

