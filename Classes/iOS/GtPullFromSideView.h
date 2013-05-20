//
//  GtPullFromSideView.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@protocol GtTugboatViewDelegate;

@interface GtTugboatView : UIView {
@private
    CGPoint m_lastPoint;
    id<GtTugboatViewDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtTugboatViewDelegate> delegate;

// touches are in superview's coordinates.
- (void) touchesDidBegin:(CGPoint) touch;
- (void) touchesDidMove:(CGPoint) touch delta:(CGPoint) delta;
- (void) finishTouching:(CGPoint) touch delta:(CGPoint) delta;

@end

@protocol GtTugboatViewDelegate <NSObject>
- (void) tugboatViewDidFinishAnimating:(GtTugboatView*) tugboatView;
- (void) tugboatView:(GtTugboatView*) view setLeft:(CGFloat) left;
- (void) tugboatView:(GtTugboatView*) view dragViewsBy:(CGPoint) delta;
@end

typedef enum {
    GtPullFromLeftSide,
    GtPullFromRightSide
} GtPullFromSide;

@interface GtPullFromSideView : GtTugboatView {
@private
    GtPullFromSide m_side;
}

- (id) initWithSide:(GtPullFromSide) side;

- (void) resetView;

@end

