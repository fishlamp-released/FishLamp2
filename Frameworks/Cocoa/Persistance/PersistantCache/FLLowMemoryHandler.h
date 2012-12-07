//
//	FLLowMemoryHandler.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/24/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FLCore.h"

extern NSString* release_ObjectsCachedInMemoryNotification;

@interface FLLowMemoryHandler : NSObject {
	BOOL _broadcasting;
}

- (void) registerForEvents;
- (void) broadcastReleaseMessage;

- (void) addObserver:(id) observer action:(SEL) action;
- (void) removeObserver:(id) observer;

+ (void) setDefaultHandler:(FLLowMemoryHandler*) handler;
+ (id) defaultHandler;

@end
