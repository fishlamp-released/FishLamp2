//
//  FLDragController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/28/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDragController.h"
#import "FLApplication.h"
#import "FLExternalTouchViewCloser.h"

@interface FLDragController ()
@property (readwrite, assign, nonatomic) UIView* touchedView;
@end

@implementation FLDragController 


FLSynthesizeStructProperty(isDragging, setDragging, BOOL, _flags);
FLSynthesizeStructProperty(dragWatcherIsRunning, setDragWatcherIsRunning, BOOL, _flags);

@synthesize touchableView = _touchableView;
@synthesize delegate = _delegate;
@synthesize secondaryTouchableViews = _secondaryViews;
@synthesize touchedView = _touchedView;

- (id) init
{
    if((self = [super init]))
    {
    }

    return self;
}

+ (id) dragController
{
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) startDragWatcher
{
    [self stopDragWatcher];

//    FLAssertIsNotNil([FLWindow topWindow]);
//    FLAssertWithComment([[FLWindow topWindow] isKindOfClass:[FLWindow class]], @"not a gtwindow");

    [[FLApplication sharedApplication] addEventInterceptor:self];
    self.dragWatcherIsRunning = YES;
}

- (void) stopDragWatcher
{
    if(self.dragWatcherIsRunning)
    {
        [[FLApplication sharedApplication] removeEventInterceptor:self];
        self.dragWatcherIsRunning = NO;
    }
}

- (void) dealloc
{
    [self stopDragWatcher];
    
    FLRelease(_secondaryViews);
    FLRelease(_touchableView);
    FLRelease(_dragDestinations);
    FLRelease(_draggableObjects);
    FLSuperDealloc();
}

- (void) addSecondaryTouchableView:(UIView*) view
{
    if(!_secondaryViews)
    {
        _secondaryViews = [[NSMutableArray alloc] init];
    }
    
    [_secondaryViews addObject:view];
}

- (void) addDragResponder:(id) dragResponder
{
    if(!_draggableObjects)
    {
        _draggableObjects = [[NSMutableArray alloc] init];
    }
    
    FLAssertWithComment([_draggableObjects indexOfObject:dragResponder] == NSNotFound, @"responder already installed");
    
    [_draggableObjects addObject:dragResponder];
}


- (void) removeDragResponder:(id) dragResponder
{
    [_draggableObjects removeObject:dragResponder];
}

- (void) addDragDestination:(id) destination 
{
    if(!_dragDestinations)
    {
        _dragDestinations = [[NSMutableArray alloc] init];
    }

    FLAssertWithComment([_dragDestinations indexOfObject:destination] == NSNotFound, @"destination already installed");
    
    [_dragDestinations addObject:destination];
}

- (UIView*) hostView
{
    return [_delegate dragControllerGetHostView:self];
}

- (CGRect) touchableViewFrameInHostView
{   
    FLAssertIsNotNil(self.hostView);
    
    return [self.hostView convertRect:_touchableView.frame fromView:_touchableView.superview];
}

- (CGRect) viewFrameInHostView:(UIView*) view
{
    FLAssertIsNotNil(self.hostView);
    
    return [self.hostView convertRect:view.frame fromView:view.superview];
}

- (void) _didFinishTouching
{
    FLAssertWithComment(self.isDragging, @"not dragging");
    
    _dragResults.amountMoved = FLPointSubtractPointFromPoint([self touchableViewFrameInHostView].origin, _dragResults.startFrame.origin);
    self.dragging = NO;
    FLViewDraggerResults results = _dragResults;
        
    for(id obj in _draggableObjects)
    {
        if([obj respondsToSelector:@selector(dragController:didFinishDraggingWithResults:)])
        {
            [obj dragController:self didFinishDraggingWithResults:results ];
        }
    }
    
    for(id destination in _dragDestinations)
    {
        if([destination respondsToSelector:@selector(dragController:didFinishDraggingWithResults:)])
        {
            [destination dragController:self didFinishDraggingWithResults:results ];
        }
    }
    [self.touchableView dragController:self didFinishDraggingWithResults:results ];
    
    if([_delegate respondsToSelector:@selector(dragController:didFinishDraggingWithResults:)])
    {
        [_delegate dragController:self didFinishDraggingWithResults:results];
    }
}

- (void) _didBeginTouching
{
    FLAssertIsNotNil(self.hostView);
    FLAssertWithComment(!self.isDragging, @"dragging");
    self.dragging = YES;
    _dragResults.touchOffset = CGPointZero;
    _dragResults.userDidTouchView = NO;
    _dragResults.didDragView = NO;
    _dragResults.startFrame = [self touchableViewFrameInHostView];

    if([_delegate respondsToSelector:@selector(dragControllerWillBeginDragging:)])
    {
        [_delegate dragControllerWillBeginDragging:self];
    }    
    
    [self.touchableView dragControllerWillBeginDragging:self];
}

- (void) moveDragRespondersByAmount:(CGPoint) amount 
            animationDuration:(CGFloat) duration
            animationFinished:(dispatch_block_t) animationFinished
{
    if(amount.x != 0.0f || amount.y != 0.0f)
    {
        animationFinished = FLAutorelease([animationFinished copy]);
        [self _didBeginTouching];
        
        [UIView animateWithDuration:duration
                delay:0.0f
                options:UIViewAnimationOptionCurveEaseInOut
                animations:^{
                    for(id object in _draggableObjects)
                    {
                        [object dragController:self dragViewByAmount: amount];
                    }
                } 
                completion:^(BOOL completed) {
                    _dragResults.didDragView = YES;
                    _dragResults.lastTouchInTouchableView = NO;
                    
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
    for(id destination in _dragDestinations)
    {
        if(CGRectIntersectsRect([destination frame], frame))
        {
            return destination;
        }
    }
    
    return nil;
}

#define distance(a,b) FLDistanceBetweenTwoPoints(a, b)

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

float FLMinDistanceToRectFromPoint(CGRect rect, CGPoint point)
{
    float min = minimum_distance(rect.origin, FLRectGetTopRight(rect), point);
    min = MIN(min, minimum_distance(FLRectGetTopRight(rect), FLRectGetBottomRight(rect), point));
    min = MIN(min, minimum_distance(FLRectGetBottomLeft(rect), FLRectGetBottomRight(rect), point));
    return MIN(min, minimum_distance(rect.origin, FLRectGetBottomLeft(rect), point));
}

float FLMinDistanceToRectFromRect(CGRect lhs, CGRect rhs)
{
    float min = FLMinDistanceToRectFromPoint(lhs, rhs.origin);
    min = MIN(min, FLMinDistanceToRectFromPoint(lhs, FLRectGetTopRight(rhs)));
    min = MIN(min, FLMinDistanceToRectFromPoint(lhs, FLRectGetBottomLeft(rhs)));
    return MIN(min, FLMinDistanceToRectFromPoint(lhs, FLRectGetBottomRight(rhs)));
}

- (id) _closestDestination:(CGRect) frame
{
    NSInteger closestIndex = 0;
    
    float closest = FLMinDistanceToRectFromRect([[_dragDestinations objectAtIndex:0] frame], frame); // FLDistanceBetweenTwoPoints(touchPoint, FLRectGetCenter([[_dragDestinations objectAtIndex:0] frame]));
    
    for(int i = 1; i < _dragDestinations.count; i++)
    {
        float distance = FLMinDistanceToRectFromRect([[_dragDestinations objectAtIndex:i] frame], frame); // FLDistanceBetweenTwoPoints(touchPoint, FLRectGetCenter([[_dragDestinations objectAtIndex:i] frame]));
        
        if(distance < closest)
        {
            closest = distance;
            closestIndex = i;
        }   
    }
    
    return [_dragDestinations objectAtIndex:closestIndex];
}

- (void) finishTouching:(NSSet *)touches withEvent:(UIEvent *)event
{
    if(_dragDestinations && _dragDestinations.count > 0) {

        CGRect touchableRect = self.touchableViewFrameInHostView;
        
        id destination = [self _intersectingDestination:touchableRect];
        if(!destination) {
            destination = [self _closestDestination:touchableRect];
        }
        
        if(destination) {

            UITouch* touch = touches.anyObject;
            CGRect destRect = [destination frame];
            
            CGPoint touchPt = [touch locationInView:self.hostView];
            _dragResults.lastTouchInTouchableView = CGRectContainsPoint(touchableRect, touchPt);
            if(!_dragResults.lastTouchInTouchableView)
            {
                for(UIView* view in _secondaryViews)
                {
                    if(CGRectContainsPoint([self viewFrameInHostView:view], touchPt))
                    {
                        _dragResults.lastTouchInTouchableView = YES;
                    }
                }
            }

            CGPoint delta = FLPointSubtractPointFromPoint(  destRect.origin, touchableRect.origin);

            if(fabs(delta.x) > 2.0f || fabs(delta.y) > 2.0f)
            {
                _dragResults.didDragView = YES;
                
                [UIView animateWithDuration:0.2
                                      delay:0.0f
                                    options:UIViewAnimationOptionCurveEaseInOut
                                 animations:^{
                                     for(id obj in _draggableObjects)
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
                                    
                                    // I don't think we want to handleNotification destinations of automove
        //                                for(id obj in _dragDestinations)
        //                                {
        //                                    if([obj respondsToSelector:@selector(dragController:viewWasDraggedInHostView:)])
        //                                    {
        //                                        [obj dragController:self viewWasDraggedInHostView:self.hostView];
        //                                    }
        //                                }
                                 } 
                                 completion:^(BOOL completed) {
                                    [self _didFinishTouching];
                                    self.touchedView = nil;
                                 }
                 ];

                return;
            }
        }
    }
    

    [self _didFinishTouching];
    self.touchedView = nil;

}

- (void) _touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self _didBeginTouching];

    UITouch* touch = [touches anyObject];
    _dragResults.touchOffset = FLPointSubtractPointFromPoint(
        [touch locationInView:_touchableView], 
        _touchableView.bounds.origin);
    _dragResults.userDidTouchView = YES;
    _dragLimit = [_delegate dragControllerCalculateDragBoundsInHostView:self];
    
    // this sets up current drag destination rects.
    for(id destination in _dragDestinations)
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
    _dragResults.lastTouchInTouchableView = CGRectContainsPoint(frame, touchPoint);
    
    CGRect newFrame = frame;
    newFrame.origin.x = touchPoint.x - _dragResults.touchOffset.x;
    newFrame.origin.y = touchPoint.y - _dragResults.touchOffset.y;
    
    CGRect dragLimit = _dragLimit; // [hostView convertRect:_dragLimit fromView:hostView];

    if(dragLimit.size.width > frame.size.width)
    {
        if(newFrame.origin.x < dragLimit.origin.x)
        {
            newFrame.origin.x = dragLimit.origin.x;
        }
        else if(FLRectGetRight(newFrame) > FLRectGetRight(dragLimit))
        {
            newFrame.origin.x = FLRectGetRight(dragLimit) - newFrame.size.width;
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
        else if(FLRectGetBottom(newFrame) > FLRectGetBottom(dragLimit))
        {
            newFrame.origin.y = FLRectGetBottom(dragLimit) - frame.size.height;
        }
    }
    else
    {
        newFrame.origin.y = frame.origin.y;
    }
    
    CGPoint delta = FLPointSubtractPointFromPoint(newFrame.origin, frame.origin); 
        
    if(delta.x != 0.0f || delta.y != 0.0f)
    {
        for(id obj in _draggableObjects)
        {
            if([obj respondsToSelector:@selector(dragController:dragViewByAmount:)])
            {
                [obj dragController:self dragViewByAmount:delta];
            }
        }
        
        for(id destination in _dragDestinations)
        {
            if([destination respondsToSelector:@selector(dragControllerDidDragViews:)])
            {
                [destination dragControllerDidDragViews:self];
            }
        }
        
        _dragResults.didDragView = YES;
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
    if( [aView isDescendantOfView:_touchableView] ) 
    {
        self.touchedView = _touchableView;
        return YES;
    }
    
    for(UIView* view in _secondaryViews)
    {
        if( [aView isDescendantOfView:view])
        {
            self.touchedView = view;
            return YES;
        }
    }
    
    return NO;
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
    
    if([_delegate respondsToSelector:@selector(dragController:didInterceptInternalTouches:event:)])
    {
        return [_delegate dragController:self didInterceptInternalTouches:touches event:event];
    }
    
    return NO;
}

- (BOOL) handleExternalTouches:(NSSet*) touches event:(UIEvent*) event
{
    if([_delegate respondsToSelector:@selector(dragController:didInterceptExternalTouches:event:)])
    {
        return [_delegate dragController:self didInterceptExternalTouches:touches event:event];
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
            _flags.touchIsForUs = [self _isOurView:touch.view];
        }
     
        if(_flags.touchIsForUs)
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

@implementation FLDragControllerDragDestination

@synthesize frame = _frame;
@synthesize setFrameCallback = _setFrameCallback;

- (id) initWithSetFrameCallback:(FLCallback_t) callback
{
    if((self = [self init]))
    {
        self.setFrameCallback = callback;
    }
    
    return self;
}

+ (FLDragControllerDragDestination*) dragDestination
{
    return FLAutorelease([[[self class] alloc] init]);
}

+ (FLDragControllerDragDestination*) dragDestination:(FLCallback_t) callback
{
    return FLAutorelease([[[self class] alloc] initWithSetFrameCallback:callback]);
}

- (void) dragControllerUpdateFrame:(FLDragController*) manager
{
    FLInvokeCallback(_setFrameCallback, self);
}


@end

@implementation UIView (FLDragController)

- (void) dragController:(FLDragController*) controller 
    dragViewByAmount:(CGPoint) amount
{
    self.frameOptimizedForLocation = FLRectMoveWithPoint(self.frame, amount);
}

- (void) dragControllerWillBeginDragging:(FLDragController*) manager 
{

}

- (void) dragController:(FLDragController*) controller 
didFinishDraggingWithResults:(FLViewDraggerResults) results 
{

}

@end

@implementation UIViewController (FLDragController)

- (void) dragController:(FLDragController*) controller 
    dragViewByAmount:(CGPoint) amount 
{
    self.view.frameOptimizedForLocation = FLRectMoveWithPoint(self.view.frame, amount);
}

@end
