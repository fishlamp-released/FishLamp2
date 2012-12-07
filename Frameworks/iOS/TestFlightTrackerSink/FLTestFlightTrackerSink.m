//
//  TestFlightTrackerSink.m
//  TestFlightTrackerSink
//
//  Created by Mike Fullerton on 6/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTestFlightTrackerSink.h"

//#import "TestFlight.h"

@implementation FLTestFlightTrackerSink

@synthesize disabled = _disabled;
@synthesize subscribedEvents = _subscribedEvents;
@synthesize trackLevel = _trackLevel;

- (id) init {
    self = [super init];
    if(self) {
        _subscribedEvents = FLTrackerSinkEventsAll;
        _trackLevel = FLTrackerLevelNormal;
    }
    
    return self;
}

+ (FLTestFlightTrackerSink*) testFlightTrackerSink {
    return FLAutorelease([[FLTestFlightTrackerSink alloc] init]);
}

- (void) trackEvent:(NSString*) message {
}

- (void) logEvent:(NSString*) eventName 
          message:(NSString*) message {
}


//- (void) trackException:(NSException*) exception
//                message:(NSString*)  message {
//                
//    [self trackEvent:[NSString stringWithFormat:@"Exception: %@: %@", message, [exception description]]];
//}
//
//- (void) trackError:(NSError*) error
//            message:(NSString*)  message {
//    [self trackEvent:[NSString stringWithFormat:@"Error: %@: %@", message, [error localizedDescription]]];
//}
//
//- (void) trackEventWithParameters:(NSDictionary*) parameters 
//                          message:(NSString*)  message {
//    [self trackEvent:[NSString stringWithFormat:@"Info: %@: %@", message, [parameters description]]];
//}

@end
