//
//	GtViewFader.m
//	FishLamp
//
//	Created by Mike Fullerton on 9/26/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtViewFader.h"
#import "GtMemoryMonitor.h"
#import "GtKeyValuePair.h"

@implementation GtViewFader

GtSynthesizeDefault(GtViewFader, ViewFader);

- (id) init
{
	if((self = [super init]))
	{
	}
	
	return self;
}

- (void) dealloc 
{
	GtSuperDealloc();
}

- (void) addSubview:(UIView*) view superview:(UIView*) superview
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[superview addSubview:view];
	[layer removeAnimationForKey:@"myAnim"];
}

- (void) insertSubview:(UIView*) view atIndex:(NSInteger)idx superview:(UIView*) superview
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[superview insertSubview:view atIndex:idx];
	[layer removeAnimationForKey:@"myAnim"];
}

- (void) insertSubview:(UIView*) view belowSubview:(UIView*) subView superview:(UIView*) superview
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[superview insertSubview:view belowSubview:subView];
	[layer removeAnimationForKey:@"myAnim"];
}

- (void) insertSubview:(UIView*) view aboveSubview:(UIView*) subView superview:(UIView*) superview
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[superview insertSubview:view aboveSubview:subView];
	[layer removeAnimationForKey:@"myAnim"];
}

- (void) removeFromSuperview:(UIView*) view
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = view.superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[view removeFromSuperview];
	[layer removeAnimationForKey:@"myAnim"];
}

- (void) createWindowWithSubview:(UIView*) subview outWindow:(UIWindow**) outWindow
{
	UIWindow* newWindow = [[UIWindow alloc] initWithFrame:CGRectMake(0,0,320,480)]; 
	newWindow.autoresizingMask =	UIViewAutoresizingNone; 
	newWindow.backgroundColor = [UIColor blackColor];
	newWindow.alpha = 0;
	[newWindow addSubview:subview];
	[newWindow makeKeyAndVisible];
	
#if __GT_MEMORY_MONITOR
	[[GtMemoryMonitor instance] start:newWindow];
#endif

	[UIView beginAnimations:@"viewin" context:nil];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	newWindow.alpha = 1.0;
	[UIView commitAnimations];
	
	*outWindow = newWindow;
}

- (void)doneFadingOutWindow:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	UIWindow* window = (UIWindow*) context;
	[window resignKeyWindow];
	GtReleaseWithNil(window);
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) releaseWindow:(UIWindow*) window
{
#if __GT_MEMORY_MONITOR
	[[GtMemoryMonitor instance] stop:window];
#endif
	[UIView beginAnimations:@"viewin" context:window];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneFadingOutWindow:finished:context:)];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	window.alpha = 0.0;
	[UIView commitAnimations];
}

- (void) showView:(UIView*) view
{
	CGFloat maxAlpha = view.alpha;
	view.hidden = NO;
	view.alpha = 0.0;
	[UIView beginAnimations:@"viewin" context:nil];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	view.alpha = maxAlpha;
	[UIView commitAnimations];
}

- (void) animationDidStop:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	GtKeyValuePair* pair = (GtKeyValuePair*) context;
	
	UIView* view = pair.key;
	view.hidden = YES;
	view.alpha = [pair.value floatValue];
}

- (void) hideView:(UIView*) view
{
	[UIView beginAnimations:@"viewin" context:[GtKeyValuePair keyValuePair:view value:[NSNumber numberWithFloat:view.alpha]]];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	view.alpha = 0.0;
	[UIView commitAnimations];

}


@end

@implementation GtNewViewFader 

- (void) dealloc
{
	GtRelease(m_view);
	GtSuperDealloc();
}

- (void) doneAdding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	GtAutorelease(self);
}

- (void) doneRemoving:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[m_view removeFromSuperview];
	GtAutorelease(self);
}

- (void) addSubview:(UIView*) view 
		  superview:(UIView*) superview
{
	GtRetain(self);
	GtAssignObject(m_view, view);
	
	m_view.alpha = 0.0;
	[superview addSubview:m_view];

	[UIView beginAnimations:@"viewin" context:nil];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneAdding:finished:context:)];
	m_view.alpha = 1.0;
	[UIView commitAnimations];
}
		
		  
- (void) removeFromSuperview:(UIView*) view
{
	GtRetain(self);
	
	GtAssignObject(m_view, view);

	[UIView beginAnimations:@"viewin" context:nil];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneRemoving:finished:context:)];
	m_view.alpha = 0.0;
	[UIView commitAnimations];

}


@end

