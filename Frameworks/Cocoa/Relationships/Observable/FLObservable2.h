//
//  FLObservable2.h
//  FLCore
//
//  Created by Mike Fullerton on 11/14/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FLObservable2 : NSObject {
@private
    NSMutableDictionary* _observers;
}

- (void) addObserver:(id) observer forEvent:(id) event eventHandler:(SEL) handler; 

- (void) removeObserver:(id) observer forEvent:(id) event;
- (void) removeObserver:(id) observer;

- (void) postObservationForEvent:(id) event;

@end
