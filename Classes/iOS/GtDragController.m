//
//  GtDragController.m
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtDragController.h"
#import "GtApplication.h"
#import "GtExternalTouchViewCloser.h"

@interface GtDragController ()
@end

@implementation GtDragController

@synthesize touchableView = m_touchableView;

GtSynthesizeStructProperty(isDragging, setDragging, BOOL, m_flags);
GtSynthesizeStructProperty(dragWatcherIsRunning, setDragWatcherIsRunning, BOOL, m_flags);

@synthesize delegate = m_delegate;

- (id) init
{
    if((self = [super init]))
    {
    }

    return self;
}

+ (id) dragController
{
    return GtReturnAutoreleased([[[self class] alloc] init]);
}

- (void) startDragWatcher
{
    [self stopDragWatcher];

//    GtAssertNotNil([GtWindow topWindow]);
//    GtAssert([[GtWindow topWindow] isKindOfClass:[GtWindow class]], @"not a gtwindow");

    [[GtApplication sharedApplication] addEventInterceptor:self];
    self.dragWatcherIsRunning = YES;
}

- (void) stopDragWatcher
{
    if(self.dragWatcherIsRunning)
    {
        [[GtApplication sharedApplication] removeEventInterceptor:self];
        self.dragWatcherIsRunning = NO;
    }
}

- (void) dealloc
{
    [self stopDragWatcher];
    
    GtRelease(m_touchableView);
    GtRelease(m_dragDestinations);
    GtRelease(m_draggableObjects);
    GtSuperDealloc();
}

- (void) addDragResponder:(id) dragResponder
{
    if(!m_draggableObjects)
    {
        m_draggableObjects = [[NSMutableArray alloc] init];
    }
    
    GtAssert([m_draggableObjects indexOfObject:dragResponder] == NSNotFound, @"responder already installed");
    
    [m_draggableObjects addObject:dragResponder];
}


- (void) removeDragResponder:(id) dragResponder
{
    [m_draggableObjects removeObject:dragResponder];
}

- (void) addDragDestination:(id) destination 
{
    if(!m_dragDestinations)
    {
        m_dragDestinations = [[NSMutableArray alloc] init];
    }

    GtAssert([m_dragDestinations indexOfObject:destination] == NSNotFound, @"destination already installed");
    
    [m_dragDestinations addObject:destination];
}

- (UIView*) hostView
{
    return [m_delegate dragControllerGetHostView:self];
}

- (CGRect) touchableViewFrameInHostView
{   
    GtAssertNotNil(self.hostView);
    
    return [self.hostView convertRect:m_touchableView.frame fromView:m_touchableView.superview];
}

- (void) _didFinishTouching
{
    GtAssert(self.isDragging, @"not dragging");
    
    m_dragResults.amountMoved = GtPointSubtractPointFromPoint([self touchableViewFrameInHostView].origin, m_dragResults.startFrame.origin);
    self.dragging = NO;
    GtViewDraggerResults results = m_dragResults;
        
    for(id obj in m_draggableObjects)
    {
        if([obj respondsToSelector:@selector(draggerView:didFinishDraggingWithResults:)])
        {
            [obj dragController:self didFinishDraggingWithResults:results ];
        }
    }
    
    for(id destination in m_dragDestinations)
    {
        if([destination respondsToSelector:@selector(dragController:didFinishDraggingWithResults:)])
        {
            [destination dragController:self didFinishDraggingWithResults:results ];
        }
    }
    [self.touchableView dragController:self didFinishDraggingWithResults:results ];
    
    if([m_delegate respondsToSelector:@selector(dragController:didFinishDraggingWithResults:)])
    {
        [m_delegate dragController:self didFinishDraggingWithResults:results];
    }
}

- (void) _didBeginTouching
{
    GtAssertNotNil(self.hostView);
    GtAssert(!self.isDragging, @"dragging");
    self.dragging = YES;
    m_dragResults.touchOffset = CGPointZero;
    m_dragResults.userDidTouchView = NO;
    m_dragResults.didDragView = NO;
    m_dragResults.startFrame = [self touchableViewFrameInHostView];

    if([m_delegate respondsToSelector:@selector(dragControllerWillBeginDragging:)])
    {
        [m_delegate dragControllerWillBeginDragging:self];
    }    
    
    [self.touchableView dragControllerWillBeginDragging:self];
}

- (void) moveDragRespondersByAmount:(CGPoint) amount 
            animationDuration:(CGFloat) duration
            animationFinished:(GtBlock) animationFinished
{
    if(amount.x != 0 || amount.y != 0)
    {
        animationFinished = [[animationFinished copy] autorelease];
        [self _didBeginTouching];
        
        [UIView animateWithDuration:duration
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    for(id object in m_draggableObjects)
                    {
                        [object dragController:self dragViewByAmount: amount];
                    }
                } 
                completion:^(BOOL completed) {
                    m_dragResults.didDragView = YES;
                    m_dragResults.lastTouchInTouchableView = NO;
                    
                    [self _didFinishTouching];
                    if(animationFinished)
                    {
                        animationFinished();
                    }
                }
            ];
    }
    else if(animationFinished)
    {
        animationFinished();
    }

}


- (id) _intersectingDestination:(CGRect) frame
{
    for(id destination in m_dragDestinations)
    {
        if(CGRectIntersectsRect([destination frame], frame))
        {
            return destination;
        }
    }
    
    return nil;
}

#define distance(a,b) GtDistanceBetweenTwoPoints(a, b)

NS_INLINE
float dot(CGPoint a, CGPoint b)
{
    return (a.x * b.x) + (a.y * b.y);
}

NS_INLINE
CGPoint add(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

NS_INLINE
CGPoint subtract(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x - b.x, a.y - b.y);
}

NS_INLINE
float length_squared(CGPoint a, CGPoint b)
{
    return distance(a, b) * distance(a, b); 
}

NS_INLINE
CGPoint multiply(CGPoint a, CGPoint b)
{
    return CGPointMake(a.x * b.x, a.y * b.y);
}

// adapted from here: http://stackoverflow.com/questions/849211/shortest-distance-between-a-point-and-a-line-segment

float minimum_distance(CGPoint v, CGPoint w, CGPoint p) 
{
    // Return minimum distance between line segment vw and point p
    const float l2 = length_squared(v, w);  // i.e. |w-v|^2 -  avoid a sqrt
    
    if (l2 == 0.0) 
    {
        return distance(p, v);   // v == w case
    }
    
    // Consider the line extending the segment, parameterized as v + t (w - v).
    // We find projection of point p onto the line. 
    // It falls where t = [(p-v) . (w-v)] / |w-v|^2
    const float t =  dot(subtract(p, v), subtract(w, v)) / l2;   //dot(p - v, w - v) / l2;
    if (t < 0.0) 
    {
        return distance(p, v);       // Beyond the 'v' end of the segment
    }
    else if (t > 1.0) 
    {
        return distance(p, w);  // Beyond the 'w' end of the segment
    }

    CGPoint projection = multiply(CGPointMake(v.x + t, v.y + t), subtract(w, v)); // v + t * (w - v);  // Projection falls on the segment

    return distance(p, projection);
}

// TODO: move this with the other rect utils.

float GtMinDistanceToRectFromPoint(CGRect rect, CGPoint point)
{
    float min = minimum_distance(rect.origin, GtRectGetTopRight(rect), point);
    min = MIN(min, minimum_distance(GtRectGetTopRight(rect), GtRectGetBottomRight(rect), point));
    min = MIN(min, minimum_distance(GtRectGetBottomLeft(rect), GtRectGetBottomRight(rect), point));
    return MIN(min, minimum_distance(rect.origin, GtRectGetBottomLeft(rect), point));
}

float GtMinDistanceToRectFromRect(CGRect lhs, CGRect rhs)
{
    float min = GtMinDistanceToRectFromPoint(lhs, rhs.origin);
    min = MIN(min, GtMinDistanceToRectFromPoint(lhs, GtRectGetTopRight(rhs)));
    min = MIN(min, GtMinDistanceToRectFromPoint(lhs, GtRectGetBottomLeft(rhs)));
    return MIN(min, GtMinDistanceToRectFromPoint(lhs, GtRectGetBottomRight(rhs)));
}

- (id) _closestDestination:(CGRect) frame
{
    NSInteger closestIndex = 0;
    
    float closest = GtMinDistanceToRectFromRect([[m_dragDestinations objectAtIndex:0] frame], frame); // GtDistanceBetweenTwoPoints(touchPoint, GtRectGetCenter([[m_dragDestinations objectAtIndex:0] frame]));
    
    for(int i = 1; i < m_dragDestinations.count; i++)
    {
        float distance = GtMinDistanceToRectFromRect([[m_dragDestinations objectAtIndex:i] frame], frame); // GtDistanceBetweenTwoPoints(touchPoint, GtRectGetCenter([[m_dragDestinations objectAtIndex:i] frame]));
        
        if(distance < closest)
        {
            closest = distance;
            closestIndex = i;
        }   
    }
    
    return [m_dragDestinations objectAtIndex:closestIndex];
}

- (void) finishTouching:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(!m_dragDestinations || m_dragDestinations.count == 0)
    {
        goto done;
    }

    CGRect touchableRect = self.touchableViewFrameInHostView;
    
    id destination = [self _intersectingDestination:touchableRect];
    if(!destination)
    {
        destination = [self _closestDestination:touchableRect];
    }
    
    if(!destination) 
    {
        goto done;
    }
        
    UITouch* touch = touches.anyObject;
    CGRect destRect = [destination frame];
    
    m_dragResults.lastTouchInTouchableView = CGRectContainsPoint(touchableRect, [touch locationInView:self.hostView]);

    CGPoint delta = GtPointSubtractPointFromPoint(  destRect.origin, touchableRect.origin);

    if(fabs(delta.x) > 2.0f || fabs(delta.y) > 2.0f)
    {
        m_dragResults.didDragView = YES;
        
        [UIView animateWithDuration:0.2
                              delay:0.0f
                            options:UIViewAnimationOptionCurveEaseInOut
                         animations:^{
                             for(id obj in m_draggableObjects)
                             {
                                if([obj respondsToSelector:@selector(dragController:dragViewByAmount:)])
                                {
                                    [obj dragController:self dragViewByAmount:delta];
                                }
                             }
                             
                             if([destination respondsToSelector:@selector(dragControllerReceiveDrag:)])
                             {
                                [destination dragControllerReceiveDrag:self];
                             }
                            
                            // I don't think we want to notify destinations of automove
//                                for(id obj in m_dragDestinations)
//                                {
//                                    if([obj respondsToSelector:@selector(dragController:viewWasDraggedInHostView:)])
//                                    {
//                                        [obj dragController:self viewWasDraggedInHostView:self.hostView];
//                                    }
//                                }
                         } 
                         completion:^(BOOL completed) {
                             [self _didFinishTouching];
                         }
         ];

        return;
    }
    
done:
    [self _didFinishTouching];

}

- (void) _touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _didBeginTouching];

    UITouch* touch = [touches anyObject];
    m_dragResults.touchOffset = GtPointSubtractPointFromPoint(
        [touch locationInView:m_touchableView], 
        m_touchableView.bounds.origin);
    m_dragResults.userDidTouchView = YES;
    m_dragLimit = [m_delegate dragControllerCalculateDragBoundsInHostView:self];
    
    // this sets up current drag destination rects.
    for(id destination in m_dragDestinations)
    {
        if([destination respondsToSelector:@selector(dragControllerUpdateFrame:)])
        {
            [destination dragControllerUpdateFrame:self];
        }
    }
}

- (void) _touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch* touch = [touches anyObject];
    UIView* hostView = self.hostView;
    CGPoint touchPoint = [touch locationInView:hostView];
    
    CGRect frame = self.touchableViewFrameInHostView; 
    m_dragResults.lastTouchInTouchableView = CGRectContainsPoint(frame, touchPoint);
    
    CGRect newFrame = frame;
    newFrame.origin.x = touchPoint.x - m_dragResults.touchOffset.x;
    newFrame.origin.y = touchPoint.y - m_dragResults.touchOffset.y;
    
    CGRect dragLimit = m_dragLimit; // [hostView convertRect:m_dragLimit fromView:hostView];

    if(dragLimit.size.width > frame.size.width)
    {
        if(newFrame.origin.x < dragLimit.origin.x)
        {
            newFrame.origin.x = dragLimit.origin.x;
        }
        else if(GtRectGetRight(newFrame) > GtRectGetRight(dragLimit))
        {
            newFrame.origin.x = GtRectGetRight(dragLimit) - newFrame.size.width;
        }
    }
    else
    {
        newFrame.origin.x = frame.origin.x;
    }
    
    if(dragLimit.size.height > frame.size.height)
    {
        if(newFrame.origin.y < dragLimit.origin.y)
        {
            newFrame.origin.y = dragLimit.origin.y;
        }
        else if(GtRectGetBottom(newFrame) > GtRectGetBottom(dragLimit))
        {
            newFrame.origin.y = GtRectGetBottom(dragLimit) - frame.size.height;
        }
    }
    else
    {
        newFrame.origin.y = frame.origin.y;
    }
    
    CGPoint delta = GtPointSubtractPointFromPoint(newFrame.origin, frame.origin); 
        
    if(delta.x != 0 || delta.y != 0)
    {
        for(id obj in m_draggableObjects)
        {
            if([obj respondsToSelector:@selector(dragController:dragViewByAmount:)])
            {
                [obj dragController:self dragViewByAmount:delta];
            }
        }
        
        for(id destination in m_dragDestinations)
        {
            if([destination respondsToSelector:@selector(dragControllerDidDragViews:)])
            {
                [destination dragControllerDidDragViews:self];
            }
        }
        
        m_dragResults.didDragView = YES;
    }
    
}

- (void) _touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self finishTouching:touches withEvent:event];
}

- (void) _touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self finishTouching:touches withEvent:event];
}

- (BOOL) _isOurView:(UIView*) aView
{
    return [aView isDescendantOfView:m_touchableView];
}

- (BOOL) handleInternalTouches:(NSSet*) touches event:(UIEvent*) event
{
    UITouch* touch = [touches anyObject];
    switch(touch.phase)
    {
        case UITouchPhaseBegan:
            [self _touchesBegan:touches withEvent:event];
        break;
                                    
        case UITouchPhaseStationary:
        case UITouchPhaseMoved:
            [self _touchesMoved:touches withEvent:event];
        break;
        
        case UITouchPhaseCancelled:
            [self _touchesCancelled:touches withEvent:event];
        break;
        
        case UITouchPhaseEnded:
            [self _touchesEnded:touches withEvent:event];
        break;
    }
    
    if([m_delegate respondsToSelector:@selector(dragController:didInterceptInternalTouches:event:)])
    {
        return [m_delegate dragController:self didInterceptInternalTouches:touches event:event];
    }
    
    return NO;
}

- (BOOL) handleExternalTouches:(NSSet*) touches event:(UIEvent*) event
{
    if([m_delegate respondsToSelector:@selector(dragController:didInterceptExternalTouches:event:)])
    {
        return [m_delegate dragController:self didInterceptExternalTouches:touches event:event];
    }

    return NO;
}

- (BOOL) didInterceptEvent:(UIEvent*) event
{
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
        UITouch* touch = [touches anyObject];

        if( touch.phase == UITouchPhaseBegan)
        {
            m_flags.touchIsForUs = [self _isOurView:touch.view];
        }
     
        if(m_flags.touchIsForUs)
        {
            return [self handleInternalTouches:touches event:event];
        }
        else
        {
            return [self handleExternalTouches:touches event:event];
        }
    }

    return NO;
}

@end

@implementation GtDragControllerDragDestination

@synthesize frame = m_frame;
@synthesize setFrameCallback = m_setFrameCallback;

- (id) initWithSetFrameCallback:(GtCallback) callback
{
    if((self = [self init]))
    {
        self.setFrameCallback = callback;
    }
    
    return self;
}

+ (GtDragControllerDragDestination*) dragDestination
{
    return GtReturnAutoreleased([[[self class] alloc] init]);
}

+ (GtDragControllerDragDestination*) dragDestination:(GtCallback) callback
{
    return GtReturnAutoreleased([[[self class] alloc] initWithSetFrameCallback:callback]);
}

- (void) dragControllerUpdateFrame:(GtDragController*) manager
{
    GtInvokeCallback(m_setFrameCallback, self);
}


@end

@implementation UIView (GtDragController)

- (void) dragController:(GtDragController*) controller 
    dragViewByAmount:(CGPoint) amount
{
    self.frameOptimizedForLocation = GtRectMoveWithPoint(self.frame, amount);
}

- (void) dragControllerWillBeginDragging:(GtDragController*) manager 
{

}

- (void) dragController:(GtDragController*) controller 
didFinishDraggingWithResults:(GtViewDraggerResults) results 
{

}

@end

@implementation UIViewController (GtDragController)

- (void) dragController:(GtDragController*) controller 
    dragViewByAmount:(CGPoint) amount 
{
    self.view.frameOptimizedForLocation = GtRectMoveWithPoint(self.view.frame, amount);
}

@end
