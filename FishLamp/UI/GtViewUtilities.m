//
//  GtViewUtilities.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/11/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#if IPHONE

#import "GtViewUtilities.h"
#import "GtPair.h"
#import "GtGeometry.h"

/*
+ (void) slideUpDownView:(UIView*) hostingView
	parent:(UIViewController*) parent
	child:(UIViewController*) child
	show:(BOOL) show;

+ (void) flipInOutView:(UIView*) hostingView
	parent:(UIViewController*) parent
	child:(UIViewController*) child
	show:(BOOL) show;


#define DURATION 0.3

#define gtSlideInTransition (gtSlideInFromBottom | gtSlideInFromLeft | gtSlideInFromRight | gtSlideInFromTop)
#define gtTransitionType (gtFade | gtMove | gtPush | gtReveal)
*/

@implementation GtViewUtilities

/*
GtSynthesizeSingleton(GtViewUtilities);

- (void) dealloc
{
	[m_stack release];
	[super dealloc];
}
*/
/*
- (void) slideInOutView:(UIView*) hostingView
	showType: (GtTransitionType) showType
	child:(UIViewController*) child
	show:(BOOL) show
{
	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	
	switch(GtBitMaskValue(showType, gtTransitionType))
	{
		case gtFade:
			anim.type = kCATransitionFade; 
		break;
		
		case gtMove:
			anim.type = kCATransitionMoveIn; 
		break;
		
		case gtPush:
			anim.type = kCATransitionPush; 
		break;
		
		case gtReveal:
			anim.type = kCATransitionReveal; 
		break;
		
		default:
			GtFail(@"no transition type set");
			break;
	}
	
	switch(GtBitMaskValue(showType, gtSlideInTransition))
	{
		case gtSlideInFromLeft:
			anim.subtype = show ? kCATransitionFromLeft : kCATransitionFromRight;
			break;
			
		case gtSlideInFromRight:
			anim.subtype = show ? kCATransitionFromRight : kCATransitionFromLeft;
			break;	
			
		case gtSlideInFromBottom:	
			anim.subtype = show ? kCATransitionFromTop : kCATransitionFromBottom;
			break;
		
		case gtSlideInFromTop:
			anim.subtype = show ? kCATransitionFromBottom : kCATransitionFromTop;
			break;
			
	}
	
	anim.duration = DURATION;

	CALayer* layer = hostingView.layer;
	[layer addAnimation:anim forKey:@"myAnim"];
		
	if(show)
	{
		[hostingView addSubview:child.view];
	}
	else
	{
		[child.view removeFromSuperview];
	}
	
	[layer removeAnimationForKey:@"myAnim"];
	
}
/*

/*
- (void) flipInOutView:(UIView*) hostingView
	child:(UIViewController*) child
	show:(BOOL) show
{
	[UIView beginAnimations:@"View Flip" context:nil];
	[UIView setAnimationDuration:0.75];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	
//	UIViewController *coming = nil;
//	UIViewController *going = nil;

	[UIView setAnimationTransition: show ? 
		UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight
		forView:hostingView cache:YES];
	
	if(show)
	{
		[child viewWillAppear:YES];
	//	[parent viewWillDisappear:YES];
		[hostingView addSubview:child.view];
		[child viewDidAppear:YES];
	//	[parent viewDidDisappear:YES];
	
	}
	else
	{
		
	//	[parent viewWillAppear:YES];
		[child viewWillDisappear:YES];
		[child.view removeFromSuperview];
	//	[parent viewDidAppear:YES];
		[child viewDidDisappear:YES];
	}

	
	
//	[coming viewWillAppear:YES];
//	[going viewWillDisappear:YES];
//	[going.view removeFromSuperview];
	
//	[self.view insertSubview: coming.view atIndex:0];
//	[going viewDidDisappear:YES];
//	[coming viewDidAppear:YES];

	[UIView commitAnimations];
}
*/

/*
- (void) animateViewTransition:(GtTransitionType) showType
	parentView:(UIView*) parentView
	child:(UIViewController*) child
	show:(BOOL) show
{
	if(showType == gtNoTransition)
	{
		if(show)
		{
			[parentView addSubview:child.view];
		}
		else
		{
			[child.view removeFromSuperview];
		}
	}
	else if(GtTestAllBits(showType, gtFlipIn))
	{
		[self flipInOutView:parentView child:child show:show];
	}
	else
	{
		[self slideInOutView:parentView showType:showType child:child show:show];
	}
}
*/

/*

// THIS IS A HACK - SHOULDN'T NEED THIS

- (void) removeCurrentSubView:(UIView*) parent
{
	if(!m_stack)
	{
		m_stack = [[NSMutableArray alloc] init];
	}
	
	NSArray* views = parent.subviews;
	
	NSMutableArray* viewList = [GtAlloc(NSMutableArray) init];
	for(UIView* view in views)
	{
		GtPair* pair = [[GtPair alloc] initWithValues:parent rhs:view];
		[viewList addObject:pair];
		[view removeFromSuperview];
		[pair release];
	}
	
	[m_stack addObject:viewList];
	GtRelease(viewList);
}

- (void) restoreCurrentSubView
{
	if(m_stack && m_stack.count > 0)
	{
		NSArray* viewList = [m_stack lastObject];
		if(viewList)
		{
			for(GtPair* pair in viewList)
			{	
				[pair.lhs addSubview:pair.rhs];
			}
		}

		[m_stack removeLastObject];
	}
		
}

*/

+ (CGRect) rotatedDeviceBounds
{
	if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
	{
		return GtRotateRect90Degrees([[UIScreen mainScreen] bounds]);
	}
	
	return [[UIScreen mainScreen] bounds];
}

+ (CGRect) rotatedFrameForView:(UIView*) view
{
	if(UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
	{
		return GtRotateRect90Degrees(view.frame);
	}
	
	return view.frame;
}

+ (void) createRoundRectPath:(CGRect) rect cornerRadius:(CGFloat) cornerRadius outPath:(CGPathRef*) outPath
{
	//
	// Create the boundary path
	//
	CGMutablePathRef path = CGPathCreateMutable();
	CGPathMoveToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height - cornerRadius);

	// Top left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		cornerRadius);

	// Top right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom right corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x + rect.size.width,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		cornerRadius);

	// Bottom left corner
	CGPathAddArcToPoint(path, NULL,
		rect.origin.x,
		rect.origin.y + rect.size.height,
		rect.origin.x,
		rect.origin.y,
		cornerRadius);

	// Close the path at the rounded rect
	CGPathCloseSubpath(path);
	
	*outPath = path;
}





@end

#endif