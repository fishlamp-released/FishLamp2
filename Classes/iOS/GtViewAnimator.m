//
//	GtViewAnimator.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewAnimator.h"

@implementation GtViewAnimator

GtSynthesizeDefault(GtViewAnimator, ViewAnimator);

- (void) addSubview:(UIView*) view 
		  superview:(UIView*) superview
{
	GtAssertNotNil(view);
	GtAssertNotNil(superview);
	
	[superview addSubview:view];
}

- (void) insertSubview:(UIView*) view atIndex:(NSInteger)idx superview:(UIView*) superview
{
	[superview insertSubview:view atIndex:idx];
}


- (void) removeFromSuperview:(UIView*) view
{
	GtAssertNotNil(view);
	
	[view removeFromSuperview];
}

- (void) hideView:(UIView*) view
{
	view.hidden = YES;
}

- (void) showView:(UIView*) view
{
	view.hidden = NO;
}

@end

