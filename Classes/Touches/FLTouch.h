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
	UIWindow* _window;
	UIView* _view;
	CGPoint _location;
	CGPoint _previousLocation;
	CGPoint _windowLocation;
	CGPoint _windowPreviousLocation;
}

- (id) initWithUITouch:(UITouch*) touch;

+ (FLTouch*) touchWithUITouch:(UITouch*) touch;

@property(nonatomic, assign, readonly) NSTimeInterval	   timestamp;
@property(nonatomic, assign, readonly) UITouchPhase		   phase;
@property(nonatomic, assign, readonly) NSUInteger		   tapCount;   // touch down within a certain point within a certain amount of time

@property(nonatomic, assign, readonly) UIWindow	   *window;
@property(nonatomic, assign, readonly) UIView	   *view;

@property(nonatomic, assign, readonly)	CGPoint locationInView;
@property(nonatomic, assign, readonly)	CGPoint previousLocationInView;

@property(nonatomic, assign, readonly)	CGPoint locationInWindow;
@property(nonatomic, assign, readonly) CGPoint previousLocationInWindow;


@end
