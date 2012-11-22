//
//  FLPullFromSideView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

@protocol FLTugboatViewDelegate;

@interface FLTugboatView : UIView {
@private
    FLPoint _lastPoint;
    __unsafe_unretained id<FLTugboatViewDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLTugboatViewDelegate> delegate;

// touches are in superview's coordinates.
- (void) touchesDidBegin:(FLPoint) touch;
- (void) touchesDidMove:(FLPoint) touch delta:(FLPoint) delta;
- (void) finishTouching:(FLPoint) touch delta:(FLPoint) delta;

@end

@protocol FLTugboatViewDelegate <NSObject>
- (void) tugboatViewDidFinishAnimating:(FLTugboatView*) tugboatView;
- (void) tugboatView:(FLTugboatView*) view setLeft:(CGFloat) left;
- (void) tugboatView:(FLTugboatView*) view dragViewsBy:(FLPoint) delta;
@end

typedef enum {
    FLPullFromLeftSide,
    FLPullFromRightSide
} FLPullFromSide;

@interface FLPullFromSideView : FLTugboatView {
@private
    FLPullFromSide _side;
}

- (id) initWithSide:(FLPullFromSide) side;

- (void) resetView;

@end

