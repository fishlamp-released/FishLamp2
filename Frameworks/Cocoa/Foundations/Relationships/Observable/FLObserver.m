//
//  FLObserver.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 1/24/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLObserver.h"
#import "FLDispatch.h"

@implementation NSString (FLObservation) 
- (SEL) observationSelector {
    return NSSelectorFromString(self);
} 
@end


@interface FLObservation ()

@property (readwrite, strong, nonatomic) id sender;
@property (readwrite, strong, nonatomic) id receiver;
@property (readwrite, strong, nonatomic) id parameter1;
@property (readwrite, strong, nonatomic) id parameter2;
@property (readwrite, strong, nonatomic) id observation;
@property (readwrite, assign, nonatomic) NSInteger parameterCount;
@property (readwrite, assign, nonatomic) BOOL cacheable;
@end

@implementation FLObservation 

@synthesize sender = _sender;
@synthesize receiver = _receiver;
@synthesize parameter1 = _parameter1;
@synthesize parameter2 = _parameter2;
@synthesize observation = _observation;
@synthesize parameterCount = _parameterCount;
@synthesize cacheable = _cacheable;

- (id) initWithObservation:(id) observation withObject:(id) object1 withObject:(id) object2 parameterCount:(NSInteger) parameterCount {
    self = [super init];
    if(self) {
        self.observation = observation;
        self.parameter1 = object1;
        self.parameter2 = object2;
        self.parameterCount = parameterCount;
    }
    return self;
}

- (id) initWithObservation:(id) observation {
    return [self initWithObservation:observation withObject:nil withObject:nil parameterCount:0];
}

- (id) initWithObservation:(id) observation withObject:(id) object1 {
    return [self initWithObservation:observation withObject:object1 withObject:nil parameterCount:1];
}

- (id) initWithObservation:(id) observation withObject:(id) object1 withObject:(id) object2 {
    return [self initWithObservation:observation withObject:object1 withObject:object2 parameterCount:2];
}

+ (id) observation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) releaseToCache {
//    if(self.cacheable) {
//        // add to cache
//    }
    
}

//- (int) argumentCount {
//    NInteger argumentCount = 0;
//    NSString* name = self.selectorString;
//    for(int i = 0; i < name.length; i++) {
//        if([name characterAtIndex:i] == ':') {
//            argumentCount++;
//        }
//    }
//    
//    return argumentCount;
//}

#if FL_MRC
- (void) dealloc {
    [_observation release];
    [_sender release];
    [_parameter1 release];
    [_parameter2 release];
    [super dealloc];
}
#endif

- (void) performObservation {
    if(!FLPerformSelector1(_receiver, @selector(didReceiveObservation:), self)) {

        SEL selector = [_observation observationSelector];

        FLLog(@"Sending observation: %@", NSStringFromSelector(selector));

        if(selector) {
            FLPerformSelectorWithArgCount(_receiver, 
                                          selector, 
                                          _parameterCount, 
                                          _sender, 
                                          _parameter1, 
                                          _parameter2);
        }
    }
}

- (void) sendObservation {
    if(!FLPerformSelector1(_sender, @selector(willPostObservation:), self)) {
        [self performObservation];
    }
}

- (void) startWorking:(FLFinisher*) finisher {
    [self sendObservation];
    [finisher setFinished];
}

- (void) postObservationToListener:(id) observer {
    [[FLAsyncQueue mainThreadQueue] queueAsyncWorker:self completion:^(FLResult result) {
        [self releaseToCache];
    }];
}

+ (SEL) selectorForObserver:(id) observer withKey:(NSString*) key {
    SEL sel = [key observationSelector];
    return [observer respondsToSelector:sel] ? sel : nil;
}

@end

@implementation NSObject (FLObservationSending)

- (void) postObservation:(id) observationObj 
              toObserver:(id) observer {
    
    SEL sel = [FLObservation selectorForObserver:observer withKey:observationObj];
    if(sel) {
        FLObservation* observation = [FLObservation observation];
        observation.receiver = observer;
        observation.sender = self;
        observation.observation = observationObj;
        observation.parameterCount = 1; 
        observation.cacheable = YES;         
        [observation postObservationToListener:observer];
    }
    
}
             
- (void) postObservation:(id) observationObj  
              toObserver:(id) observer
              withObject:(id) object1 {
    
    SEL sel = [FLObservation selectorForObserver:observer withKey:observationObj];
    if(sel) {
        FLObservation* observation = [FLObservation observation];
        observation.receiver = observer;
        observation.sender = self;
        observation.observation = observationObj;
        observation.parameter1 = object1;
        observation.parameterCount = 2; 
        observation.cacheable = YES;         
        [observation postObservationToListener:observer];
    }
}

- (void) postObservation:(id) observationObj 
              toObserver:(id) observer
              withObject:(id) object1
              withObject:(id) object2  {
    SEL sel = [FLObservation selectorForObserver:observer withKey:observationObj];
    if(sel) {
        FLObservation* observation = [FLObservation observation];
        observation.receiver = observer;
        observation.sender = self;
        observation.observation = observationObj;
        observation.parameter1 = object1;
        observation.parameter1 = object2;
        observation.parameterCount = 3; 
        observation.cacheable = YES;         
        [observation postObservationToListener:observer];
    }
}              
              
@end
