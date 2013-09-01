//
//  FLNotifier.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/15/13.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLBroadcaster.h"
#import "FLCoreRequired.h"

@protocol FLNotifier <NSObject>
@property (readonly, strong) FLBroadcaster* notifier;
- (BOOL) hasListener:(id) listener;
- (void) addListener:(id) observer;
- (void) removeListener:(id) listener;
@end

#define FLSynthesizeDeprecatedObservableProperties() \
            - (void) addObserver:(id) observer { \
                [self addListener:observer]; \
            } \
            - (void) removeObserver:(id) listener { \
                [self removeListener:listener]; \
            } \
            - (FLBroadcaster*) observers { \
                return self.notifier; \
            }

//#define FLDeclareNotifierProperties() \
//            - (BOOL) hasListener:(id) listener;
//            - (void) addListener:(id) observer;
//
//            - (void) removeListener:(id) listener;
//            /* deprecated*/ \
//            @property (readonly, strong) FLBroadcaster* observers

#define FLSynthesizeNotifierProperties(__IVAR_NAME__) \
            FLSynthesizeLazyGetter(notifier, FLBroadcaster*, __IVAR_NAME__, FLBroadcaster); \
            \
            - (BOOL) hasListener:(id) listener { \
                return [self.notifier hasListener:listener]; \
            } \
            - (void) addListener:(id) observer { \
                [self.notifier addListener:observer]; \
            } \
            \
            - (void) removeListener:(id) listener { \
                [self.notifier removeListener:listener]; \
            } \
            FLSynthesizeDeprecatedObservableProperties()



@interface FLNotifier : NSObject<FLNotifier> {
@private
    FLBroadcaster* _notifier;
}
@end

