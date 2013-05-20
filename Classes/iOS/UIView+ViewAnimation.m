//
//	UIView+ViewAnimation.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/15/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "UIView+ViewAnimation.h"

@implementation UIView (GtViewAnimation)

- (CGRect) _getOffscreenFrameForPosition:(GtViewAnimationType) position
{
	if(self.superview)
	{
		CGRect superBounds = self.superview.bounds;
		CGRect startFrame = self.frame;

		switch(position)
		{
			case GtViewAnimationTypeSlideFromBottom:
				startFrame.origin.y = superBounds.size.height;
				break;
			case GtViewAnimationTypeSlideFromLeft:
				startFrame.origin.x = - startFrame.size.width;
				break;

			case GtViewAnimationTypeSlideFromRight:
				startFrame.origin.x = superBounds.size.width;
				break;

			case GtViewAnimationTypeSlideFromTop:
				startFrame.origin.y = - startFrame.size.height;
				break;
				
			default:
				break;

		}
	 
		return startFrame;
	}
	else
	{
		return CGRectZero;
	}
}

- (void) _doneHiding:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];

	GtReturnAutoreleased(GtRetain(self));
	
	if(context)
	{
		GtViewAnimationFinishedBlock finishedBlock = (GtViewAnimationFinishedBlock) context;
		finishedBlock(self);
		GtRelease(finishedBlock);
	}
	
	[self removeFromSuperview];
}

- (void) removeFromSuperviewWithAnimationType:(GtViewAnimationType) type duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock
{
	[UIView beginAnimations:@"viewout" context:finishedBlock ? [finishedBlock copy] : nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneHiding:finished:context:)];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.alpha = 0.0;
	if(type != GtViewAnimationTypeFade)
	{
		self.frame = [self _getOffscreenFrameForPosition:type];
	}
	[UIView commitAnimations];
}

- (void) removeFromSuperviewWithAnimationType:(GtViewAnimationType) type duration:(CGFloat) duration
{
	[self removeFromSuperviewWithAnimationType:type duration:duration finishedBlock:nil];
}

- (void) _doneAnimating:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	GtReturnAutoreleased(GtRetain(self));
	
	if(context)
	{
		GtViewAnimationFinishedBlock finishedBlock = (GtViewAnimationFinishedBlock) context;
		finishedBlock(self);
		GtRelease(finishedBlock);
	}

}

- (void) animateOntoScreen:(GtViewAnimationType) type duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock
{
	CGFloat alpha = self.alpha;
	self.alpha = 0.0;
	
	CGRect currentFrame = self.frame;
	if(type != GtViewAnimationTypeFade)
	{
		self.frame = [self _getOffscreenFrameForPosition:type];
	}
	
	[UIView beginAnimations:@"viewin" context:finishedBlock ? [finishedBlock copy] : nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneAnimating:finished:context:)];
   
	self.alpha = alpha;
	if(alpha == 1.0f)
	{
		self.opaque = YES;
	}
	if(type != GtViewAnimationTypeFade)
	{
		self.frame = currentFrame;
	}
	
	[UIView commitAnimations];

}

- (void) animateOntoScreen:(GtViewAnimationType) type duration:(CGFloat) duration
{
	[self animateOntoScreen:type duration:duration finishedBlock:nil];
}

- (void) _doneFading:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	GtViewAnimationFadePayload* payload = (GtViewAnimationFadePayload*) context;
	self.hidden = payload.hidden;
	self.alpha = payload.alpha;
	
	if(payload.finishedBlock)
	{
	   payload.finishedBlock(self); 
	}
	
	GtRelease(payload);
}

+ (void) _doneFadingBatch:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	
	GtBatchAnimationPayload* batchPayload = (GtBatchAnimationPayload*) context;
	
	for(GtViewAnimationFadePayload* payload in batchPayload.payloadArray)
	{
		payload.view.hidden = payload.hidden;
		payload.view.alpha = payload.alpha;
	}

	if(batchPayload.finishedBlock)
	{
	   batchPayload.finishedBlock(batchPayload.payloadArray); 
	}

	GtRelease(batchPayload);
}


- (void) setHiddenWithFade:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock
{
	GtViewAnimationFadePayload* payload = [[GtViewAnimationFadePayload alloc] initWithView:self alpha:self.alpha hidden:hidden finishedBlock:finishedBlock];
	self.hidden = NO;
	if(!hidden)
	{
		self.alpha = 0.0;
	}
   
	[UIView beginAnimations:@"viewin" context:payload];
		//context:(target && action) ? [[GtCallbackObject alloc] initWithContainedTarget:[GtRetainedObject retainedObject:target] action:action] : nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneFading:finished:context:)];
	self.alpha = hidden ? 0.0 : payload.alpha;
	[UIView commitAnimations];
}

- (void)doPopInAnimation:(CGFloat) duration
{
	[self doPopInAnimationWithDelegate:nil duration:duration];
}
- (void)doPopInAnimationWithDelegate:(id)animationDelegate duration:(CGFloat) duration
{
	CALayer *viewLayer = self.layer;
	CAKeyframeAnimation* popInAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
	
	popInAnimation.duration = duration;
	popInAnimation.values = [NSArray arrayWithObjects:
							 [NSNumber numberWithFloat:0.6],
							 [NSNumber numberWithFloat:1.1],
							 [NSNumber numberWithFloat:.9],
							 [NSNumber numberWithFloat:1],
							 nil];
	popInAnimation.keyTimes = [NSArray arrayWithObjects:
							   [NSNumber numberWithFloat:0.0],
							   [NSNumber numberWithFloat:0.6],
							   [NSNumber numberWithFloat:0.8],
							   [NSNumber numberWithFloat:1.0], 
							   nil];	
	popInAnimation.delegate = animationDelegate;
	
	[viewLayer addAnimation:popInAnimation forKey:@"transform.scale"];	
}

+ (void) setViewsHiddenWithFade:(NSArray*) views hidden:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(GtViewBatchAnimationFinishedBlock) finishedBlock
{
	NSMutableArray* payloads = [NSMutableArray arrayWithCapacity:views.count];
	for(UIView* view in views)
	{
		[payloads addObject:[GtViewAnimationFadePayload viewAnimationFadePayload:view alpha:view.alpha hidden:hidden finishedBlock:nil]];
		if(!hidden)
		{
			view.alpha = 0.0;
		}
		view.hidden = NO;
	}
	[UIView beginAnimations:@"viewin" context:[[GtBatchAnimationPayload alloc] initWithPayloadArray:payloads finishedBlock:finishedBlock]];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneFadingBatch:finished:context:)];
	
	for(GtViewAnimationFadePayload* payload in payloads)
	{
		payload.view.alpha = hidden ? 0.0 : payload.alpha;
	}
	
	[UIView commitAnimations];
}

@end

@implementation GtViewAnimationFadePayload

@synthesize alpha = m_alpha;
@synthesize hidden = m_hidden;
@synthesize view = m_view;
@synthesize finishedBlock = m_block;

- (id) initWithView:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock
{
	if((self = [super init]))
	{
		self.view = view;
		self.alpha = alpha;
		self.hidden = hidden;
		self.finishedBlock = finishedBlock;
	}
	return self;
	
}

+ (GtViewAnimationFadePayload*) viewAnimationFadePayload:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;
{
	return GtReturnAutoreleased([[GtViewAnimationFadePayload alloc] initWithView:view alpha:alpha hidden:hidden finishedBlock:finishedBlock]);
}

- (void) dealloc
{
	GtRelease(m_block);
	GtRelease(m_view);
	GtSuperDealloc();
}

@end
@implementation GtBatchAnimationPayload

@synthesize finishedBlock = m_finishedBlock;
@synthesize payloadArray = m_payloadArray;

- (id) initWithPayloadArray:(NSArray*) array finishedBlock:(GtViewBatchAnimationFinishedBlock) finishedBlock
{
	if((self = [super init]))
	{
		self.payloadArray = array;
		self.finishedBlock = finishedBlock;
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_payloadArray);
	GtRelease(m_finishedBlock);
	GtSuperDealloc();
}

@end
