//
//  GtViewDragger.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/15/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtApplication.h"

@protocol GtDraggableItem;

@interface GtOldViewDragger :  NSObject<GtEventInterceptor> {
@private
    CGPoint m_firstTouch;
    CGPoint m_lastTouch;
    id<GtDraggableItem> m_item;
    BOOL m_touchIsInside;
}

@property (readonly, assign, nonatomic) UIWindow* window;

@property (readonly, assign, nonatomic) BOOL isWatchingTouches;

+ (GtOldViewDragger*) viewDragger;

- (void) beginWatchingTouchesForDraggableItem:(id<GtDraggableItem>) item;
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
} GtViewDraggerDragInfo;


@protocol GtDraggableItem <NSObject>

@property (readonly, assign, nonatomic) UIView* touchableView;
@property (readonly, assign, nonatomic) CGRect frame;
@property (readonly, assign, nonatomic) CGRect dragLimit;
@property (readonly, assign, nonatomic) NSArray* dragDestinations; // array of rects.

- (void) viewDraggerDragWillBegin:(GtOldViewDragger*) dragger;
- (void) viewDragger:(GtOldViewDragger*) dragger dragWillMove:(GtViewDraggerDragInfo) dragInfo;
- (void) viewDragger:(GtOldViewDragger*) dragger dragDidFinish:(GtViewDraggerDragInfo) dragInfo;

@end


