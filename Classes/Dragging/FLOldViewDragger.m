//
//  FLViewDragger.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLOldViewDragger.h"
//#import "FLView.h"

@implementation FLOldViewDragger

@synthesize window = _window;

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}

- (void) dealloc
{
    [[FLApplication sharedApplication] removeEventInterceptor:self];
    FLRelease(_item);
    FLSuperDealloc();
}

- (BOOL) isWatchingTouches
{
    return _window != nil;
}

+ (FLOldViewDragger*) viewDragger
{
    return FLReturnAutoreleased([[FLOldViewDragger alloc] init]);
}

- (void) beginWatchingTouchesForDraggableItem:(id<FLDraggableItem>) item
{
    [self stopWatchingTouches];

    FLAssertIsNotNil(item.touchableView);
    FLAssertIsNotNil(item.touchableView.window);
    _item = FLReturnRetained(item);

   [[FLApplication sharedApplication] addEventInterceptor:self];
}

- (void) stopWatchingTouches
{
    [[FLApplication sharedApplication] removeEventInterceptor:self];
    FLReleaseWithNil(_item);
}

- (CGPoint) pointInView:(CGPoint) windowCoordinatePoint
{
    return [_window convertPoint:windowCoordinatePoint toView:_item.touchableView];
}

- (BOOL) _isOurView:(UIView*) aView
{
    if( [aView isDescendantOfView:_item.touchableView])
    {
        return YES;
    }
    
    return NO;
}

/*
- (void) _didEndDrag:(FLViewDraggerDragInfo) drag
{
    NSArray* frames = [_item dragDestinations];
    
    if(frames && frames.count)
    {
        CGPoint center = FLRectGetCenter(drag.frame);
        
        NSInteger closestIndex = 0;
        
        float closest = FLDistanceBetweenTwoPoints(center, FLRectGetCenter([[frames objectAtIndex:0] rectValue]));
        
        for(int i = 1; i < frames.count; i++)
        {
            float distance = FLDistanceBetweenTwoPoints(center, FLRectGetCenter([[frames objectAtIndex:i] rectValue]));
            
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
                [_item viewDragger:self dragWillMove:drag];
            } 
            completion:^(BOOL completed) {
                [_item viewDragger:self dragDidFinish:drag];
            }
        ];
    }
    else
    {
        [_item viewDragger:self dragWillMove:drag];
            
        [_item viewDragger:self dragDidFinish:drag];
    }
}                       


- (BOOL) windowWillSendEvent:(FLWindow*) window event:(UIEvent*) event
{
	if(event.type == UIEventTypeTouches)
	{
		NSSet* touches = [event allTouches];
		UITouch* touch = [touches anyObject];

        if(touch.phase == UITouchPhaseBegan)
		{
            _touchIsInside = [self _isOurView:touch.view];
            if(_touchIsInside)
            {
                _firstTouch = [touch locationInView:_window];
                _lastTouch = _firstTouch;
                [_item viewDraggerDragWillBegin:self];
            }
        }
         
        if(_touchIsInside)
        {     
            FLViewDraggerDragInfo drag;
            drag.currentTouch = [touch locationInView:_window];
            drag.previousTouch = _lastTouch;
            drag.firstTouch = _firstTouch;
            
            CGRect frame = _item.frame;
            
            CGRect newFrame = FLRectMoveWithPoint(frame, FLPointSubtractPointFromPoint(drag.currentTouch, _lastTouch));
            
            CGRect limit = _item.dragLimit;

            if(limit.size.width > frame.size.width)
            {
                if(newFrame.origin.x < limit.origin.x)
                {
                    newFrame.origin.x = limit.origin.x;
                }
                if(FLRectGetRight(newFrame) > FLRectGetRight(limit))
                {
                    newFrame.origin.x = FLRectGetRight(limit) - newFrame.size.width;
                }
            
                frame.origin.x = newFrame.origin.x;
            }
            
            if(limit.size.height > frame.size.height)
            {
                if(newFrame.origin.y < limit.origin.y)
                {
                    newFrame.origin.y = limit.origin.y;
                }
                if(FLRectGetBottom(newFrame) > FLRectGetBottom(limit))
                {
                    newFrame.origin.y = FLRectGetBottom(limit) - frame.size.height;
                }
                
                frame.origin.y = newFrame.origin.y;
            }
            drag.currentDelta = FLPointSubtractPointFromPoint(newFrame.origin, frame.origin);
            
            drag.frame = frame;
        
            switch(touch.phase)
            {
                case UITouchPhaseBegan:
                break;
                                            
                case UITouchPhaseStationary:
                case UITouchPhaseMoved:
                    [_item viewDragger:self dragWillMove:drag];
                break;
                
                case UITouchPhaseCancelled:
                case UITouchPhaseEnded:
                    [self _didEndDrag:drag];
                break;
            }
            
            _lastTouch = drag.currentTouch;
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
            _touchIsInside = [self _isOurView:touch.view];
            if(_touchIsInside)
            {
                _firstTouch = [touch locationInView:_window];
                _lastTouch = _firstTouch;
                [_item viewDraggerDragWillBegin:self];
            }
        }
         
        if(_touchIsInside)
        {     
            FLViewDraggerDragInfo drag;
            drag.currentTouch = [touch locationInView:_window];
            drag.previousTouch = _lastTouch;
            drag.firstTouch = _firstTouch;
            
            CGRect frame = _item.frame;
            
            CGRect newFrame = FLRectMoveWithPoint(frame, FLPointSubtractPointFromPoint(drag.currentTouch, _lastTouch));
            
            CGRect limit = _item.dragLimit;

            if(limit.size.width > frame.size.width)
            {
                if(newFrame.origin.x < limit.origin.x)
                {
                    newFrame.origin.x = limit.origin.x;
                }
                if(FLRectGetRight(newFrame) > FLRectGetRight(limit))
                {
                    newFrame.origin.x = FLRectGetRight(limit) - newFrame.size.width;
                }
            
                frame.origin.x = newFrame.origin.x;
            }
            
            if(limit.size.height > frame.size.height)
            {
                if(newFrame.origin.y < limit.origin.y)
                {
                    newFrame.origin.y = limit.origin.y;
                }
                if(FLRectGetBottom(newFrame) > FLRectGetBottom(limit))
                {
                    newFrame.origin.y = FLRectGetBottom(limit) - frame.size.height;
                }
                
                frame.origin.y = newFrame.origin.y;
            }
            drag.currentDelta = FLPointSubtractPointFromPoint(newFrame.origin, frame.origin);
            
            drag.frame = frame;
        
            switch(touch.phase)
            {
                case UITouchPhaseBegan:
                break;
                                            
                case UITouchPhaseStationary:
                case UITouchPhaseMoved:
                    [_item viewDragger:self dragWillMove:drag];
                break;
                
                case UITouchPhaseCancelled:
                case UITouchPhaseEnded:
//                    [self _didEndDrag:drag];
                break;
            }
            
            _lastTouch = drag.currentTouch;
        }
    }

    return YES;
}



@end
