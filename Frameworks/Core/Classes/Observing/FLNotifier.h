//
//  FLNotifier.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBroadcaster.h"

@protocol FLNotifier <NSObject>
- (FLBroadcaster*) observers;

- (BOOL) hasListener:(id) listener;

- (void) addObserver:(id) observer;

- (void) removeObserver:(id) listener;

@end

@interface FLNotifier : NSObject<FLNotifier> {
@private
    FLBroadcaster* _observers;
}

@property (readonly, nonatomic, strong) FLBroadcaster* observers;

@end

#define FLSynthesizeObservableProperties(__IVAR_NAME__) \
            FLSynthesizeLazyGetter(observers, FLBroadcaster*, __IVAR_NAME__, FLBroadcaster) \
            \
            - (BOOL) hasListener:(id) listener { \
                return [self.observers hasListener:listener]; \
            } \
            \
            - (void) addObserver:(id<FLObjectProxy>) observer { \
                [self.observers addObserver:observer]; \
            } \
            \
            - (void) removeObserver:(id) listener { \
                [self.observers removeObserver:listener]; \
            }


