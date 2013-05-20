//
//  GtViewFader.m
//  FishLamp
//
//  Created by Mike Fullerton on 9/26/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtViewFader.h"
#import "GtMemoryMonitor.h"
#import "GtWindow.h"
#import "GtPair.h"

@implementation GtViewFader

GtSynthesizeDefault(GtViewFader, ViewFader);

- (id) init
{
	if(self = [super init])
	{
	}
	
	return self;
}

- (void) dealloc 
{
	[super dealloc];
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

- (void) insertSubview:(UIView*) view atIndex:(NSInteger)index superview:(UIView*) superview
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = GtFadeDuration;
	CALayer* layer = superview.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
	[superview insertSubview:view atIndex:index];
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
	UIWindow* newWindow = [GtAlloc(GtWindow) initWithFrame:CGRectMake(0,0,320,480)];	
	newWindow.autoresizingMask =	UIViewAutoresizingNone; 
	newWindow.backgroundColor = [UIColor blackColor];
	newWindow.alpha = 0;
	[newWindow addSubview:subview];
	[newWindow makeKeyAndVisible];
	
#if GT_MEMORY_MONITOR
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
	UIWindow* window  = (UIWindow*) context;
	[window resignKeyWindow];
	GtRelease(window);
	
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) releaseWindow:(UIWindow*) window
{
#if GT_MEMORY_MONITOR
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
    GtPair* pair = (GtPair*) context;
    
    UIView* view = pair.lhs;
    view.hidden = YES;
    view.alpha = [pair.rhs floatValue];
}

- (void) hideView:(UIView*) view
{
    [UIView beginAnimations:@"viewin" context:[GtPair pairWithValues:view rhs:[NSNumber numberWithFloat:view.alpha]]];
	[UIView setAnimationDuration:GtFadeDuration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:context:)];
	view.alpha = 0.0;
	[UIView commitAnimations];

}


@end
