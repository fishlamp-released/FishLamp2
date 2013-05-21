//
//  GtViewDragger.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtOldViewDragger.h"
//#import "GtWidgetView.h"

@implementation GtOldViewDragger

@synthesize window = m_window;

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}

- (void) dealloc
{
    [[GtApplication sharedApplication].keyWindow removeEventInterceptor:self];
    GtRelease(m_item);
    GtSuperDealloc();
}

- (BOOL) isWatchingTouches
{
    return m_window != nil;
}

+ (GtOldViewDragger*) viewDragger
{
    return GtReturnAutoreleased([[GtOldViewDragger alloc] init]);
}

- (void) beginWatchingTouchesForDraggableItem:(id<GtDraggableItem>) item
{
    [self stopWatchingTouches];

    GtAssertNotNil(item.touchableView);
    GtAssertNotNil(item.touchableView.window);
    m_item = GtRetain(item);

   [[GtApplication sharedApplication].keyWindow addEventInterceptor:self];
}

- (void) stopWatchingTouches
{
    [[GtApplication sharedApplication].keyWindow removeEventInterceptor:self];
    GtReleaseWithNil(m_item);
}

- (CGPoint) pointInView:(CGPoint) windowCoordinatePoint
{
    return [m_window convertPoint:windowCoordinatePoint toView:m_item.touchableView];
}

- (BOOL) _isOurView:(UIView*) aView
{
    if( [aView isDescendantOfView:m_item.touchableView])
    {
        return YES;
    }
    
    return NO;
}

/*
- (void) _didEndDrag:(GtViewDraggerDragInfo) drag
{
    NSArray* frames = [m_item dragDestinations];
    
    if(frames && frames.count)
    {
        CGPoint center = GtRectGetCenter(drag.frame);
        
        NSInteger closestIndex = 0;
        
        float closest = GtDistanceBetweenTwoPoints(center, GtRectGetCenter([[frames objectAtIndex:0] rectValue]));
        
        for(int i = 1; i < frames.count; i++)
        {
            float distance = GtDistanceBetweenTwoPoints(center, GtRectGetCenter([[frames objectAtIndex:i] rectValue]));
            
            if(distance < closest)
            {
                closest = distance;
                closestIndex = i;
            }   
        }
        
        drag.frame = [[frames objectAtIndex:closestIndex] rectValue];
        
        [UIView animateWithDuration:0.2
            delay:0.0f
            options:UIViewAnimationOptionCurveEaseInOut
            animations:^{
                [m_item viewDragger:self dragWillMove:drag];
            } 
            completion:^(BOOL completed) {
                [m_item viewDragger:self dragDidFinish:drag];
            }
        ];
    }
    else
    {
        [m_item viewDragger:self dragWillMove:drag];
            
        [m_item viewDragger:self dragDidFinish:drag];
    }
}                       


- (BOOL) windowWillSendEvent:(GtWindow*) window event:(UIEvent*) event
{
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];

        if(touch.phase == UITouchPhaseBegan)
		{
            m_touchIsInside = [self _isOurView:touch.view];
            if(m_touchIsInside)
            {
                m_firstTouch = [touch locationInView:m_window];
                m_lastTouch = m_firstTouch;
                [m_item viewDraggerDragWillBegin:self];
            }
        }
         
        if(m_touchIsInside)
        {     
            GtViewDraggerDragInfo drag;
            drag.currentTouch = [touch locationInView:m_window];
            drag.previousTouch = m_lastTouch;
            drag.firstTouch = m_firstTouch;
            
            CGRect frame = m_item.frame;
            
            CGRect newFrame = GtRectMoveWithPoint(frame, GtPointSubtractPointFromPoint(drag.currentTouch, m_lastTouch));
            
            CGRect limit = m_item.dragLimit;

            if(limit.size.width > frame.size.width)
            {
                if(newFrame.origin.x < limit.origin.x)
                {
                    newFrame.origin.x = limit.origin.x;
                }
                if(GtRectGetRight(newFrame) > GtRectGetRight(limit))
                {
                    newFrame.origin.x = GtRectGetRight(limit) - newFrame.size.width;
                }
            
                frame.origin.x = newFrame.origin.x;
            }
            
            if(limit.size.height > frame.size.height)
            {
                if(newFrame.origin.y < limit.origin.y)
                {
                    newFrame.origin.y = limit.origin.y;
                }
                if(GtRectGetBottom(newFrame) > GtRectGetBottom(limit))
                {
                    newFrame.origin.y = GtRectGetBottom(limit) - frame.size.height;
                }
                
                frame.origin.y = newFrame.origin.y;
            }
            drag.currentDelta = GtPointSubtractPointFromPoint(newFrame.origin, frame.origin);
            
            drag.frame = frame;
        
            switch(touch.phase)
            {
                case UITouchPhaseBegan:
                break;
                                            
                case UITouchPhaseStationary:
                case UITouchPhaseMoved:
                    [m_item viewDragger:self dragWillMove:drag];
                break;
                
                case UITouchPhaseCancelled:
                case UITouchPhaseEnded:
                    [self _didEndDrag:drag];
                break;
            }
            
            m_lastTouch = drag.currentTouch;
        }
    }

    return YES;
}
*/


- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];

        if(touch.phase == UITouchPhaseBegan)
		{
            m_touchIsInside = [self _isOurView:touch.view];
            if(m_touchIsInside)
            {
                m_firstTouch = [touch locationInView:m_window];
                m_lastTouch = m_firstTouch;
                [m_item viewDraggerDragWillBegin:self];
            }
        }
         
        if(m_touchIsInside)
        {     
            GtViewDraggerDragInfo drag;
            drag.currentTouch = [touch locationInView:m_window];
            drag.previousTouch = m_lastTouch;
            drag.firstTouch = m_firstTouch;
            
            CGRect frame = m_item.frame;
            
            CGRect newFrame = GtRectMoveWithPoint(frame, GtPointSubtractPointFromPoint(drag.currentTouch, m_lastTouch));
            
            CGRect limit = m_item.dragLimit;

            if(limit.size.width > frame.size.width)
            {
                if(newFrame.origin.x < limit.origin.x)
                {
                    newFrame.origin.x = limit.origin.x;
                }
                if(GtRectGetRight(newFrame) > GtRectGetRight(limit))
                {
                    newFrame.origin.x = GtRectGetRight(limit) - newFrame.size.width;
                }
            
                frame.origin.x = newFrame.origin.x;
            }
            
            if(limit.size.height > frame.size.height)
            {
                if(newFrame.origin.y < limit.origin.y)
                {
                    newFrame.origin.y = limit.origin.y;
                }
                if(GtRectGetBottom(newFrame) > GtRectGetBottom(limit))
                {
                    newFrame.origin.y = GtRectGetBottom(limit) - frame.size.height;
                }
                
                frame.origin.y = newFrame.origin.y;
            }
            drag.currentDelta = GtPointSubtractPointFromPoint(newFrame.origin, frame.origin);
            
            drag.frame = frame;
        
            switch(touch.phase)
            {
                case UITouchPhaseBegan:
                break;
                                            
                case UITouchPhaseStationary:
                case UITouchPhaseMoved:
                    [m_item viewDragger:self dragWillMove:drag];
                break;
                
                case UITouchPhaseCancelled:
                case UITouchPhaseEnded:
//                    [self _didEndDrag:drag];
                break;
            }
            
            m_lastTouch = drag.currentTouch;
        }
    }

    return YES;
}



@end
