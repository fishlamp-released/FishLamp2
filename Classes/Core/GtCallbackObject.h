//
//	GtCallback.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampMinimum.h"
#import "GtObjectContainer.h"
#import "GtRetainedObject.h"
#import "GtWeakReference.h"

@interface GtCallbackObject : NSObject {
@private
	id<GtObjectContainer> _targetContainer;
	id _target;
	SEL _action;
	id _userInfo;
}

// target is not retained
- (id) initWithTarget:(id) target action:(SEL) action;

// this is so you can retain the target if needed, or you can use a GtWeakReference 
- (id) initWithContainedTarget:(id<GtObjectContainer>) targetInContainer action:(SEL) action;

+ (GtCallbackObject*) callback:(id) target action:(SEL) action;
+ (GtCallbackObject*) callbackWithContainedTarget:(id<GtObjectContainer>) targetInContainer action:(SEL) action;

@property (readwrite, retain, nonatomic) id userInfo;
@property (readonly, assign, nonatomic) id target;
@property (readonly, assign, nonatomic) SEL action;

- (id) invoke:(id) sender;

- (void) invokeOnMainThread:(BOOL) waitUntilDone;

@end



