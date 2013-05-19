//
//	FLCallback_t.h
//	FishLamp
//
//	Created by Mike Fullerton on 11/10/10.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLampCore.h"
#import "FLObjectContainer.h"
#import "FLRetainedObject.h"
#import "FLWeakReference.h"

@interface FLCallbackObject : NSObject {
@private
	id<FLObjectContainer> _targetContainer;
	id _target;
	SEL _action;
	id _userInfo;
}

// target is not retained
- (id) initWithTarget:(id) target action:(SEL) action;

// this is so you can retain the target if needed, or you can use a FLWeakReference 
- (id) initWithContainedTarget:(id<FLObjectContainer>) targetInContainer action:(SEL) action;

+ (FLCallbackObject*) callback:(id) target action:(SEL) action;
+ (FLCallbackObject*) callbackWithContainedTarget:(id<FLObjectContainer>) targetInContainer action:(SEL) action;

@property (readwrite, retain, nonatomic) id userInfo;
@property (readonly, assign, nonatomic) id target;
@property (readonly, assign, nonatomic) SEL action;

- (id) invoke:(id) sender;

- (void) invokeOnMainThread:(BOOL) waitUntilDone;

@end



