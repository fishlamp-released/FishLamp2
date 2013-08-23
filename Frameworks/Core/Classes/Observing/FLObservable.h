//
//  FLObservable.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBroadcaster.h"

@protocol FLObservable <NSObject>
- (FLBroadcaster*) observers;

- (BOOL) hasListener:(id) listener;

- (void) addObserver:(id) observer;

- (void) removeObserver:(id) listener;

@end

@interface FLObservable : NSObject<FLObservable> {
@private
    FLBroadcaster* _observers;
}

@property (readonly, nonatomic, strong) FLBroadcaster* observers;

@end