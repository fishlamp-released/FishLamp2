//
//  FLViewDragger.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLApplication.h"

@protocol FLDraggableItem;

@interface FLOldViewDragger :  NSObject<FLApplicationEventInterceptor> {
@private
    CGPoint _firstTouch;
    CGPoint _lastTouch;
    id<FLDraggableItem> _item;
    BOOL _touchIsInside;
}

@property (readonly, assign, nonatomic) UIWindow* window;

@property (readonly, assign, nonatomic) BOOL isWatchingTouches;

+ (FLOldViewDragger*) viewDragger;

- (void) beginWatchingTouchesForDraggableItem:(id<FLDraggableItem>) item;
- (void) stopWatchingTouches;

- (CGPoint) pointInView:(CGPoint) windowCoordinatePoint;

@end

typedef struct {
// touches are in window coordinates!!
    CGPoint firstTouch;
    CGPoint previousTouch;
    CGPoint currentTouch;
    CGPoint currentDelta;
    CGRect frame;
} FLViewDraggerDragInfo;


@protocol FLDraggableItem <NSObject>

@property (readonly, assign, nonatomic) UIView* touchableView;
@property (readonly, assign, nonatomic) CGRect frame;
@property (readonly, assign, nonatomic) CGRect dragLimit;
@property (readonly, assign, nonatomic) NSArray* dragDestinations; // array of rects.

- (void) viewDraggerDragWillBegin:(FLOldViewDragger*) dragger;
- (void) viewDragger:(FLOldViewDragger*) dragger dragWillMove:(FLViewDraggerDragInfo) dragInfo;
- (void) viewDragger:(FLOldViewDragger*) dragger dragDidFinish:(FLViewDraggerDragInfo) dragInfo;

@end


