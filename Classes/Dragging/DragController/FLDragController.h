//
//  FLDragController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/28/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLApplication.h"
#import "FLExternalTouchViewCloser.h"
#import "FLCallback_t.h"

typedef struct {
    FLRect startFrame;
    FLPoint touchOffset;
    FLPoint amountMoved;
    unsigned int userDidTouchView: 1;
    unsigned int didDragView : 1;
    unsigned int lastTouchInTouchableView : 1;
} FLViewDraggerResults;

@protocol FLDragControllerDelegate;

@interface FLDragController : NSObject<FLApplicationEventInterceptor> {
@private
    NSMutableArray* _draggableObjects;
    NSMutableArray* _dragDestinations;
    NSMutableArray* _secondaryViews;
        
    FLRect _dragLimit;
    FLViewDraggerResults _dragResults;
    
    struct {
        unsigned int isDragging: 1;
        unsigned int touchIsForUs:1;
        unsigned int dragWatcherIsRunning: 1;
    } _flags;
}

- (id) init;

+ (id) dragController;

@property (readonly, assign, nonatomic) UIView* touchedView;

@property (readwrite, assign, nonatomic) id<FLDragControllerDelegate> delegate;
@property (readwrite, retain, nonatomic) UIView* touchableView;

- (void) addSecondaryTouchableView:(UIView*) view;
@property (readonly, retain, nonatomic) NSArray* secondaryTouchableViews;

@property (readonly, nonatomic, assign) BOOL isDragging;

@property (readonly, nonatomic, assign) BOOL dragWatcherIsRunning;
- (void) startDragWatcher;
- (void) stopDragWatcher; // automatically called if object released.

- (void) addDragResponder:(id) dragResponder;
- (void) removeDragResponder:(id) dragResponder;

- (void) addDragDestination:(id) destination;

- (void) moveDragRespondersByAmount:(FLPoint) amount 
                  animationDuration:(CGFloat) duration
                  animationFinished:(dispatch_block_t) animationFinished;

- (FLRect) touchableViewFrameInHostView;
- (FLRect) viewFrameInHostView:(UIView*) view;

@end

@protocol FLDragControllerDelegate <NSObject>
- (UIView*) dragControllerGetHostView:(FLDragController*) controller;
- (FLRect) dragControllerCalculateDragBoundsInHostView:(FLDragController*) controller;
@optional
- (void) dragControllerWillBeginDragging:(FLDragController*) controller;
- (void) dragController:(FLDragController*) controller didFinishDraggingWithResults:(FLViewDraggerResults) results;
- (BOOL) dragController:(FLDragController*) controller didInterceptInternalTouches:(NSSet*) touches event:(UIEvent*) event;
- (BOOL) dragController:(FLDragController*) controller didInterceptExternalTouches:(NSSet*) touches event:(UIEvent*) event;
@end


@protocol FLDragControllerDragDestination <NSObject>
@property (readwrite, assign, nonatomic) FLRect frame;

@optional
- (void) dragControllerUpdateFrame:(FLDragController*) controller;
- (void) dragControllerReceiveDrag:(FLDragController*) controller;
- (void) dragController:(FLDragController*) controller didFinishDraggingWithResults:(FLViewDraggerResults) results;
- (void) dragControllerDidDragViews:(FLDragController*) controller;
@end

@interface FLDragControllerDragDestination : NSObject<FLDragControllerDragDestination> {
@private
    FLRect _frame;
    FLCallback_t _setFrameCallback;
}
@property (readwrite, assign, nonatomic) FLCallback_t setFrameCallback;

- (id) initWithSetFrameCallback:(FLCallback_t) callback;

+ (FLDragControllerDragDestination*) dragDestination;
+ (FLDragControllerDragDestination*) dragDestination:(FLCallback_t) setFrameCallback;
@end

@protocol FLDragControllerDragResponder <NSObject>
@optional
- (void) dragController:(FLDragController*) controller 
    dragViewByAmount:(FLPoint) amount;

- (void) dragControllerWillBeginDragging:(FLDragController*) controller;

- (void) dragController:(FLDragController*) controller 
didFinishDraggingWithResults:(FLViewDraggerResults) results;
@end

@interface UIView (FLDragController)
- (void) dragController:(FLDragController*) controller 
    dragViewByAmount:(FLPoint) amount;
          
- (void) dragControllerWillBeginDragging:(FLDragController*) manager;

- (void) dragController:(FLDragController*) controller 
didFinishDraggingWithResults:(FLViewDraggerResults) results;

@end

@interface UIViewController (FLDragController)
- (void) dragController:(FLDragController*) controller 
    dragViewByAmount:(FLPoint) amount;
@end

