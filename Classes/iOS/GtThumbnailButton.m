//
//	GtThumbnailButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThumbnailButton.h"
#import "GtGeometry.h"


#define ANIMATE_LEN 0.3


@interface GtThumbnailButton (Private)
- (void) animate;
@end

@implementation GtThumbnailButton

@synthesize callback = m_callback;
GtSynthesizeStructProperty(selectedBehavior, setSelectedBehavior, GtThumbnailButtonSelectedBehavior, m_buttonFlags);
@synthesize buttonAnimation = m_buttonAnimation;

@synthesize userData = m_userData;

static GtThumbnailButton* s_touchedButton = nil;

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.selectedBehavior = GtThumbnailButtonSelectedBehaviorNone;
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = YES;
		self.exclusiveTouch = NO;
		self.userInteractionEnabled = NO;
	}
	
	return self;
}

+ (GtThumbnailButton*) thumbnailButton
{
	return GtReturnAutoreleased([[GtThumbnailButton alloc] initWithFrame:CGRectZero]);
}	

- (void) dealloc
{
	if(s_touchedButton == self)
	{
		s_touchedButton = nil;
	}
	GtRelease(m_userData);
	GtRelease(m_callback);
	GtRelease(m_buttonAnimation);
	GtSuperDealloc();
}

- (void)addTarget:(id)target action:(SEL)action
{
	GtCallbackObject* cb = [[GtCallbackObject alloc] initWithTarget:target action:action];
	self.callback = cb;
	GtReleaseWithNil(cb);
	
	self.userInteractionEnabled = YES;
	self.exclusiveTouch = YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled && !s_touchedButton)
	{
		s_touchedButton = self;
		self.selected = YES;
	}
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	if(self.enabled && s_touchedButton == self)
	{
		UITouch* touch = [touches anyObject];
		CGPoint touchPoint = [touch locationInView:self];
		self.selected = CGRectContainsPoint(self.bounds, touchPoint);
	}
}

- (void) touchUp: (NSSet *) touches 
{
	if(self.enabled && s_touchedButton == self)
	{
		if(self.selectedBehavior == GtThumbnailButtonSelectedBehaviorAnimate)
		{
			if(self.selected)
			{
				[m_buttonAnimation setButtonSelected:self selected:NO];
				[m_buttonAnimation beginAnimation:self];
			}
		}
		else if(self.selectedBehavior == GtThumbnailButtonSelectedBehaviorOverlayColor)
		{
			self.backgroundColor = [UIColor clearColor];
			self.alpha = 1.0;
			m_buttonFlags.selected = NO;
			
			[self.callback invoke:self];
		}
		else if(self.callback)
		{
			[self.callback invoke:self];
		}
	}
	if(s_touchedButton == self)
	{
		s_touchedButton = nil;
	}
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event 
{
	self.backgroundColor = [UIColor clearColor];
	self.alpha = 1.0;
	m_buttonFlags.selected = NO;
	if(s_touchedButton == self)
	{
		s_touchedButton = nil;
	}
}

-(void) touchesEnded: (NSSet *) touches 
		   withEvent: (UIEvent *) event 
{	
	UITouch* touch = [touches anyObject];
	CGPoint touchPt = [touch locationInView:self];
	
	if([self hitTest:touchPt withEvent:event])
	{
		[self touchUp:touches];
	}
	else
	{
		[self touchesCancelled:touches withEvent:event];
	}
}

- (BOOL) selected
{
	return m_buttonFlags.selected;
}

- (void) setSelected:(BOOL) selected
{
	if(m_buttonFlags.selected != selected)
	{
		m_buttonFlags.selected = selected;

		if(self.selectedBehavior == GtThumbnailButtonSelectedBehaviorOverlayColor)
		{
			if(selected)
			{
				self.backgroundColor = [UIColor iPhoneBlueColor];
				self.alpha = 0.5;
			//	  self.imageLayer.opacity = 0.5;
			}
			else
			{
				self.backgroundColor = [UIColor whiteColor];
				self.alpha = 1.0;
				
//				  self.imageLayer.opacity = 1.0;
//				  self.imageLayer.opaque = YES;
			}
		}
	}
}

@end

@implementation GtButtonAnimation 

@synthesize delegate = m_delegate;

- (void) beginAnimation:(GtThumbnailButton*) button
{
}

- (void) setButtonSelected:(GtThumbnailButton*) button selected:(BOOL) selected
{
}

@end

@implementation GtBounceButtonAnimation

GtSynthesizeSingleton(GtBounceButtonAnimation);

#define AnimationQueueCount 5
static SEL s_selectors[AnimationQueueCount];

- (void)animationDidStart:(CAAnimation *)anim
{
}

/* Called when the animation either completes its active duration or
 * is removed from the object it is attached to (i.e. the layer). 'flag'
 * is true if the animation reached the end of its active duration
 * without being removed. */

//- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)finished
//{
//	  [self setNeedsDisplay];
//}

- (void) doNextAnimation:(GtThumbnailButton*) button
{
	if(++m_currentAnimation < (NSInteger) AnimationQueueCount)
	{
		[self performSelector:s_selectors[m_currentAnimation] withObject:button];
	}
	else
	{
		m_currentAnimation = -1;
		[button setNeedsLayout];
	}
}

- (void) doCallback:(GtThumbnailButton*) button
{
	[button.callback invoke:button];
	[self doNextAnimation:button];
}

- (void)animationDone:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];

	[self doNextAnimation:(GtThumbnailButton*) context];
}

- (CGFloat) animSliceLen
{
	return ANIMATE_LEN / AnimationQueueCount;
}




- (void) shrinkAnimation:(GtThumbnailButton*) button
{
	CGRect frame = button.frame;
	
	frame = CGRectInset(frame, 5,5);
	
	[UIView beginAnimations:@"in" context:button];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	button.frame = frame;
	[UIView commitAnimations];
}

- (void) growAnimation:(GtThumbnailButton*) button
{
	[UIView beginAnimations:@"out" context:button];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	button.frame = m_originalFrame;
	[UIView commitAnimations];
}

- (void) bigGrowAnimation:(GtThumbnailButton*) button
{
	[UIView beginAnimations:@"out" context:button];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	button.frame = m_originalFrame;

	[UIView commitAnimations];
}

+ (void) initialize
{
	s_selectors[0] = @selector(shrinkAnimation:);
	s_selectors[1] = @selector(growAnimation:);
	s_selectors[2] = @selector(shrinkAnimation:);
	s_selectors[3] = @selector(bigGrowAnimation:);
	s_selectors[4] = @selector(doCallback:);
}

- (void) beginAnimation:(GtThumbnailButton*) button
{
	m_originalFrame = button.frame;
	m_currentAnimation = -1;
	[self doNextAnimation:button];
}
@end

@implementation GtZoomButtonAnimation

+ (GtZoomButtonAnimation*) zoomButtonAnimation:(id<GtButtonAnimationDelegate>) delegate
{
	GtZoomButtonAnimation* animation = GtReturnAutoreleased([[GtZoomButtonAnimation alloc] init]);
	animation.delegate = delegate;
	return animation;
}

- (void)animationDone:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];

	UIImageView* view = (UIImageView*) context;
	[view removeFromSuperview];
	[m_button.callback invoke:m_button];
}

- (void) beginAnimation:(GtThumbnailButton*) button
{
	m_button = button;
	
	UIView* hostView = [m_delegate buttonAnimationGetHostView:self];
	
	CGRect frame = [hostView convertRect:button.frame fromView:button];
	
	UIImageView* zoomView = [[UIImageView alloc] initWithFrame:frame];
	zoomView.backgroundColor = [UIColor blackColor];
	zoomView.contentMode = UIViewContentModeScaleAspectFit;
	zoomView.image = button.foregroundImage;
	[hostView addSubview:zoomView];
	
	[UIView beginAnimations:@"out" context:zoomView];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	zoomView.frame = GtRectMakeWithSize(hostView.frame.size);
	[UIView commitAnimations];
}

@end
