//
//	FLThumbnailButton.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLThumbnailButton.h"
#import "FLGeometry.h"


#define ANIMATE_LEN 0.3


@interface FLThumbnailButton (Private)
- (void) animate;
@end

@implementation FLThumbnailButton

@synthesize callback = _callback;
FLSynthesizeStructProperty(selectedBehavior, setSelectedBehavior, FLThumbnailButtonSelectedBehavior, _buttonFlags);
@synthesize buttonAnimation = _buttonAnimation;

@synthesize userData = _userData;

static FLThumbnailButton* s_touchedButton = nil;

- (id)initWithFrame:(CGRect)frame
{
	if((self = [super initWithFrame:frame]))
	{
		self.selectedBehavior = FLThumbnailButtonSelectedBehaviorNone;
		self.backgroundColor = [UIColor clearColor];
		self.autoresizingMask = UIViewAutoresizingNone;
		self.autoresizesSubviews = YES;
		self.exclusiveTouch = NO;
		self.userInteractionEnabled = NO;
	}
	
	return self;
}

+ (FLThumbnailButton*) thumbnailButton
{
	return FLAutorelease([[FLThumbnailButton alloc] initWithFrame:CGRectZero]);
}	

- (void) dealloc
{
	if(s_touchedButton == self)
	{
		s_touchedButton = nil;
	}
	FLRelease(_userData);
	FLRelease(_callback);
	FLRelease(_buttonAnimation);
	FLSuperDealloc();
}

- (void)addTarget:(id)target action:(SEL)action
{
	FLCallbackObject* cb = [[FLCallbackObject alloc] initWithTarget:target action:action];
	self.callback = cb;
	FLReleaseWithNil(cb);
	
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
		if(self.selectedBehavior == FLThumbnailButtonSelectedBehaviorAnimate)
		{
			if(self.selected)
			{
				[_buttonAnimation setButtonSelected:self selected:NO];
				[_buttonAnimation beginAnimation:self];
			}
		}
		else if(self.selectedBehavior == FLThumbnailButtonSelectedBehaviorOverlayColor)
		{
			self.backgroundColor = [UIColor clearColor];
			self.alpha = 1.0;
			_buttonFlags.selected = NO;
			
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
	_buttonFlags.selected = NO;
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
	return _buttonFlags.selected;
}

- (void) setSelected:(BOOL) selected
{
	if(_buttonFlags.selected != selected)
	{
		_buttonFlags.selected = selected;

		if(self.selectedBehavior == FLThumbnailButtonSelectedBehaviorOverlayColor)
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

@implementation FLButtonAnimation 

@synthesize delegate = _delegate;

- (void) beginAnimation:(FLThumbnailButton*) button
{
}

- (void) setButtonSelected:(FLThumbnailButton*) button selected:(BOOL) selected
{
}

@end

@implementation FLBounceButtonAnimation

FLSynthesizeSingleton(FLBounceButtonAnimation);

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

#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Warc-performSelector-leaks"

- (void) doNextAnimation:(FLThumbnailButton*) button
{
	if(++_currentAnimation < (NSInteger) AnimationQueueCount)
	{
		[self performSelector:s_selectors[_currentAnimation] withObject:button];
	}
	else
	{
		_currentAnimation = -1;
		[button setNeedsLayout];
	}
}

#pragma GCC diagnostic pop


- (void) doCallback:(FLThumbnailButton*) button
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

	[self doNextAnimation:bridge_(id, context)];
}

- (CGFloat) animSliceLen
{
	return ANIMATE_LEN / AnimationQueueCount;
}




- (void) shrinkAnimation:(FLThumbnailButton*) button
{
	CGRect frame = button.frame;
	
	frame = CGRectInset(frame, 5,5);
	
	[UIView beginAnimations:@"in" context:bridge_(void*,button)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	button.frame = frame;
	[UIView commitAnimations];
}

- (void) growAnimation:(FLThumbnailButton*) button
{
	[UIView beginAnimations:@"out" context:bridge_(void*,button)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	button.frame = _originalFrame;
	[UIView commitAnimations];
}

- (void) bigGrowAnimation:(FLThumbnailButton*) button
{
	[UIView beginAnimations:@"out" context:bridge_(void*,button)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	button.frame = _originalFrame;

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

- (void) beginAnimation:(FLThumbnailButton*) button
{
	_originalFrame = button.frame;
	_currentAnimation = -1;
	[self doNextAnimation:button];
}
@end

@implementation FLZoomButtonAnimation

+ (FLZoomButtonAnimation*) zoomButtonAnimation:(id<FLButtonAnimationDelegate>) delegate
{
	FLZoomButtonAnimation* animation = FLAutorelease([[FLZoomButtonAnimation alloc] init]);
	animation.delegate = delegate;
	return animation;
}

- (void)animationDone:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];

	UIImageView* view = bridge_(id, context);
	[view removeFromSuperview];
	[_button.callback invoke:_button];
}

- (void) beginAnimation:(FLThumbnailButton*) button
{
	_button = button;
	
	UIView* hostView = [_delegate buttonAnimationGetHostView:self];
	
	CGRect frame = [hostView convertRect:button.frame fromView:button];
	
	UIImageView* zoomView = [[UIImageView alloc] initWithFrame:frame];
	zoomView.backgroundColor = [UIColor blackColor];
	zoomView.contentMode = UIViewContentModeScaleAspectFit;
	zoomView.image = button.foregroundImage;
	[hostView addSubview:zoomView];
	
	[UIView beginAnimations:@"out" context:bridge_(void*,zoomView)];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:0.25];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
	zoomView.frame = FLRectMakeWithSize(hostView.frame.size);
	[UIView commitAnimations];
}

@end
