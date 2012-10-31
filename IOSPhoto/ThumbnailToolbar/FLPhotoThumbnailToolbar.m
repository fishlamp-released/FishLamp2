//
//	FLThumbnailBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLPhotoThumbnailToolbar.h"

@implementation FLPhotoThumbnailToolbar 

@synthesize previousButton = _previousButton;
@synthesize nextButton = _nextButton;
@synthesize thumbnailBarView = _thumbnailBar;
@synthesize enabled = _enabled;

- (void) _initSubviews
{
	_enabled = YES;
	_thumbnailBar = [[FLImageThumbnailBarView alloc] initWithFrame:CGRectZero];
	_thumbnailBarItem = [[UIBarButtonItem alloc] initWithCustomView:_thumbnailBar];

    UIImage* rewind = [UIImage imageNamed:@"rewind.png"];
    FLAssertIsNotNil_(rewind);

	_previousButton =	[[UIBarButtonItem alloc] initWithImage:rewind 
		style:UIBarButtonItemStylePlain 
		target:_thumbnailBar 
		action:@selector(selectPrevThumbnail:)];

    UIImage* ff = [UIImage imageNamed:@"fast_forward.png"];
    FLAssertIsNotNil_(ff);

	_nextButton =	[[UIBarButtonItem alloc] initWithImage:ff 
		style:UIBarButtonItemStylePlain 
		target:_thumbnailBar 
		action:@selector(selectNextThumbnail:)];
				
	self.items = [NSArray arrayWithObjects:
		_previousButton,
		_thumbnailBarItem,
		_nextButton,
		nil];	 
}

- (id) initWithFrame:(FLRect) frame
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
	_previousButton.enabled = enabled;
	_thumbnailBarItem.enabled = enabled;
	_thumbnailBar.enabled = enabled;
}

- (void) dealloc
{	
	mrc_release_(_thumbnailBar);
	mrc_release_(_previousButton);
	mrc_release_(_nextButton);
	mrc_release_(_thumbnailBarItem);
	mrc_super_dealloc_();
}

#define ButtonSize 40

- (void) layoutSubviews
{
	NSArray* items = self.items;
	
	FLRect frame = FLRectInsetLeft(self.bounds, ButtonSize);
	frame = FLRectInsetRight(frame, ButtonSize + 10);
	frame = FLRectCenterRectInRect(self.bounds, frame);
	_thumbnailBarItem.width = frame.size.width;
	_thumbnailBar.frame = frame;
	[_thumbnailBar setNeedsLayout];
	self.items = items;
	
	[super layoutSubviews];
}

@end
