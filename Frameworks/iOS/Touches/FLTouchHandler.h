//
//  FLTouchHandler.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/29/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "FLApplication.h"


@protocol FLTouchableObject <NSObject>
- (UIView*) view;
@property (readwrite, assign, nonatomic) CGRect frame;
@property (readonly, assign, nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readonly, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readonly, assign, nonatomic, getter=isSelected) BOOL selected;
@property (readonly, assign, nonatomic, getter=isDisabled) BOOL disabled;
@end

@protocol FLTouchHandlerDelegate;

typedef void (*FLCustomHighlighter)(id object, CGRect highlightRect);
typedef void (^FLTouchHandlerWasSelected)(id touchedObject);

@interface FLTouchHandler : NSObject<FLApplicationEventInterceptor> {
@private
    __unsafe_unretained id _touchableObject;
    FLTouchHandlerWasSelected _wasSelectedCallback;
    BOOL _disabled;
}

@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled;

@property (readwrite, copy, nonatomic) FLTouchHandlerWasSelected onSelected;

@property (readonly, assign, nonatomic) BOOL gotTouchDown;
@property (readwrite, assign, nonatomic) id touchableObject;

- (void) beginInterceptingGlobalTouches;
- (void) stopInterceptingGlobalTouches;

- (BOOL) isOurTouch:(NSSet*) touches;

+ (id) touchedObject;

// override points
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event;
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event;
@end

@interface FLSelectOnTouchDownHandler : FLTouchHandler {
}

+ (FLSelectOnTouchDownHandler*) selectOnTouchDownHandler;

@end

#import "FLCallback_t.h"

@interface FLSelectOnTouchUpHandler : FLTouchHandler {
@private
    NSTimeInterval _startTap;
    FLCallback_t _touchDown;
    FLCallback_t _touchUpInside;
    FLCallback_t _touchEntered;
    FLCallback_t _touchExited;
    FLCallback_t _touchesEnded;

    struct {
		unsigned int highlightOnTouch:1;
		unsigned int exclusiveTouchMode:1;
		
// touch state
		unsigned int isTouching:1;
		unsigned int gotFirstTouch:1;
		unsigned int lastTouchWasInside:1;
		unsigned int touchDidEnter:1;
		unsigned int didChangeStateOnTouch: 1;
	} _state;
}

+ (FLSelectOnTouchUpHandler*) selectOnTouchUpHandler;

//@property (readwrite, assign, nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic) BOOL highlightOnTouch;   // defaults to YES

@property (readonly, assign, nonatomic) BOOL isTouching;
@property (readwrite, assign, nonatomic) BOOL exclusiveTouchMode; // defaults to YES
@property (readonly, assign, nonatomic) BOOL touchDidEnter;
@property (readwrite, assign, nonatomic) BOOL didChangeStateOnTouch;

@property (readwrite, assign, nonatomic) FLCallback_t touchDownCallback;
@property (readwrite, assign, nonatomic) FLCallback_t touchUpInsideCallback;
@property (readwrite, assign, nonatomic) FLCallback_t touchEnteredCallback;
@property (readwrite, assign, nonatomic) FLCallback_t touchExitedCallback;
@property (readwrite, assign, nonatomic) FLCallback_t touchesEndedCallback;

+ (id) lastEnteredObject;

@end

