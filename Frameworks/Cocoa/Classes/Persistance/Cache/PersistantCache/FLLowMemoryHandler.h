//
//	FLLowMemoryHandler.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/24/09.
//	Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#import "FishLampCore.h"

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
