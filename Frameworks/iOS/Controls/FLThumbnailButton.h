//
//	FLThumbnailButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLCallbackObject.h"
#import "FLThumbnailView.h"

@class FLButtonAnimation;

typedef enum { 
	FLThumbnailButtonSelectedBehaviorNone,
	FLThumbnailButtonSelectedBehaviorAnimate,
	FLThumbnailButtonSelectedBehaviorOverlayColor
} FLThumbnailButtonSelectedBehavior;

@interface FLThumbnailButton : FLThumbnailView {
@private
	FLCallbackObject* _callback;
	FLButtonAnimation* _buttonAnimation;
	struct {
		FLThumbnailButtonSelectedBehavior selectedBehavior:3;
		unsigned int wasSelected:1;
		unsigned int selected:1;
	} _buttonFlags;
	id _userData;
}

+ (FLThumbnailButton*) thumbnailButton;

@property (readwrite, retain, nonatomic) id userData;

@property (readwrite, assign, nonatomic) FLThumbnailButtonSelectedBehavior selectedBehavior;
@property (readwrite, retain, nonatomic) FLButtonAnimation* buttonAnimation;
@property (readwrite, assign, nonatomic) BOOL selected;

@property (readwrite, retain, nonatomic) FLCallbackObject* callback;

- (void) addTarget:(id)target action:(SEL)action;

@end

@protocol FLButtonAnimationDelegate;

@interface FLButtonAnimation : NSObject {
	__unsafe_unretained id<FLButtonAnimationDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLButtonAnimationDelegate> delegate;


- (void) beginAnimation:(FLThumbnailButton*) button;

- (void) setButtonSelected:(FLThumbnailButton*) button selected:(BOOL) selected;

@end

@protocol FLButtonAnimationDelegate <NSObject>
- (UIView*) buttonAnimationGetHostView:(FLButtonAnimation*) animation;
@end

@interface FLBounceButtonAnimation : FLButtonAnimation {
	CGRect _originalFrame;
	NSArray* _animationQueue;
	int _currentAnimation;
}
FLSingletonProperty(FLBounceButtonAnimation);
@end

@interface FLZoomButtonAnimation : FLButtonAnimation {
	FLThumbnailButton* _button;
}

+ (FLZoomButtonAnimation*) zoomButtonAnimation:(id<FLButtonAnimationDelegate>) delegate;

@end

