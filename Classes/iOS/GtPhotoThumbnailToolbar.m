//
//	GtThumbnailBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoThumbnailToolbar.h"

@implementation GtPhotoThumbnailToolbar 

@synthesize previousButton = m_previousButton;
@synthesize nextButton = m_nextButton;
@synthesize thumbnailBarView = m_thumbnailBar;
@synthesize enabled = m_enabled;

- (void) _initSubviews
{
	m_enabled = YES;
	m_thumbnailBar = [[GtImageThumbnailBarView alloc] initWithFrame:CGRectZero];
	m_thumbnailBarItem = [[UIBarButtonItem alloc] initWithCustomView:m_thumbnailBar];

    UIImage* rewind = [UIImage imageNamed:@"rewind.png"];
    GtAssertNotNil(rewind);

	m_previousButton =	[[UIBarButtonItem alloc] initWithImage:rewind 
		style:UIBarButtonItemStylePlain 
		target:m_thumbnailBar 
		action:@selector(selectPrevThumbnail:)];

    UIImage* ff = [UIImage imageNamed:@"fast_forward.png"];
    GtAssertNotNil(ff);

	m_nextButton =	[[UIBarButtonItem alloc] initWithImage:ff 
		style:UIBarButtonItemStylePlain 
		target:m_thumbnailBar 
		action:@selector(selectNextThumbnail:)];
				
	self.items = [NSArray arrayWithObjects:
		m_previousButton,
		m_thumbnailBarItem,
		m_nextButton,
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
	m_nextButton.enabled = enabled;
	m_previousButton.enabled = enabled;
	m_thumbnailBarItem.enabled = enabled;
	m_thumbnailBar.enabled = enabled;
}

- (void) dealloc
{	
	GtRelease(m_thumbnailBar);
	GtRelease(m_previousButton);
	GtRelease(m_nextButton);
	GtRelease(m_thumbnailBarItem);
	GtSuperDealloc();
}

#define ButtonSize 40

- (void) layoutSubviews
{
	NSArray* items = self.items;
	
	CGRect frame = GtRectInsetLeft(self.bounds, ButtonSize);
	frame = GtRectInsetRight(frame, ButtonSize + 10);
	frame = GtRectCenterRectInRect(self.bounds, frame);
	m_thumbnailBarItem.width = frame.size.width;
	m_thumbnailBar.frame = frame;
	[m_thumbnailBar setNeedsLayout];
	self.items = items;
	
	[super layoutSubviews];
}

@end
