//
//	FLTouch.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright 2010 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>

// the SDK reuses UITouches. This is here so a snapshot of a touch can be saved.

@interface FLTouch : NSObject {
@private
	NSTimeInterval _timestamp;
	UITouchPhase _phase;
	NSUInteger _tapCount;
	__unsafe_unretained UIWindow* _window;
	__unsafe_unretained UIView* _view;
	FLPoint _location;
	FLPoint _previousLocation;
	FLPoint _windowLocation;
	FLPoint _windowPreviousLocation;
}

- (id) initWithUITouch:(UITouch*) touch;

+ (FLTouch*) touchWithUITouch:(UITouch*) touch;

@property(nonatomic, assign, readonly) NSTimeInterval	   timestamp;
@property(nonatomic, assign, readonly) UITouchPhase		   phase;
@property(nonatomic, assign, readonly) NSUInteger		   tapCount;   // touch down within a certain point within a certain amount of time

@property(nonatomic, assign, readonly) UIWindow	   *window;
@property(nonatomic, assign, readonly) UIView	   *view;

@property(nonatomic, assign, readonly)	FLPoint locationInView;
@property(nonatomic, assign, readonly)	FLPoint previousLocationInView;

@property(nonatomic, assign, readonly)	FLPoint locationInWindow;
@property(nonatomic, assign, readonly) FLPoint previousLocationInWindow;


@end
