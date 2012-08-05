//
//	UIView+ViewAnimation.m
//	FishLamp
//
//	Created by Mike Fullerton on 4/15/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "UIView+ViewAnimation.h"

@implementation UIView (FLViewAnimation)

- (CGRect) _getOffscreenFrameForPosition:(FLViewAnimationType) position
{
	if(self.superview)
	{
		CGRect superBounds = self.superview.bounds;
		CGRect startFrame = self.frame;

		switch(position)
		{
			case FLViewAnimationTypeSlideFromBottom:
				startFrame.origin.y = superBounds.size.height;
				break;
			case FLViewAnimationTypeSlideFromLeft:
				startFrame.origin.x = - startFrame.size.width;
				break;

			case FLViewAnimationTypeSlideFromRight:
				startFrame.origin.x = superBounds.size.width;
				break;

			case FLViewAnimationTypeSlideFromTop:
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

	FLReturnAutoreleased(FLReturnRetained(self));
	
	if(context)
	{
		FLViewAnimationFinishedBlock finishedBlock = (FLViewAnimationFinishedBlock) context;
		finishedBlock(self);
		FLRelease(finishedBlock);
	}
	
	[self removeFromSuperview];
}

- (void) removeFromSuperviewWithAnimationType:(FLViewAnimationType) type duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock
{
	[UIView beginAnimations:@"viewout" context:finishedBlock ? [finishedBlock copy] : nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneHiding:finished:context:)];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	self.alpha = 0.0;
	if(type != FLViewAnimationTypeFade)
	{
		self.frame = [self _getOffscreenFrameForPosition:type];
	}
	[UIView commitAnimations];
}

- (void) removeFromSuperviewWithAnimationType:(FLViewAnimationType) type duration:(CGFloat) duration
{
	[self removeFromSuperviewWithAnimationType:type duration:duration finishedBlock:nil];
}

- (void) _doneAnimating:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	FLReturnAutoreleased(FLReturnRetained(self));
	
	if(context)
	{
		FLViewAnimationFinishedBlock finishedBlock = (FLViewAnimationFinishedBlock) context;
		finishedBlock(self);
		FLRelease(finishedBlock);
	}

}

- (void) animateOntoScreen:(FLViewAnimationType) type duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock
{
	CGFloat alpha = self.alpha;
	self.alpha = 0.0;
	
	CGRect currentFrame = self.frame;
	if(type != FLViewAnimationTypeFade)
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
	if(type != FLViewAnimationTypeFade)
	{
		self.frame = currentFrame;
	}
	
	[UIView commitAnimations];

}

- (void) animateOntoScreen:(FLViewAnimationType) type duration:(CGFloat) duration
{
	[self animateOntoScreen:type duration:duration finishedBlock:nil];
}

- (void) _doneFading:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	FLViewAnimationFadePayload* payload = (FLViewAnimationFadePayload*) context;
	self.hidden = payload.hidden;
	self.alpha = payload.alpha;
	
	if(payload.finishedBlock)
	{
	   payload.finishedBlock(self); 
	}
	
	FLRelease(payload);
}

+ (void) _doneFadingBatch:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	
	FLBatchAnimationPayload* batchPayload = (FLBatchAnimationPayload*) context;
	
	for(FLViewAnimationFadePayload* payload in batchPayload.payloadArray)
	{
		payload.view.hidden = payload.hidden;
		payload.view.alpha = payload.alpha;
	}

	if(batchPayload.finishedBlock)
	{
	   batchPayload.finishedBlock(batchPayload.payloadArray); 
	}

	FLRelease(batchPayload);
}


- (void) setHiddenWithFade:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock
{
	FLViewAnimationFadePayload* payload = [[FLViewAnimationFadePayload alloc] initWithView:self alpha:self.alpha hidden:hidden finishedBlock:finishedBlock];
	self.hidden = NO;
	if(!hidden)
	{
		self.alpha = 0.0;
	}
   
	[UIView beginAnimations:@"viewin" context:payload];
		//context:(target && action) ? [[FLCallbackObject alloc] initWithContainedTarget:[FLRetainedObject retainedObject:target] action:action] : nil];
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

+ (void) setViewsHiddenWithFade:(NSArray*) views hidden:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLViewBatchAnimationFinishedBlock) finishedBlock
{
	NSMutableArray* payloads = [NSMutableArray arrayWithCapacity:views.count];
	for(UIView* view in views)
	{
		[payloads addObject:[FLViewAnimationFadePayload viewAnimationFadePayload:view alpha:view.alpha hidden:hidden finishedBlock:nil]];
		if(!hidden)
		{
			view.alpha = 0.0;
		}
		view.hidden = NO;
	}
	[UIView beginAnimations:@"viewin" context:[[FLBatchAnimationPayload alloc] initWithPayloadArray:payloads finishedBlock:finishedBlock]];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(_doneFadingBatch:finished:context:)];
	
	for(FLViewAnimationFadePayload* payload in payloads)
	{
		payload.view.alpha = hidden ? 0.0 : payload.alpha;
	}
	
	[UIView commitAnimations];
}

@end

@implementation FLViewAnimationFadePayload

@synthesize alpha = _alpha;
@synthesize hidden = _hidden;
@synthesize view = _view;
@synthesize finishedBlock = _block;

- (id) initWithView:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock
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

+ (FLViewAnimationFadePayload*) viewAnimationFadePayload:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;
{
	return FLReturnAutoreleased([[FLViewAnimationFadePayload alloc] initWithView:view alpha:alpha hidden:hidden finishedBlock:finishedBlock]);
}

- (void) dealloc
{
	FLRelease(_block);
	FLRelease(_view);
	FLSuperDealloc();
}

@end
@implementation FLBatchAnimationPayload

@synthesize finishedBlock = _finishedBlock;
@synthesize payloadArray = _payloadArray;

- (id) initWithPayloadArray:(NSArray*) array finishedBlock:(FLViewBatchAnimationFinishedBlock) finishedBlock
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
	FLRelease(_payloadArray);
	FLRelease(_finishedBlock);
	FLSuperDealloc();
}

@end
