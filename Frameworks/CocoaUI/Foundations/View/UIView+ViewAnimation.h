//
//	UIView+ViewAnimation.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/15/11.
//	Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#if 0
// TODO: rewrite with blocks (predates iOS 4)


typedef enum {
	FLViewAnimationTypeFade,
	FLViewAnimationTypeSlideFromTop,
	FLViewAnimationTypeSlideFromLeft,
	FLViewAnimationTypeSlideFromBottom,
	FLViewAnimationTypeSlideFromRight
} FLViewAnimationType;

typedef void (^FLViewAnimationFinishedBlock)(UIView* view);
typedef void (^FLViewBatchAnimationFinishedBlock)(NSArray* views);

@interface UIView (FLViewAnimation)
//- (void) animateOntoScreen:(FLViewAnimationType) type duration:(CGFloat) duration;
- (void) animateOntoScreen:(FLViewAnimationType) type duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;

//- (void) removeFromSuperviewWithAnimationType:(FLViewAnimationType) type duration:(CGFloat) duration;
- (void) removeFromSuperviewWithAnimationType:(FLViewAnimationType) type duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;

- (void) setHiddenWithFade:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;

// TODO: make this api the same as the other ones
- (void) doPopInAnimation:(CGFloat) duration;
- (void) doPopInAnimationWithDelegate:(id)animationDelegate	 duration:(CGFloat) duration;

+ (void) setViewsHiddenWithFade:(NSArray*) views hidden:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(FLViewBatchAnimationFinishedBlock) finishedBlock;
@end


@interface FLViewAnimationFadePayload : NSObject {
	CGFloat _alpha;
	BOOL _hidden;
	UIView* _view;
	FLViewAnimationFinishedBlock _block;
}

@property (readwrite, copy, nonatomic) FLViewAnimationFinishedBlock finishedBlock;
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) BOOL hidden;
@property (readwrite, retain, nonatomic) UIView* view;

- (id) initWithView:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;
+ (FLViewAnimationFadePayload*) viewAnimationFadePayload:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(FLViewAnimationFinishedBlock) finishedBlock;

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