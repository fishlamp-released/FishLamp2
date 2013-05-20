//
//	UIView+ViewAnimation.h
//	FishLamp
//
//	Created by Mike Fullerton on 4/15/11.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

typedef enum {
	GtViewAnimationTypeFade,
	GtViewAnimationTypeSlideFromTop,
	GtViewAnimationTypeSlideFromLeft,
	GtViewAnimationTypeSlideFromBottom,
	GtViewAnimationTypeSlideFromRight
} GtViewAnimationType;

typedef void (^GtViewAnimationFinishedBlock)(UIView* view);
typedef void (^GtViewBatchAnimationFinishedBlock)(NSArray* views);

@interface UIView (GtViewAnimation)
//- (void) animateOntoScreen:(GtViewAnimationType) type duration:(CGFloat) duration;
- (void) animateOntoScreen:(GtViewAnimationType) type duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;

//- (void) removeFromSuperviewWithAnimationType:(GtViewAnimationType) type duration:(CGFloat) duration;
- (void) removeFromSuperviewWithAnimationType:(GtViewAnimationType) type duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;

- (void) setHiddenWithFade:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;

// TODO: make this api the same as the other ones
- (void) doPopInAnimation:(CGFloat) duration;
- (void) doPopInAnimationWithDelegate:(id)animationDelegate	 duration:(CGFloat) duration;

+ (void) setViewsHiddenWithFade:(NSArray*) views hidden:(BOOL) hidden duration:(CGFloat) duration finishedBlock:(GtViewBatchAnimationFinishedBlock) finishedBlock;
@end


@interface GtViewAnimationFadePayload : NSObject {
	CGFloat m_alpha;
	BOOL m_hidden;
	UIView* m_view;
	GtViewAnimationFinishedBlock m_block;
}

@property (readwrite, copy, nonatomic) GtViewAnimationFinishedBlock finishedBlock;
@property (readwrite, assign, nonatomic) CGFloat alpha;
@property (readwrite, assign, nonatomic) BOOL hidden;
@property (readwrite, retain, nonatomic) UIView* view;

- (id) initWithView:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;
+ (GtViewAnimationFadePayload*) viewAnimationFadePayload:(UIView*) view alpha:(CGFloat) alpha hidden:(BOOL) hidden finishedBlock:(GtViewAnimationFinishedBlock) finishedBlock;

@end

@interface GtBatchAnimationPayload : NSObject {
	GtViewBatchAnimationFinishedBlock m_finishedBlock;
	NSArray* m_payloadArray;
}

@property (readwrite, retain, nonatomic) NSArray* payloadArray;
@property (readwrite, copy, nonatomic) GtViewBatchAnimationFinishedBlock finishedBlock;
- (id) initWithPayloadArray:(NSArray*) array finishedBlock:(GtViewBatchAnimationFinishedBlock) finishedBlock;


@end
