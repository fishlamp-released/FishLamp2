////
////  FLNotifier.h
////  FishLampCocoa
////
////  Created by Mike Fullerton on 3/15/13.
////  Copyright (c) 2013 Mike Fullerton. All rights reserved.
////
//
//#import <Foundation/Foundation.h>
//#import <dispatch/dispatch.h>
//#import "FishLampCore.h"
//
@interface NSObject (FLNotificationSending)

- (BOOL) sendNotification:(SEL) selector  
               toListener:(id) listener;

- (BOOL) sendNotification:(SEL) selector  
               toListener:(id) listener
               withObject:(id) object;

- (BOOL) sendNotification:(SEL) selector 
               toListener:(id) listener
               withObject:(id) object1
               withObject:(id) object2;

- (BOOL) sendNotification:(SEL) selector 
               toListener:(id) listener
               withObject:(id) object1
               withObject:(id) object2
               withObject:(id) object3;

// these use the notificationLister - override this - for example it could return your delegate
- (id) notificationListener;

- (BOOL) sendNotification:(SEL) selector;

- (BOOL) sendNotification:(SEL) selector  
             withObject:(id) object;

- (BOOL) sendNotification:(SEL) selector 
               withObject:(id) object1
               withObject:(id) object2;

- (BOOL) sendNotification:(SEL) selector 
               withObject:(id) object1
               withObject:(id) object2
               withObject:(id) object2;

// sending bottleneck

- (BOOL) sendNotification:(SEL) selector 
               toListener:(id) listener
                 argCount:(int) argCount 
               withObject:(id) object1 
               withObject:(id) object2
               withObject:(id) object3;


// receiving bottleneck

- (BOOL) receiveNotification:(SEL) selector 
                  fromSender:(id) sender // ignored by default 
                    argCount:(int) argCount 
                  withObject:(id) object1
                  withObject:(id) object2
                  withObject:(id) object2;

@end


