//
//  FLObservable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FishLamp.h"

@interface NSObject (FLObservationSending)

// observations are queued on the main thread,
// these are used for notifying UI code from async threads.
// if the target doesn't respond to the selector, NO is returned
// and the message is ignored

- (BOOL) receiveObservation:(SEL) messageSelector;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3;

- (BOOL) receiveObservation:(SEL) messageSelector 
                 withObject:(id) object1 
                 withObject:(id) object2 
                 withObject:(id) object3
                 withObject:(id) object4;

// sending

- (BOOL) sendObservation:(SEL) selector
              toObserver:(id) observer;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3;

- (BOOL) sendObservation:(SEL) selector 
              toObserver:(id) observer 
              withObject:(id) object1 
              withObject:(id) object2  
              withObject:(id) object3
              withObject:(id) object4;

@end

@protocol FLObservable <NSObject>
@property (readwrite, assign, nonatomic) id observer;

- (BOOL) sendObservation:(SEL) messageSelector;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2;

- (BOOL) sendObservation:(SEL) messageSelector withObject:(id) object1 withObject:(id) object2 withObject:(id) object3;
@end

@interface FLObservable : NSObject<FLObservable> {
@private
    __unsafe_unretained id _observer;
}


@end



