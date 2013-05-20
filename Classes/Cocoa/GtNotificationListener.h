//
//  GtNotificationListener.h
//  FishLamp
//
//  Created by Mike Fullerton on 9/8/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>
#import "GtCallback.h"

@interface GtNotificationListener : NSObject {
@private
    GtCallback m_callback;
}

@property (readwrite, assign, nonatomic) GtCallback callback;

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
