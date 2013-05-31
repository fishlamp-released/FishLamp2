//
//  FLTouchHandler.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTouchHandler.h"
#import "FLApplication.h"
#define kTouchHighlightDelay 0.15f

@implementation FLTouchHandler 

@synthesize onSelected = _wasSelectedCallback;
@synthesize touchableObject = _touchableObject;
@synthesize disabled = _disabled;

static id s_touchedObject = nil;

+ (id) touchedObject {
    return s_touchedObject;
}

- (id) init {
    if((self = [super init])) {
    }
    
    return self;
}

- (void) dealloc {
    [self stopInterceptingGlobalTouches];
    
    FLRelease(_wasSelectedCallback);
	FLSuperDealloc();
}

- (BOOL) gotTouchDown {
    return self.touchableObject == s_touchedObject;
}

- (void) beginInterceptingGlobalTouches {
    [[FLApplication sharedApplication] addEventInterceptor:self];
}

- (void) stopInterceptingGlobalTouches {
	[[FLApplication sharedApplication] removeEventInterceptor:self];
}

- (BOOL) _isOurView:(UIView*) aView {
    if([self.touchableObject view] == aView) {
        return YES;
    }
    return NO;
}

- (BOOL) isOurTouch:(NSSet*) touches {
    if( [self.touchableObject isDisabled] || 
            [self.touchableObject isHidden] || 
            CGRectEqualToRect([self.touchableObject frame], CGRectZero)) {
        return NO;
    }

    UITouch* touch = [touches anyObject];
	UIView* hitView = touch.view;

    return [self _isOurView:hitView] && 
                CGRectContainsPoint([self.touchableObject frame], [touch locationInView:hitView]);

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if([self isOurTouch:touches]) {
        s_touchedObject = self.touchableObject;
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.gotTouchDown) {
        s_touchedObject = nil;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if(self.gotTouchDown) {
        s_touchedObject = nil;
    }
}

- (BOOL) didInterceptEvent:(UIEvent*) event {
	if( event.type == UIEventTypeTouches) {
        FLAssertIsNotNil([self.touchableObject view]);
       
        NSSet* touches = event.allTouches;
        UITouch* touch = [touches anyObject];
	   
        if(touch.phase == UITouchPhaseBegan && [self isOurTouch:touches]) {
            [self touchesBegan:touches withEvent:event];
        }
         
        if(s_touchedObject == self.touchableObject) {
            switch(touch.phase) {
                case UITouchPhaseBegan:
                    break;
                
                case UITouchPhaseMoved:
                    [self touchesMoved:touches withEvent:event];
                    break;
                    
                case UITouchPhaseEnded:
                    [self touchesEnded:touches withEvent:event];
                break;
                    
                case UITouchPhaseCancelled:
                     [self touchesCancelled:touches withEvent:event];
                break;
                
                case UITouchPhaseStationary: 
                break;
            }
        }
    }

	return NO;
}

@end

@implementation FLSelectOnTouchDownHandler

+ (FLSelectOnTouchDownHandler*) selectOnTouchDownHandler {
    return FLAutorelease([[FLSelectOnTouchDownHandler alloc] init]);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];

    if(self.gotTouchDown) {
        [self.touchableObject setSelected:YES];
        if(self.onSelected) {
            self.onSelected(self.touchableObject);
        }
    }
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesCancelled:touches withEvent:event];
}
@end

@interface FLSelectOnTouchUpHandler ()
- (void) resetTouchState;
@end

@implementation FLSelectOnTouchUpHandler

@synthesize touchDownCallback = _touchDown;
@synthesize touchUpInsideCallback = _touchUpInside;
@synthesize touchEnteredCallback = _touchEntered;
@synthesize touchExitedCallback = _touchExited;
@synthesize touchesEndedCallback = _touchesEnded;

FLSynthesizeStructProperty(highlightOnTouch, setHighlightOnTouch, BOOL, _state);
FLSynthesizeStructProperty(touchDidEnter, setTouchDidEnter, BOOL, _state);
FLSynthesizeStructProperty(didChangeStateOnTouch, setDidChangeStateOnTouch, BOOL, _state);
FLSynthesizeStructProperty(exclusiveTouchMode, setExclusiveTouchMode, BOOL, _state);

static id s_lastEnteredObject = nil;

+ (id) lastEnteredObject {
    return s_lastEnteredObject;
}

- (id) init {
    if((self = [super init])) {
        self.exclusiveTouchMode = YES;
		self.highlightOnTouch = YES;
    }
    
    return self;
}

+ (FLSelectOnTouchUpHandler*) selectOnTouchUpHandler {
    return FLAutorelease([[FLSelectOnTouchUpHandler alloc] init]);
}

- (BOOL) isTouching {
	return _state.isTouching;
}

- (void) _touchesDidEndWithMiss {
	if(![self.touchableObject isDisabled]) {
        if(_state.highlightOnTouch) {
            [self.touchableObject setHighlighted:NO];
        }
        
        FLInvokeCallback(self.touchesEndedCallback, self);
        [self.touchableObject setSelected:NO];
    }

	[self resetTouchState];
	s_lastEnteredObject = nil;
}

- (void) _touchesDidEndWithHit {
	if(![self.touchableObject isDisabled]) {
        FLInvokeCallback(self.touchUpInsideCallback, self);
        FLInvokeCallback(self.touchesEndedCallback, self);
        
        if(_state.highlightOnTouch) {
            [self.touchableObject setHighlighted:NO];
        }
        
        [self.touchableObject setSelected:YES];
        if(self.onSelected) {
            self.onSelected(self.touchableObject);
        }

    }
	[self resetTouchState];
	s_lastEnteredObject = nil;
}

- (void) touchEventReceiverResetTouchState {
	_state.gotFirstTouch = NO;
	_startTap = 0;
	_state.isTouching = NO;
	_state.lastTouchWasInside = NO;
}

- (void) resetTouchState {
	_state.isTouching = NO;
	_state.didChangeStateOnTouch = NO;
	_state.touchDidEnter = NO;
	_state.gotFirstTouch = NO;
	_startTap = 0;
	_state.lastTouchWasInside = NO;
}


#define kStartDelay 0.15
- (void) touchesMoved:(NSSet*) touches withEvent:(UIEvent*) event {
    [super touchesMoved:touches withEvent:event];

    if(self.gotTouchDown) {
        FLAssertIsNotNil([self.touchableObject view]);
        UITouch* touch = [touches anyObject];
            
        BOOL touchIsInside = CGRectContainsPoint([self.touchableObject frame], [touch locationInView:[self.touchableObject view]]);

        if(touchIsInside && !_state.isTouching) {
            _state.isTouching = YES;
        }
        
        if(_state.isTouching && _state.lastTouchWasInside != touchIsInside) {
            if(touchIsInside){
                FLInvokeCallback(self.touchEnteredCallback, self);
                s_lastEnteredObject = self;
                _state.touchDidEnter = YES;
            }
            else {
                FLInvokeCallback(self.touchExitedCallback, self);
            }

            if(_state.highlightOnTouch) {
                [self.touchableObject setHighlighted:touchIsInside];
            }
            
            _state.lastTouchWasInside = touchIsInside;
        }
    }
}


- (void) touchesEnded:(NSSet*) touches withEvent:(UIEvent*) event {

    FLAssertIsNotNil([self.touchableObject view]);
	
//	if(_state.gotFirstTouch || _state.isTouching)
    
    if(self.gotTouchDown) {
        UITouch* touch = [touches anyObject];
		CGPoint point = [touch locationInView:[self.touchableObject view]];
			
		NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - _startTap;
		
        if(_state.highlightOnTouch && delay < kTouchHighlightDelay) {
			if(CGRectContainsPoint([self.touchableObject frame], point)) {
				[self performSelector:@selector(_touchesDidEndWithHit) 
						   withObject:nil afterDelay:kTouchHighlightDelay - delay];
			}
			else {
				[self performSelector:@selector(_touchesDidEndWithMiss) 
						   withObject:nil afterDelay:kTouchHighlightDelay - delay];
			}
		}
		else {
			if(CGRectContainsPoint([self.touchableObject frame], point)) {
				[self _touchesDidEndWithHit];
			}
			else {
				[self _touchesDidEndWithMiss];
			}
		}
	}
    
    [super touchesEnded:touches withEvent:event];
}

- (void) touchesCancelled:(NSSet*) touches withEvent:(UIEvent*) event {
    if(self.gotTouchDown) {
        if(_state.gotFirstTouch || _state.isTouching) {
            NSTimeInterval delay = [NSDate timeIntervalSinceReferenceDate] - _startTap;
            if(_state.highlightOnTouch && delay < kTouchHighlightDelay) {
                [self performSelector:@selector(_touchesDidEndWithMiss) 
                               withObject:nil afterDelay:delay];
            }
            else {
                [self _touchesDidEndWithMiss];
            }
        }
        [self resetTouchState];

        s_lastEnteredObject = nil;
    }
    [super touchesCancelled:touches withEvent:event];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    if(self.gotTouchDown) {
        [self resetTouchState];
        
        _state.gotFirstTouch = YES;
        _startTap = [NSDate timeIntervalSinceReferenceDate];
        _state.isTouching = YES;
        _state.lastTouchWasInside = YES;			
        _state.touchDidEnter = YES;

        FLInvokeCallback(self.touchDownCallback, self);

        if(_state.highlightOnTouch) {
            [self.touchableObject setHighlighted:YES];
        }
    }
}

//- (void) handleTouches:(NSSet*) touches forEvent:(UIEvent*) event
//{
//    UITouch* touch = [touches anyObject];
//    
//    if(touch.phase == UITouchPhaseBegan)
//    {
//        if( [self isOurTouch:touch])
//        {
//        }
//    }
//     
//
//		
////        else if(/*_firstTouchReceiver &&*/ touch.phase != UITouchPhaseStationary)
////		{
////			if(!_didBegin)
////			{
////				CGFloat distance = FLDistanceBetweenTwoPoints([touch.view convertPoint:_firstTouch.touch fromView:_firstTouch.view], [touch locationInView:touch.view]);
////				
//////					  FLLog(@"distance: %f", distance);
////				
////				if(distance > 10.f)
////				{
//////					FLLog(@"cancelled, distance is too high");
////
////					// this means we're starting scrolling?
////
////					_didBegin = YES;
////					_canStartTouches = NO;
////					[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendStartTouch) object:nil];
//////					[self _sendStartTouch];
////				}
////				else if(touch.phase == UITouchPhaseCancelled || touch.phase == UITouchPhaseEnded)
////				{
//////					FLLog(@"quick tap");
////
////					[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(_sendStartTouch) object:nil];
////					[self _sendStartTouch];
////				}
////			}
//    
//    if(s_touchedObject == self)
//    {
////				BOOL returnNO = NO;
//        switch(touch.phase)
//        {
//            case UITouchPhaseBegan:
//                break;
//            
//            case UITouchPhaseMoved:
//                [self _touchesMoved:touches withEvent:event];
////                        returnNO = YES; // this eats scrolling events in a table.
//                break;
//                
//            case UITouchPhaseEnded:
//                [self _touchesEnded:touches withEvent:event];
//            break;
//                
//            case UITouchPhaseCancelled:
//                 [self _touchesCancelled:touches withEvent:event];
//            break;
//            
//            case UITouchPhaseStationary: 
//            break;
//        }
//        
////				if(returnNO)
////				{
////					return NO;
////				}
//    }
//
//}







@end
