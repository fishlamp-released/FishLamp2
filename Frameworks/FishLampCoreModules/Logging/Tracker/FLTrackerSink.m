//
//  FLTrackerSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTrackerSink.h"

@implementation FLTrackerSink

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

- (void) logEvent:(NSString*) eventName 
          message:(NSString*) message {
          
}          

- (void) logEvent:(NSString*) eventName
   exception:(NSException*) exception
          message:(NSString*)  message {
    [self logEvent:eventName message:[NSString stringWithFormat:@"Exception: %@: %@", message, [exception description]]];
}

- (void) logEvent:(NSString*) eventName
        error:(NSError*) error
          message:(NSString*)  message {
    [self logEvent:eventName message:[NSString stringWithFormat:@"Error: %@: %@", message, [error localizedDescription]]];
}

//- (void) logEvent:(NSString*) eventName
//   withParameters:(NSDictionary*) parameters 
//          message:(NSString*)  message {
//    [self logEvent:eventName message:[NSString stringWithFormat:@"Info: %@: %@", message, [parameters description]]];
//}

@end
