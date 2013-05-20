//
//	GtThumbnailButton.h
//	FishLamp
//
//	Created by Mike Fullerton on 12/6/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtCallbackObject.h"
#import "GtThumbnailView.h"

@class GtButtonAnimation;

typedef enum { 
	GtThumbnailButtonSelectedBehaviorNone,
	GtThumbnailButtonSelectedBehaviorAnimate,
	GtThumbnailButtonSelectedBehaviorOverlayColor
} GtThumbnailButtonSelectedBehavior;

@interface GtThumbnailButton : GtThumbnailView {
@private
	GtCallbackObject* m_callback;
	GtButtonAnimation* m_buttonAnimation;
	struct {
		GtThumbnailButtonSelectedBehavior selectedBehavior:3;
		unsigned int wasSelected:1;
		unsigned int selected:1;
	} m_buttonFlags;
	id m_userData;
}

+ (GtThumbnailButton*) thumbnailButton;

@property (readwrite, retain, nonatomic) id userData;

@property (readwrite, assign, nonatomic) GtThumbnailButtonSelectedBehavior selectedBehavior;
@property (readwrite, retain, nonatomic) GtButtonAnimation* buttonAnimation;
@property (readwrite, assign, nonatomic) BOOL selected;

@property (readwrite, retain, nonatomic) GtCallbackObject* callback;

- (void) addTarget:(id)target action:(SEL)action;

@end

@protocol GtButtonAnimationDelegate;

@interface GtButtonAnimation : NSObject {
	id<GtButtonAnimationDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtButtonAnimationDelegate> delegate;


- (void) beginAnimation:(GtThumbnailButton*) button;

- (void) setButtonSelected:(GtThumbnailButton*) button selected:(BOOL) selected;

@end

@protocol GtButtonAnimationDelegate <NSObject>
- (UIView*) buttonAnimationGetHostView:(GtButtonAnimation*) animation;
@end

@interface GtBounceButtonAnimation : GtButtonAnimation {
	CGRect m_originalFrame;
	NSArray* m_animationQueue;
	int m_currentAnimation;
}
GtSingletonProperty(GtBounceButtonAnimation);
@end

@interface GtZoomButtonAnimation : GtButtonAnimation {
	GtThumbnailButton* m_button;
}

+ (GtZoomButtonAnimation*) zoomButtonAnimation:(id<GtButtonAnimationDelegate>) delegate;

@end

