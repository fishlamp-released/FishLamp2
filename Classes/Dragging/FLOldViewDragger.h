//
//  FLViewDragger.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLApplication.h"

@protocol FLDraggableItem;

@interface FLOldViewDragger :  NSObject<FLApplicationEventInterceptor> {
@private
    FLPoint _firstTouch;
    FLPoint _lastTouch;
    id<FLDraggableItem> _item;
    BOOL _touchIsInside;
}

@property (readonly, assign, nonatomic) UIWindow* window;

@property (readonly, assign, nonatomic) BOOL isWatchingTouches;

+ (FLOldViewDragger*) viewDragger;

- (void) beginWatchingTouchesForDraggableItem:(id<FLDraggableItem>) item;
- (void) stopWatchingTouches;

- (FLPoint) pointInView:(FLPoint) windowCoordinatePoint;

@end

typedef struct {
// touches are in window coordinates!!
    FLPoint firstTouch;
    FLPoint previousTouch;
    FLPoint currentTouch;
    FLPoint currentDelta;
    FLRect frame;
} FLViewDraggerDragInfo;


@protocol FLDraggableItem <NSObject>

@property (readonly, assign, nonatomic) UIView* touchableView;
@property (readonly, assign, nonatomic) FLRect frame;
@property (readonly, assign, nonatomic) FLRect dragLimit;
@property (readonly, assign, nonatomic) NSArray* dragDestinations; // array of rects.

- (void) viewDraggerDragWillBegin:(FLOldViewDragger*) dragger;
- (void) viewDragger:(FLOldViewDragger*) dragger dragWillMove:(FLViewDraggerDragInfo) dragInfo;
- (void) viewDragger:(FLOldViewDragger*) dragger dragDidFinish:(FLViewDraggerDragInfo) dragInfo;

@end


