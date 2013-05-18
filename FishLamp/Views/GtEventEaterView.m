//
//  GtEventEaterView.m
//  FishLamp
//
//  Created by Mike Fullerton on 7/24/09.
//  Copyright 2009 Greentongue Software. All rights reserved.
//

#import "GtEventEaterView.h"
#import "GtViewUtilities.h"
#import "GtCallback.h"

@implementation GtEventEaterView

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if(self = [super initWithCoder:aDecoder])
	{
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
		self.backgroundColor = [UIColor blackColor];// [UIColor grayColor];
		self.alpha = 0.5;
	}
	return self;
}

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        // Initialization code
		
		self.userInteractionEnabled = YES;
		self.exclusiveTouch = YES;
		
		self.backgroundColor = [UIColor blackColor];// [UIColor grayColor];
		self.alpha = 0.5;
		
	}
    return self;
}

- (void)dealloc {
	[m_image release];
    [super dealloc];
}

- (void)doneRemoving:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[((UIView*) context) removeFromSuperview];
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];
}

- (void) addViewAtPoint:(CGPoint) pt
{
	if(!m_image)
	{
		m_image = [[UIImage imageNamed:@"thumbprint60.png"] retain];
	}

	UIImageView* view = [GtAlloc(UIImageView) initWithImage:m_image];

	CATransition* anim = [CATransition animation];
	anim.timingFunction = UIViewAnimationCurveEaseInOut;
	anim.type = kCATransitionFade; 
	anim.duration = 0.2;
	
	CGRect frame = view.frame;
	frame.origin.x = pt.x - (frame.size.width/2);
	frame.origin.y = pt.y - (frame.size.height/2);
	view.frame = frame;
	
	CALayer* layer = self.layer;
	[layer addAnimation:anim forKey:@"add"];
	[self addSubview:view];
	[layer removeAnimationForKey:@"add"];
	
	[UIView beginAnimations:@"viewout" context:view];
	[UIView setAnimationDuration:3.0];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(doneRemoving:finished:context:)];
	view.alpha = 0.0;
	[UIView commitAnimations];

	GtRelease(view);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
	CGPoint pt = [[touches anyObject] locationInView:self]; 
	[self addViewAtPoint:pt];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//	CGPoint pt = [[touches anyObject] locationInView:self]; 
//	[self addViewAtPoint:pt];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
//	CGPoint pt = [[touches anyObject] locationInView:self]; 
//	[self addViewAtPoint:pt];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
}

@end
