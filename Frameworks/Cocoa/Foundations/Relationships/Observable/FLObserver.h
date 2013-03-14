//
//  FLObserver.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAsyncWorker.h"

@interface NSString (FLObservation)
- (SEL) observationSelector;
@end

@interface FLObservation : NSObject<FLAsyncWorker> {
@private
    id _sender;
    id _receiver;
    id _parameter1;
    id _parameter2;
    NSInteger _parameterCount;
    id _observation;
    BOOL _cacheable;
    SEL _selector;
}

@property (readonly, strong, nonatomic) id sender;
@property (readonly, strong, nonatomic) id receiver;

@property (readonly, strong, nonatomic) id parameter1;
@property (readonly, strong, nonatomic) id parameter2;

@property (readonly, strong, nonatomic) id observation;

@property (readonly, assign, nonatomic) NSInteger parameterCount;

- (void) performObservation;

- (void) sendObservation;

@end


@interface NSObject (FLObservationSending) 

- (void) postObservation:(id) observation  
              toObserver:(id) observer;

- (void) postObservation:(id) observation  
              toObserver:(id) observer
              withObject:(id) object;

- (void) postObservation:(id) observation 
              toObserver:(id) observer
              withObject:(id) object1
              withObject:(id) object2;
@end


@protocol FLObservationReceiving <NSObject>
@optional 
- (void) didReceiveObservation:(FLObservation*) observation;
@end

@protocol FLObservationSending <NSObject>
@optional 
- (void) willPostObservation:(FLObservation*) observation;
@end

//#define FLPostObservation(__NAME__, __TO__) \
//    [self postObservation:NSSelectorFromString(__NAME__) toObserver:__TO__]
//
//#define FLPostObservation1(__NAME__, __TO__,  __OBJ_1__) \
//    [self postObservation:NSSelectorFromString(__NAME__) toObserver:__TO__ withObject:__OBJ_1__]
//
//#define FLPostObservation2(__NAME__, __TO__, __OBJ_1__, __OBJ_2__) \
//    [self postObservation:NSSelectorFromString(__NAME__) toObserver:__TO__ withObject:__OBJ_1__ withObject:__OBJ_2__]
