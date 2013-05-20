//
//  GtDragController.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/28/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtApplication.h"
#import "GtExternalTouchViewCloser.h"

typedef struct {
    CGRect startFrame;
    CGPoint touchOffset;
    CGPoint amountMoved;
    unsigned int userDidTouchView: 1;
    unsigned int didDragView : 1;
    unsigned int lastTouchInTouchableView : 1;
} GtViewDraggerResults;

@protocol GtDragControllerDelegate;

@interface GtDragController : NSObject<GtEventInterceptor> {
@private
    NSMutableArray* m_draggableObjects;
    NSMutableArray* m_dragDestinations;
    UIView* m_touchableView;
    CGRect m_dragLimit;
    GtViewDraggerResults m_dragResults;
    id<GtDragControllerDelegate> m_delegate;
    struct {
        unsigned int isDragging: 1;
        unsigned int touchIsForUs:1;
        unsigned int dragWatcherIsRunning: 1;
    } m_flags;
}

- (id) init;

+ (id) dragController;

@property (readwrite, assign, nonatomic) id<GtDragControllerDelegate> delegate;
@property (readwrite, retain, nonatomic) UIView* touchableView;

@property (readonly, nonatomic, assign) BOOL isDragging;

@property (readonly, nonatomic, assign) BOOL dragWatcherIsRunning;
- (void) startDragWatcher;
- (void) stopDragWatcher; // automatically called if object released.

- (void) addDragResponder:(id) dragResponder;
- (void) removeDragResponder:(id) dragResponder;

- (void) addDragDestination:(id) destination;

- (void) moveDragRespondersByAmount:(CGPoint) amount 
                  animationDuration:(CGFloat) duration
                  animationFinished:(GtBlock) animationFinished;

- (CGRect) touchableViewFrameInHostView;
@end

@protocol GtDragControllerDelegate <NSObject>
- (UIView*) dragControllerGetHostView:(GtDragController*) controller;
- (CGRect) dragControllerCalculateDragBoundsInHostView:(GtDragController*) controller;
@optional
- (void) dragControllerWillBeginDragging:(GtDragController*) controller;
- (void) dragController:(GtDragController*) controller didFinishDraggingWithResults:(GtViewDraggerResults) results;
- (BOOL) dragController:(GtDragController*) controller didInterceptInternalTouches:(NSSet*) touches event:(UIEvent*) event;
- (BOOL) dragController:(GtDragController*) controller didInterceptExternalTouches:(NSSet*) touches event:(UIEvent*) event;
@end


@protocol GtDragControllerDragDestination <NSObject>
@property (readwrite, assign, nonatomic) CGRect frame;

@optional
- (void) dragControllerUpdateFrame:(GtDragController*) controller;
- (void) dragControllerReceiveDrag:(GtDragController*) controller;
- (void) dragController:(GtDragController*) controller didFinishDraggingWithResults:(GtViewDraggerResults) results;
- (void) dragControllerDidDragViews:(GtDragController*) controller;
@end

@interface GtDragControllerDragDestination : NSObject<GtDragControllerDragDestination> {
@private
    CGRect m_frame;
    GtCallback m_setFrameCallback;
}
@property (readwrite, assign, nonatomic) GtCallback setFrameCallback;

- (id) initWithSetFrameCallback:(GtCallback) callback;

+ (GtDragControllerDragDestination*) dragDestination;
+ (GtDragControllerDragDestination*) dragDestination:(GtCallback) setFrameCallback;
@end

@protocol GtDragControllerDragResponder <NSObject>
@optional
- (void) dragController:(GtDragController*) controller 
    dragViewByAmount:(CGPoint) amount;

- (void) dragControllerWillBeginDragging:(GtDragController*) controller;

- (void) dragController:(GtDragController*) controller 
didFinishDraggingWithResults:(GtViewDraggerResults) results;
@end

@interface UIView (GtDragController)
- (void) dragController:(GtDragController*) controller 
    dragViewByAmount:(CGPoint) amount;
          
- (void) dragControllerWillBeginDragging:(GtDragController*) manager;

- (void) dragController:(GtDragController*) controller 
didFinishDraggingWithResults:(GtViewDraggerResults) results;

@end

@interface UIViewController (GtDragController)
- (void) dragController:(GtDragController*) controller 
    dragViewByAmount:(CGPoint) amount;
@end

