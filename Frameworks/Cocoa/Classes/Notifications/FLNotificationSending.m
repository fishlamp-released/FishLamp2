//
//  FLNotifier.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLNotificationSending.h"
#import "FLSelectorPerforming.h"

@implementation NSObject (FLNotificationSending)
 
- (id) notificationListener {
    return nil;
}

- (BOOL) sendNotification:(SEL) selector toListener:(id) listener {
    return [self sendNotification:selector toListener:listener argCount:0 withObject:nil withObject:nil withObject:nil];
}
             
- (BOOL) sendNotification:(SEL) selector 
              toListener:(id) listener
              withObject:(id) object1 {
    
    return [self sendNotification:selector toListener:listener argCount:1 withObject:object1 withObject:nil withObject:nil];
}

- (BOOL) sendNotification:(SEL) selector  
              toListener:(id) listener
              withObject:(id) object1
              withObject:(id) object2  {

    return [self sendNotification:selector toListener:listener argCount:2 withObject:object1 withObject:object2 withObject:nil];
}             

- (BOOL) sendNotification:(SEL) selector  
              toListener:(id) listener
              withObject:(id) object1
              withObject:(id) object2
              withObject:(id) object3  {

    return [self sendNotification:selector toListener:listener argCount:3 withObject:object1 withObject:object2 withObject:object3];
}             
              
- (BOOL) sendNotification:(SEL) selector 
               toListener:(id) listener
                 argCount:(int) argCount 
               withObject:(id) object1 
               withObject:(id) object2
               withObject:(id) object3 {

    return [listener receiveNotification:selector fromSender:self argCount:argCount withObject:object1 withObject:object2 withObject:object3];
}

- (BOOL) receiveNotification:(SEL) selector 
                  fromSender:(id) sender
                    argCount:(int) argCount 
                  withObject:(id) object1
                  withObject:(id) object2
                  withObject:(id) object3 {
    return FLPerformSelectorWithArgCount(self, selector, argCount, object1, object2, object3);
}                  

- (BOOL) sendNotification:(SEL) selector {
    return [self sendNotification:selector toListener:[self notificationListener] argCount:0 withObject:nil withObject:nil withObject:nil];
}

- (BOOL) sendNotification:(SEL) selector  
          withObject:(id) object  {
    return [self sendNotification:selector toListener:[self notificationListener] argCount:1 withObject:object withObject:nil withObject:nil];
}

- (BOOL) sendNotification:(SEL) selector 
          withObject:(id) object1
          withObject:(id) object2  {
    return [self sendNotification:selector toListener:[self notificationListener] argCount:2 withObject:object1 withObject:object2 withObject:nil];
}

- (BOOL) sendNotification:(SEL) selector 
          withObject:(id) object1
          withObject:(id) object2
          withObject:(id) object3 {
    return [self sendNotification:selector toListener:[self notificationListener] argCount:3 withObject:object1 withObject:object2 withObject:object3];
}

@end



