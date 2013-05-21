//
//  GtTouchHandler.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/29/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtWindow.h"

@protocol GtTouchableObject <NSObject>
- (UIView*) view;
@property (readwrite, assign, nonatomic) CGRect frame;
@property (readonly, assign, nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readonly, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readonly, assign, nonatomic, getter=isSelected) BOOL selected;
@property (readonly, assign, nonatomic, getter=isDisabled) BOOL disabled;
@end

@protocol GtTouchHandlerDelegate;

typedef void (*GtCustomHighlighter)(id object, CGRect highlightRect);

@interface GtTouchHandler : NSObject<GtEventInterceptor> {
@private
    GtCallback m_changedStateCallback;
//    GtCustomHighlighter m_touchHighlighter;

    id m_touchableObject;
}

@property (readwrite, assign, nonatomic) id touchableObject;

@property (readwrite, assign, nonatomic) GtCallback changedStateCallback;

//@property (readwrite, assign, nonatomic) GtCustomHighlighter touchHighlighter;

// override points
- (BOOL) isOurTouch:(UITouch*) touch;
- (void) handleTouches:(NSSet*) touches forEvent:(UIEvent*) event;

@end

@interface GtSelectOnTouchDownHandler : GtTouchHandler {
}

+ (GtSelectOnTouchDownHandler*) selectOnTouchDownHandler;

@end


@interface GtSelectOnTouchUpHandler : GtTouchHandler {
@private
    NSTimeInterval m_startTap;
    
    
    GtCallback m_touchDown;
    GtCallback m_touchUpInside;
    GtCallback m_touchEntered;
    GtCallback m_touchExited;
    GtCallback m_touchesEnded;

    struct {
		unsigned int highlightOnTouch:1;
		unsigned int exclusiveTouchMode:1;
		
// touch state
		unsigned int isTouching:1;
		unsigned int gotFirstTouch:1;
		unsigned int lastTouchWasInside:1;
		unsigned int touchDidEnter:1;
		unsigned int didChangeStateOnTouch: 1;
	} m_state;
}

+ (GtSelectOnTouchUpHandler*) selectOnTouchUpHandler;

//@property (readwrite, assign, nonatomic, getter=isUserInteractionEnabled) BOOL userInteractionEnabled;
@property (readwrite, assign, nonatomic) BOOL highlightOnTouch;   // defaults to YES

@property (readonly, assign, nonatomic) BOOL isTouching;
@property (readwrite, assign, nonatomic) BOOL exclusiveTouchMode; // defaults to YES
@property (readonly, assign, nonatomic) BOOL touchDidEnter;
@property (readwrite, assign, nonatomic) BOOL didChangeStateOnTouch;

@property (readwrite, assign, nonatomic) GtCallback touchDownCallback;
@property (readwrite, assign, nonatomic) GtCallback touchUpInsideCallback;
@property (readwrite, assign, nonatomic) GtCallback touchEnteredCallback;
@property (readwrite, assign, nonatomic) GtCallback touchExitedCallback;
@property (readwrite, assign, nonatomic) GtCallback touchesEndedCallback;


- (void) resetTouchState;

+ (id) touchedObject; // non-nil during touch events, and its the object that gets the initial touchStart event.
+ (id) lastEnteredObject;

@end

