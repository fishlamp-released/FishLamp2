//
//	FLTouch.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

// the FL reuses UITouches. This is here so a snapshot of a touch can be saved.

@interface FLTouch : NSObject {
@private
	NSTimeInterval _timestamp;
	UITouchPhase _phase;
	NSUInteger _tapCount;
	__unsafe_unretained UIWindow* _window;
	__unsafe_unretained UIView* _view;
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
