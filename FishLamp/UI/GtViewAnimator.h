//
//  GtAnimator.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/12/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

typedef enum {
	GtAnimationPositionTop,
	GtAnimationPositionLeft,
	GtAnimationPositionBottom,
	GtAnimationPositionRight
} GtAnimationPosition;

@protocol GtViewAnimatorProtocol <NSObject>

- (void) addSubview:(UIView*) view superview:(UIView*) superview;
- (void) removeFromSuperview:(UIView*) view;
- (void) insertSubview:(UIView*) view atIndex:(NSInteger)index superview:(UIView*) superview;

/* doesn't insert/remove from superview */
- (void) showView:(UIView*) view;
- (void) hideView:(UIView*) view;

@end

@interface GtDefaultViewAnimator : NSObject<GtViewAnimatorProtocol> {
}

GtDefaultProperty(GtDefaultViewAnimator, ViewAnimator);

@end


@interface GtViewAnimator : NSObject<GtViewAnimatorProtocol> {
    GtAnimationPosition m_startPosition;
}

/*  set the destination location of the view you want to animate,
    e.g. myView.frame.origin = myLocation */
@property (readonly, assign, nonatomic) GtAnimationPosition startPositionForShowAnimation;

- (id) initWithStartPosition:(GtAnimationPosition) position;

/*
- (void) addSubview:(UIView*) view 
	superview:(UIView*) superview 
	startPosition:(GtAnimationPosition) startPosition;

- (void) removeFromSuperview:(UIView*) view endPosition:(GtAnimationPosition) endPosition;
// will release controller.
- (void) removeControllerFromSuperview:(UIViewController*) controller  endPosition:(GtAnimationPosition) endPosition; 
 */
 
+ (CGPoint) moveViewToPoint:(UIView*) view 
                      point:(CGPoint) point; // returns starting point	

+ (CGPoint) destinationPointForOffscreenMove:(UIView*) view 
	endPosition:(GtAnimationPosition) endPosition;


- (void) removeControllerFromSuperview:(UIViewController*) controller;

@end
