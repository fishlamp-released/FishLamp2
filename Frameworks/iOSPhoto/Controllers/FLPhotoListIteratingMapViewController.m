//
//	FLPhotoListIteratingMapViewController.m
//	FishLamp
//
//	Created by Mike Fullerton on 2/26/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLPhotoListIteratingMapViewController.h"

@implementation FLPhotoListIteratingMapViewController

@synthesize delegate = _delegate;

- (void) dealloc
{
	FLRelease(_prevButton);
	FLRelease(_nextButton);
	super_dealloc_();
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

	_prevButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
	[_prevButton setImage:[UIImage imageNamed:@"back.png"] forState:UIControlStateNormal];
	_prevButton.autoresizingMask = UIViewAutoresizingPositioned;
	_prevButton.frame = FLRectSetSize(_prevButton.frame, 80,80);
	_prevButton.frame = FLRectSetLeft(
				FLRectCenterRectInRectVertically(self.view.bounds, _prevButton.frame), 10.0f);
	[self.view addSubview:_prevButton];
	
	_nextButton = [UIButton buttonWithType:UIButtonTypeCustom] ;
	[_nextButton setImage:[UIImage imageNamed:@"forward.png"] forState:UIControlStateNormal];
	_nextButton.autoresizingMask = UIViewAutoresizingPositioned;
	_nextButton.frame = FLRectSetSize(_nextButton.frame, 80,80);
	_nextButton.frame = FLRectSetLeft(
				FLRectCenterRectInRectVertically(self.view.bounds, _nextButton.frame), 
				self.view.bounds.size.width - _nextButton.frame.size.width - 10.0f);
				
	[self.view addSubview:_nextButton];
}


@end

