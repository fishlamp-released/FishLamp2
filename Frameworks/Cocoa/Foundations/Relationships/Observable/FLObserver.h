//
//  FLObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol FLObserver <NSObject>
- (void) postObservation:(SEL) selector 
              fromObject:(id) object;

- (void) postObservation:(SEL) selector 
               fromObject:(id) object
              withObject:(id) object;

- (void) postObservation:(SEL) selector 
               fromObject:(id) object
              withObject:(id) object1 
              withObject:(id) object2;
@end              

#define FLObserverMaxListeners 5 // if you have more than that, you're doing it wrong.
@interface FLObserver : NSObject<FLObserver> {
@private
    id _listeners[FLObserverMaxListeners];
    NSUInteger _listenerCount;
}
- (void) addListener:(id) listener;
@end


//@interface FLObserver : NSObject {
//@private
//    dispatch_block_t _willStart;
//    FLBlockWithResult _didFinish;
//}
//
//@property (readwrite, strong) dispatch_block_t willStart;
//@property (readwrite, strong) FLBlockWithResult didFinish;
//
//@end

