//
//	GtTouch.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/15/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

// the SDK reuses UITouches. This is here so a snapshot of a touch can be saved.

@interface GtTouch : NSObject {
@private
	NSTimeInterval m_timestamp;
	UITouchPhase m_phase;
	NSUInteger m_tapCount;
	UIWindow* m_window;
	UIView* m_view;
	CGPoint m_location;
	CGPoint m_previousLocation;
	CGPoint m_windowLocation;
	CGPoint m_windowPreviousLocation;
}

- (id) initWithUITouch:(UITouch*) touch;

+ (GtTouch*) touchWithUITouch:(UITouch*) touch;

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
