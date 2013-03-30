//
//  FLObservable.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObservable.h"


@implementation NSObject (FLObservationSending)

- (id) asyncObserver {
    return nil;
}

- (BOOL) sendObservation:(SEL) selector toObserver:(id) asyncObserver {

    if([asyncObserver respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FLPerformSelector1(asyncObserver, selector, self);
        });
        return YES;
    }

    return NO;
}

- (BOOL) sendObservation:(SEL) selector toObserver:(id) asyncObserver withObject:(id) object  {
    
    if([asyncObserver respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FLPerformSelector2(asyncObserver, selector, self, object);
        });
        return YES;
    }

    return NO;
}

- (BOOL) sendObservation:(SEL) selector toObserver:(id) asyncObserver withObject:(id) object1 withObject:(id) object2  {
    if([asyncObserver respondsToSelector:selector]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            FLPerformSelector3(asyncObserver, selector, self, object1, object2);
        });
        return YES;
    }

    return NO;
}

- (BOOL) sendObservation:(SEL) selector {
    return [self sendObservation:selector toObserver:self.asyncObserver];
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object  {
    return [self sendObservation:selector toObserver:self.asyncObserver withObject:object];
}

- (BOOL) sendObservation:(SEL) selector withObject:(id) object1 withObject:(id) object2  {
    return [self sendObservation:selector toObserver:self.asyncObserver withObject:object1 withObject:object2];
}

@end

@implementation FLObservable 

@synthesize asyncObserver = _asyncObserver;




@end