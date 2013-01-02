//
//	UIView+ViewAnimation.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/15/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#if 0
// TODO: rewrite with blocks (predates iOS 4)


typedef enum {
	FLAnimatedViewTypeFade,
	FLAnimatedViewTypeSlideFromTop,
	FLAnimatedViewTypeSlideFromLeft,
	FLAnimatedViewTypeSlideFromBottom,
	FLAnimatedViewTypeSlideFromRight
} FLAnimatedViewType;

typedef void (^FLAnimatedViewFinishedBlock)(UIView* view);
typedef void (^FLViewBatchAnimationFinishedBlock)(NSArray* views);

@interface UIView (FLAnimatedView)
//- (void) animateOntoScreen:(FLAnimatedViewType) type duration:(CGFloat) duration;
- (void) animateOntoScreen:(FLAnimatedViewType) type duration:(CGFloat) duration finishedBlock:(FLAnimatedViewFinishedBlock) finishedBlock;

//- (void) removeFromSuperviewWithAnimationType:(FLAnimatedViewType) type duration:(CGFloat) duration;
- (void) removeFromSuperviewWithAnimationType:(FLAnimatedViewType) type duration:(CGFloat) duration finishedBlock:(FLAnimatedViewFinishedBlock) finishedBlock;

- (void) setHiddenWithFade:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLAnimatedViewFinishedBlock) finishedBlock;

// TODO: make this api the same as the other ones
- (void) doPopInAnimation:(CGFloat) duration;
- (void) doPopInAnimationWithDelegate:(id)animationDelegate	 duration:(CGFloat) duration;

+ (void) setViewsHiddenWithFade:(NSArray*) views hidden:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLViewBatchAnimationFinishedBlock) finishedBlock;
@end


@interface FLAnimatedViewFadePayload : NSObject {
	CGFloat _alpha;
	BOOL _hidden;
	UIView* _view;
	FLAnimatedViewFinishedBlock _block;
}

@property (readwrite, copy, nonatomic) FLAnimatedViewFinishedBlock finishedBlock;
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) BOOL hidden;
@property (readwrite, retain, nonatomic) UIView* view;

- (id) initWithView:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLAnimatedViewFinishedBlock) finishedBlock;
+ (FLAnimatedViewFadePayload*) viewAnimationFadePayload:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLAnimatedViewFinishedBlock) finishedBlock;

@end

@interface FLBatchAnimationPayload : NSObject {
	FLViewBatchAnimationFinishedBlock _finishedBlock;
	NSArray* _payloadArray;
}

@property (readwrite, retain, nonatomic) NSArray* payloadArray;
@property (readwrite, copy, nonatomic) FLViewBatchAnimationFinishedBlock finishedBlock;
- (id) initWithPayloadArray:(NSArray*) array finishedBlock:(FLViewBatchAnimationFinishedBlock) finishedBlock;


@end
#endif