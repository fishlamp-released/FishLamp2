//
//  FLNotificationListener.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLCallback.h"

@interface FLNotificationListener : NSObject {
@private
    FLCallback _callback;
}

@property (readwrite, assign, nonatomic) FLCallback callback;

- (id) init;
- (id) initWithTarget:(id) target action:(SEL) action;

+ (id) notificationListener;
+ (id) notificationListener:(id) target action:(SEL) action;

- (void) addObserverForEvent:(NSString*) event object:(id) object;
- (void) addObserverForEvent:(NSString*) event;

- (void) removeAllObservers;
- (void) clear; // removes all observers and callback 

// override point
- (void) didReceiveEvent:(NSNotification*) notification;

@end
