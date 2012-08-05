//
//	FLThumbnailBar.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import "FLPhotoThumbnailToolbar.h"

@implementation FLPhotoThumbnailToolbar 

@synthesize previousButton = m_previousButton;
@synthesize nextButton = m_nextButton;
@synthesize thumbnailBarView = m_thumbnailBar;
@synthesize enabled = m_enabled;

- (void) _initSubviews
{
	m_enabled = YES;
	m_thumbnailBar = [[FLImageThumbnailBarView alloc] initWithFrame:CGRectZero];
	m_thumbnailBarItem = [[UIBarButtonItem alloc] initWithCustomView:m_thumbnailBar];

    UIImage* rewind = [UIImage imageNamed:@"rewind.png"];
    FLAssertIsNotNil(rewind);

	m_previousButton =	[[UIBarButtonItem alloc] initWithImage:rewind 
		style:UIBarButtonItemStylePlain 
		target:m_thumbnailBar 
		action:@selector(selectPrevThumbnail:)];

    UIImage* ff = [UIImage imageNamed:@"fast_forward.png"];
    FLAssertIsNotNil(ff);

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
	FLRelease(m_thumbnailBar);
	FLRelease(m_previousButton);
	FLRelease(m_nextButton);
	FLRelease(m_thumbnailBarItem);
	FLSuperDealloc();
}

#define ButtonSize 40

- (void) layoutSubviews
{
	NSArray* items = self.items;
	
	CGRect frame = FLRectInsetLeft(self.bounds, ButtonSize);
	frame = FLRectInsetRight(frame, ButtonSize + 10);
	frame = FLRectCenterRectInRect(self.bounds, frame);
	m_thumbnailBarItem.width = frame.size.width;
	m_thumbnailBar.frame = frame;
	[m_thumbnailBar setNeedsLayout];
	self.items = items;
	
	[super layoutSubviews];
}

@end
