//
//  GtThumbnailButton.m
//  MyZen
//
//  Created by Mike Fullerton on 12/6/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtThumbnailButton.h"
#import "GtGeometry.h"
#import "GtColors.h"

#define ANIMATE_LEN 0.3

@implementation GtThumbnailButton

@synthesize centeredView = m_centeredView;

GtSynthesize(callback, setCallback, GtSimpleCallback, m_callback);
GtSynthesizeID(userData, setUserData);

- (void) initThumbnailButton
{
	self.userInteractionEnabled = YES;
	self.autoresizesSubviews = NO;
	self.autoresizingMask =	UIViewAutoresizingNone; 
	self.backgroundColor = [UIColor lightLightGrayColor];
	self.exclusiveTouch = YES;
}

- (id)initWithFrame:(CGRect)frame
{
	if(self = [super initWithFrame:frame])
	{
		[self initThumbnailButton];
		
		m_originalFrame = frame;
	}
	return self;
}

- (id)initWithImage:(UIImage *)image
{
	if(self = [super initWithImage:image])
	{
		[self initThumbnailButton];
	}
	return self;
}

- (id)initWithImage:(UIImage *)image highlightedImage:(UIImage *)highlightedImage
{
	if(self = [super initWithImage:image highlightedImage:highlightedImage])
	{
		[self initThumbnailButton];
	}
	return self;
}

- (void) dealloc
{
	GtRelease(m_userData);
	GtRelease(m_callback);
	[super dealloc];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
	[super encodeWithCoder:aCoder];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if(self = [super initWithCoder:aDecoder])
	{
		[self initThumbnailButton];
	}
	return self;
}

- (void)addTarget:(id)target action:(SEL)action
{
    GtSimpleCallback* cb = [GtAlloc(GtSimpleCallback) initWithTargetAndAction:target action:action];
	self.callback = cb;
    GtRelease(cb);
}

- (BOOL) enabled
{
	return m_buttonFlags.enabled;
}

- (void) setEnabled:(BOOL) enabled
{
	m_buttonFlags.enabled = enabled;
	
	if(enabled)
	{
		self.alpha = 1.0;
	}
	else
	{
		self.alpha = 0.5;
	}
}

- (void) setImage:(UIImage*) image
{
	CGRect frame = self.frame;
	CGSize size = frame.size;

	if(image)
	{
		frame.size = image.size;
		self.frame = frame;
	}
	
	[super setImage:image];
	
	frame.size = size;
	self.frame = frame;
	
	m_originalFrame = frame;
	
	[self setNeedsDisplay];
}

- (void) doNextAnimation
{
	if(++m_currentAnimation == m_animationQueue.count)
	{
		GtReleaseWithNil(m_animationQueue);
		[self.callback invoke:self];
	}
	else
	{
		GtSimpleCallback* cb = [m_animationQueue objectAtIndex:m_currentAnimation];
		[cb invoke];
	}
}

- (void) animate
{
	GtReleaseWithNil(m_animationQueue);

	m_currentAnimation = -1;
	m_animationQueue = [GtAlloc(NSArray) initWithObjects:
		[GtSimpleCallback simpleCallback:self action:@selector(shrinkAnimation)],
		[GtSimpleCallback simpleCallback:self action:@selector(growAnimation)],
		[GtSimpleCallback simpleCallback:self action:@selector(shrinkAnimation)],
		[GtSimpleCallback simpleCallback:self action:@selector(bigGrowAnimation)],
		nil];
	
	[self doNextAnimation];
}

- (void)animationDone:(NSString *)animationID 
	finished:(NSNumber *)finished 
	context:(void *)context
{
	[UIView setAnimationDelegate:nil];
	[UIView setAnimationDidStopSelector:nil];

	[self doNextAnimation];
}

- (CGFloat) animSliceLen
{
	return ANIMATE_LEN / m_animationQueue.count;
}

- (void) shrinkAnimation
{
	CGRect frame = self.frame;
	
	frame = CGRectInset(frame, 5,5);
	
	[UIView beginAnimations:@"in" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	self.frame = frame;
//	self.alpha = 0.5;
	
	if(m_centeredView)
	{
		m_centeredView.frame = GtCenterRectInRect(frame, m_centeredView.frame);
	}
	
	[UIView commitAnimations];
}

- (void) growAnimation
{
	[UIView beginAnimations:@"out" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	self.frame = m_originalFrame;
//	self.alpha = 1.0;

	if(m_centeredView)
	{
		m_centeredView.frame = GtCenterRectInRect(m_originalFrame, m_centeredView.frame);
	}

	[UIView commitAnimations];
}

- (void) bigGrowAnimation
{
	[UIView beginAnimations:@"out" context:nil];
	[UIView setAnimationDelegate:self];
	[UIView setAnimationDidStopSelector:@selector(animationDone:finished:context:)];
	[UIView setAnimationDuration:self.animSliceLen];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];

	self.frame = m_originalFrame;

	if(m_centeredView)
	{
		m_centeredView.frame = GtCenterRectInRect(m_originalFrame, m_centeredView.frame);
	}

	[UIView commitAnimations];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesBegan:touches withEvent:event];
	
	[self animate];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
//	[super touchesCancelled:touches withEvent:event];
}

-(void) touchesEnded: (NSSet *) touches withEvent: (UIEvent *) event 
{	
//	[super touchesEnded: touches withEvent: event];
}

/*
- (void)drawRect:(CGRect)rect
{
	[super drawRect:rect];

//	if(!self.hasImage)
	{
		CGRect bounds = self.bounds;
	
		CGContextRef ctx = UIGraphicsGetCurrentContext(); //get the graphics context
		CGContextSetLineWidth(ctx, 0.25);
		CGContextSetRGBStrokeColor(ctx, 0.5, 0.5, 0.5, 1); 
		CGContextMoveToPoint(ctx,	 bounds.origin.x, bounds.origin.y); // top left
		CGContextAddLineToPoint(ctx, bounds.origin.x + bounds.size.width, bounds.origin.y); // top right
		CGContextAddLineToPoint(ctx, bounds.origin.x + bounds.size.width, bounds.origin.y + bounds.size.height); // bottom right
		CGContextAddLineToPoint(ctx, bounds.origin.x, bounds.origin.y + bounds.size.height); // bottom left
		CGContextAddLineToPoint(ctx, bounds.origin.y, bounds.origin.y); // top left
		CGContextStrokePath(ctx);
	}
}
*/

@end
