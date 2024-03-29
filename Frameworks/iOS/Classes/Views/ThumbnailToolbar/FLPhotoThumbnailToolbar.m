//
//	FLThumbnailBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLPhotoThumbnailToolbar.h"

@implementation FLPhotoThumbnailToolbar 

@synthesize backButton = _backButton;
@synthesize nextButton = _nextButton;
@synthesize thumbnailBarView = _thumbnailBar;
@synthesize enabled = _enabled;

- (void) _initSubviews
{
	_enabled = YES;
	_thumbnailBar = [[FLImageThumbnailBarView alloc] initWithFrame:CGRectZero];
	_thumbnailBarItem = [[UIBarButtonItem alloc] initWithCustomView:_thumbnailBar];

    UIImage* rewind = [UIImage imageNamed:@"rewind.png"];
    FLAssertIsNotNil(rewind);

	_backButton =	[[UIBarButtonItem alloc] initWithImage:rewind 
		style:UIBarButtonItemStylePlain 
		target:_thumbnailBar 
		action:@selector(selectPrevThumbnail:)];

    UIImage* ff = [UIImage imageNamed:@"fast_forward.png"];
    FLAssertIsNotNil(ff);

	_nextButton =	[[UIBarButtonItem alloc] initWithImage:ff 
		style:UIBarButtonItemStylePlain 
		target:_thumbnailBar 
		action:@selector(selectNextThumbnail:)];
				
	self.items = [NSArray arrayWithObjects:
		_backButton,
		_thumbnailBarItem,
		_nextButton,
		nil];	 
}

- (id) initWithFrame:(CGRect) frame
{
	if((self = [super initWithFrame:frame]))
	{
		[self _initSubviews];
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super initWithCoder:aDecoder]))
	{
		[self _initSubviews];
	}
	return self;
}

- (void) setEnabled:(BOOL) enabled
{
	_nextButton.enabled = enabled;
	_backButton.enabled = enabled;
	_thumbnailBarItem.enabled = enabled;
	_thumbnailBar.enabled = enabled;
}

- (void) dealloc
{	
	FLRelease(_thumbnailBar);
	FLRelease(_backButton);
	FLRelease(_nextButton);
	FLRelease(_thumbnailBarItem);
	FLSuperDealloc();
}

#define ButtonSize 40

- (void) layoutSubviews
{
	NSArray* items = self.items;
	
	CGRect frame = FLRectInsetLeft(self.bounds, ButtonSize);
	frame = FLRectInsetRight(frame, ButtonSize + 10);
	frame = FLRectCenterRectInRect(self.bounds, frame);
	_thumbnailBarItem.width = frame.size.width;
	_thumbnailBar.frame = frame;
	[_thumbnailBar setNeedsLayout];
	self.items = items;
	
	[super layoutSubviews];
}

@end
