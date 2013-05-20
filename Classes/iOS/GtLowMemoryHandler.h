//
//	GtLowMemoryHandler.h
//	FishLamp
//
//	Created by Mike Fullerton on 9/24/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

extern NSString* GtReleaseObjectsCachedInMemoryNotification;

@interface GtLowMemoryHandler : NSObject {
	BOOL m_broadcasting;
}

- (void) registerForEvents;
- (void) broadcastReleaseMessage;

- (void) addObserver:(id) observer action:(SEL) action;
- (void) removeObserver:(id) observer;

+ (void) setDefaultHandler:(GtLowMemoryHandler*) handler;
+ (id) defaultHandler;

@end
