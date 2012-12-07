//
//  FLNotificationListener.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/11.
//  Copyright (c) 2011 Greentongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"
#import "FLCallback_t.h"

@interface FLNotificationListener : NSObject {
@private
    FLCallback_t _callback;
}

@property (readwrite, assign, nonatomic) FLCallback_t callback;

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
