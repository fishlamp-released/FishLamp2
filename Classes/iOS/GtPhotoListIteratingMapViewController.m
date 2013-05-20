//
//	GtPhotoListIteratingMapViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtPhotoListIteratingMapViewController.h"

@implementation GtPhotoListIteratingMapViewController

@synthesize delegate = m_delegate;

- (void) dealloc
{
	GtRelease(m_prevButton);
	GtRelease(m_nextButton);
	GtSuperDealloc();
}

- (void) _next:(id) sender
{
	[self.delegate photoListIteratingMapViewControllerShowNextPhoto:self];
	[self removeAllPins];
}

- (void) _prev:(id) sender
{
	[self.delegate photoListIteratingMapViewControllerShowPreviousPhoto:self];
	[self removeAllPins];
}

- (void) viewDidLoad
{
	[super viewDidLoad];

	m_prevButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	[m_prevButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
	m_prevButton.autoresizingMask = UIViewAutoresizingPositioned;
	m_prevButton.frame = GtRectSetSize(m_prevButton.frame, 80,80);
	m_prevButton.frame = GtRectSetLeft(
				GtRectCenterRectInRectVertically(self.view.bounds, m_prevButton.frame), 10.0f);
	[self.view addSubview:m_prevButton];
	
	m_nextButton = [[UIButton buttonWithType:UIButtonTypeCustom] retain];
	[m_nextButton setImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
	m_nextButton.autoresizingMask = UIViewAutoresizingPositioned;
	m_nextButton.frame = GtRectSetSize(m_nextButton.frame, 80,80);
	m_nextButton.frame = GtRectSetLeft(
				GtRectCenterRectInRectVertically(self.view.bounds, m_nextButton.frame), 
				self.view.bounds.size.width - m_nextButton.frame.size.width - 10.0f);
				
	[self.view addSubview:m_nextButton];
}


@end

