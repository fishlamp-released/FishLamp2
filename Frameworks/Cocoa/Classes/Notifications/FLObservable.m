//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"

@implementation FLObservable 

@synthesize observer = _observer;

- (void) sendObjectMessage:(FLObjectMessage*) message toListener:(id) listener {
    dispatch_async(dispatch_get_main_queue(), ^{
        [listener receiveObjectMessage:message];
    });
}

- (BOOL) sendObservation:(SEL) messageSelector {
    return [self sendMessage:messageSelector toListener:self.observer];
}

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object  {
    return [self sendMessage:messageSelector toListener:self.observer withObject:object];
}

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2  {
    return [self sendMessage:messageSelector toListener:self.observer withObject:object1 withObject:object2];
}

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer {
    return [self sendMessage:messageSelector toListener:observer];
}

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer withObject:(id) object  {
    return [self sendMessage:messageSelector toListener:observer withObject:object];
}

- (BOOL) sendObservation:(SEL) messageSelector toObserver:(id) observer withObject:(id) object1 withObject:(id) object2  {
    return [self sendMessage:messageSelector toListener:observer withObject:object1 withObject:object2];
}



@end