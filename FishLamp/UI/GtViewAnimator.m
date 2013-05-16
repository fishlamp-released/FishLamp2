//
//  GtViewAnimator.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/12/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtViewAnimator.h"

@implementation GtDefaultViewAnimator

GtSynthesizeDefault(GtDefaultViewAnimator, ViewAnimator);

- (void) addSubview:(UIView*) view 
          superview:(UIView*) superview
{
    GtAssertNotNil(view);
    GtAssertNotNil(superview);
    
    [superview addSubview:view];
}

- (void) insertSubview:(UIView*) view atIndex:(NSInteger)index superview:(UIView*) superview
{
    [superview insertSubview:view atIndex:index];
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

@implementation GtViewAnimator 

#define POPINOUT_DURATION 0.3

@synthesize startPositionForShowAnimation = m_startPosition;

- (id) initWithStartPosition:(GtAnimationPosition) position
{
	if(self = [super init])
	{
        m_startPosition = position;
	}
	
	return self;
}

- (void) dealloc 
{
	[super dealloc];
}

- (void)doneRemovingView:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIView* view = (UIView*) context;

	[view removeFromSuperview]; 
    GtRelease(view);
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void)doneRemovingController:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIViewController* controller = (UIViewController*) context;
	
	[controller.view removeFromSuperview]; 
	GtRelease(controller);
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (CGPoint) moveViewOffscreen:(UIView*) view
	endPosition:(GtAnimationPosition) endPosition
{
    GtAssertNotNil(view);

	CGRect ourFrame = view.frame;
	CGPoint outPoint = ourFrame.origin;
	
	[UIView beginAnimations:@"viewin" context:view];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	switch(endPosition)
	{
		case GtAnimationPositionBottom:
			ourFrame.origin.x = 0;
			ourFrame.origin.y = view.superview.bounds.size.height;
			break;
		case GtAnimationPositionLeft:
			ourFrame.origin.x = - ourFrame.size.width;
			ourFrame.origin.y = 0;
			break;
	}

	view.frame = ourFrame;

	[UIView commitAnimations];
	
	return outPoint;
}

+ (CGPoint) destinationPointForOffscreenMove:(UIView*) view
		endPosition:(GtAnimationPosition) endPosition
{
    GtAssertNotNil(view);

	CGRect ourFrame = view.frame;
	
	switch(endPosition)
	{
		case GtAnimationPositionTop:
			ourFrame.origin.x = ourFrame.origin.x;
			ourFrame.origin.y = -ourFrame.size.height;
			break;
	
		case GtAnimationPositionBottom:
			ourFrame.origin.x = ourFrame.origin.x;
			ourFrame.origin.y = view.superview.bounds.size.height;
			break;
		
		case GtAnimationPositionLeft:
			ourFrame.origin.x = - ourFrame.size.width;
			ourFrame.origin.y = ourFrame.origin.y;
			break;
			
		case GtAnimationPositionRight:	
			ourFrame.origin.x = view.superview.bounds.size.width;
			ourFrame.origin.y = ourFrame.origin.y;
			break;
	}

	return ourFrame.origin;
}

+ (CGPoint) moveViewToPoint:(UIView*) view point:(CGPoint) point
{
    GtAssertNotNil(view);

	CGRect ourFrame = view.frame;
	CGPoint outPoint = ourFrame.origin;
	
	[UIView beginAnimations:@"viewin" context:view];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(doneAdding:finished:context:)];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	ourFrame.origin = point;
	view.frame = ourFrame;
	
	[UIView commitAnimations];
	
	return outPoint;
}

- (void) addSubview:(UIView*) view superview:(UIView*) superview 
{
    [self insertSubview:view atIndex:NSIntegerMax superview:superview];
}

- (void) showView:(UIView*) view
{
    GtAssertNotNil(view);
    
	CGRect superBounds = view.superview.bounds;
	CGRect endFrame = view.frame;
    CGRect startFrame = endFrame;

	switch(m_startPosition)
	{
		case GtAnimationPositionBottom:
			startFrame.origin.y = superBounds.size.height;
        //    destPoint = endFrame.origin;
        //    destPoint.y = superBounds.size.height- (endFrame.size.height + endFrame.origin.y);
			break;
		case GtAnimationPositionLeft:
			startFrame.origin.x = - startFrame.size.width;
			break;

		case GtAnimationPositionRight:
			startFrame.origin.x = superBounds.size.width;
			break;

		case GtAnimationPositionTop:
			startFrame.origin.y = - startFrame.size.height;
			break;

	}
	
	view.frame = startFrame;

    [UIView beginAnimations:@"viewin" context:view];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(doneAdding:finished:context:)];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	view.frame = endFrame;
	
	[UIView commitAnimations];
}

- (void) insertSubview:(UIView*) view atIndex:(NSInteger)index superview:(UIView*) superview
{

    GtAssertNotNil(view);
    GtAssertNotNil(superview);

	CGRect superBounds = superview.bounds;
	CGRect endFrame = view.frame;
    CGRect startFrame = endFrame;

	switch(m_startPosition)
	{
		case GtAnimationPositionBottom:
			startFrame.origin.y = superBounds.size.height;
        //    destPoint = endFrame.origin;
        //    destPoint.y = superBounds.size.height- (endFrame.size.height + endFrame.origin.y);
			break;
		case GtAnimationPositionLeft:
			startFrame.origin.x = - startFrame.size.width;
			break;

		case GtAnimationPositionRight:
			startFrame.origin.x = superBounds.size.width;
			break;

		case GtAnimationPositionTop:
			startFrame.origin.y = - startFrame.size.height;
			break;

	}
	
	view.frame = startFrame;
	
    if(index == NSIntegerMax)
    {
        [superview addSubview:view];
    }
    else
    {
        [superview insertSubview:view atIndex:index];
    }

	[UIView beginAnimations:@"viewin" context:view];
//	[UIView setAnimationDelegate:self];
//	[UIView setAnimationDidStopSelector:@selector(doneAdding:finished:context:)];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	view.frame = endFrame;
	
	[UIView commitAnimations];
}


- (GtAnimationPosition) endPosition
{
    switch(m_startPosition)
	{
		case GtAnimationPositionBottom:    return GtAnimationPositionTop;
        case GtAnimationPositionLeft:      return GtAnimationPositionRight;
        case GtAnimationPositionRight:     return GtAnimationPositionLeft;
		case GtAnimationPositionTop:       return GtAnimationPositionBottom;
	}
    
    GtFail(@"unknown position");
    
    return GtAnimationPositionTop;
}

- (void) hideView:(UIView*) view
{
    GtAssertNotNil(view);

	CGRect superBounds = view.superview.bounds;
	CGRect endFrame = view.frame;
	
    switch(m_startPosition)
	{
		case GtAnimationPositionBottom:
			endFrame.origin.y = superBounds.size.height;
			break;
		
        case GtAnimationPositionLeft:
			endFrame.origin.x = - endFrame.size.width;
			break;
        
        case GtAnimationPositionRight:
			endFrame.origin.x = superBounds.size.width;
			break;

		case GtAnimationPositionTop:
			endFrame.origin.y = - endFrame.size.height;
			break;
		
	}
    
	[UIView beginAnimations:@"viewin" context:nil];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    view.frame = endFrame;

	[UIView commitAnimations];

}

- (void) removeViewOrControllerFromSuperview:(UIView*) view 
	controller:(UIViewController*) controller
{
    GtAssert(view != nil || controller != nil, @"something is nil");

	if(!view)
	{
		view = controller.view;
	}

	GtAssertNotNil(view);

	CGRect superBounds = view.superview.bounds;
	CGRect endFrame = view.frame;
	
    switch(m_startPosition)
	{
		case GtAnimationPositionBottom:
			endFrame.origin.y = superBounds.size.height;
			break;
		
        case GtAnimationPositionLeft:
			endFrame.origin.x = - endFrame.size.width;
			break;
        
        case GtAnimationPositionRight:
			endFrame.origin.x = superBounds.size.width;
			break;

		case GtAnimationPositionTop:
			endFrame.origin.y = - endFrame.size.height;
			break;
		
	}
    
	[UIView beginAnimations:@"viewin" context:(controller ? (void*) [controller retain]: (void*) [view retain])];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:controller ? 
		@selector(doneRemovingController:finished:context:) :
		@selector(doneRemovingView:finished:context:)];
	[UIView setAnimationDuration:POPINOUT_DURATION];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

    view.frame = endFrame;

	[UIView commitAnimations];
}

- (void) removeControllerFromSuperview:(UIViewController*) controller 
{
    GtAssertNotNil(controller);

	[self removeViewOrControllerFromSuperview:nil controller:controller];
}
	
- (void) removeFromSuperview:(UIView*) view 
{
    GtAssertNotNil(view);

	[self removeViewOrControllerFromSuperview:view controller:nil];
}
	
@end

