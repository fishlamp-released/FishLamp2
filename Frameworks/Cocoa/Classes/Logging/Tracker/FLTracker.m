//
//  FLTracker.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLTracker.h"
#import "FLTrackerSink.h"
#import "FLDispatch.h"

@implementation FLTracker

FLSynthesizeSingleton(FLTracker);

@synthesize disabled = _disabled;
@synthesize subscribedEvents = _subscribedEvents;
@synthesize trackLevel = _trackLevel;

- (id) init {
    self = [super init];
    if(self) {
        _sinks = [[NSMutableArray alloc] init];
        _subscribedEvents = FLTrackerSinkEventsAll;
        _trackLevel = FLTrackerLevelNormal;
    }
    
    return self;
}

#if FL_MRC 
- (void) dealloc {
    FLRelease(_sinks);
    FLSuperDealloc();
}
#endif

- (void) addSink:(id<FLTrackerSink>) sink {
    [_sinks addObject:sink];
}

- (void) _logEvent:(FLTrackerLevel) trackLevel
           eventType:(FLTrackerSinkEventMask) eventType
               block:(void (^)(FLTracker* tracker, id<FLTrackerSink> sink)) block {

    FLDispatchAsync([FLDispatchQueue fifoQueue], ^{
        if( !_disabled && 
            FLTestBits(_subscribedEvents, eventType) &&
            FLTestBits(_trackLevel, trackLevel)) {

            for(id<FLTrackerSink> sink in _sinks) {
                if( FLTestBits(sink.subscribedEvents, eventType) &&
                    FLTestBits(sink.trackLevel, trackLevel) ) {
                    block(self, sink); 
                }
            }
        }
    },
    nil);
}

- (void) logEvent:(NSString*) name
            level:(FLTrackerLevel) trackLevel 
          message:(NSString*) message {
    
    [self _logEvent:trackLevel
            eventType:FLTrackerSinkEventMessages
                block:^(FLTracker* tracker, id<FLTrackerSink> sink ) {
                    [sink logEvent:name message:message];
                }];
}


//
//- (void) logEvent:(NSString*) name
//            level:(FLTrackerLevel) trackLevel 
//        exception:(NSException*) exception
//          message:(NSString*) message {
//
//    [self _logEvent:trackLevel
//            eventType:FLTrackerSinkEventExceptions
//                block:^(FLTracker* tracker, id<FLTrackerSink> sink ) {
//                    [sink logEvent:name exception:exception message:message];
//                }];
//
//}
//
//- (void) logEvent:(NSString*) name
//            level:(FLTrackerLevel) trackLevel 
//            error:(NSError*) error
//          message:(NSString*) message {
//
//    [self _logEvent:trackLevel
//            eventType:FLTrackerSinkEventErrors
//                block:^(FLTracker* tracker, id<FLTrackerSink> sink ) {
//                    [sink logEvent:name error:error message:message];
//                }];
//
//}

//- (void) trackEventWithParameters:(FLTrackerLevel) trackLevel 
//                          message:(NSString*)  message
//                       parameters:(NSDictionary*) parameters {
//
//    [self _trackEvent:trackLevel
//            eventType:FLTrackerSinkEventWithParameters
//                block:^(FLTracker* tracker, id<FLTrackerSink> sink ) {
//                    [sink trackEventWithParameters:parameters message:message];
//                }];
//
//
//}

@end
//
//FLSetLevel(FLLogEvent(@FOO, @"asdf %@", ...) 10
//
//
//void _FLLogEvent(NSString* eventName, ...) {
//    
//    va_list valist;
//    va_start(valist, eventName);   
//    id obj = nil;
//    while ((obj = va_arg(valist, id))) { 
//        
//        if(is isBl NSBlock
//        
//        FLDebugLog([obj description]);
//        
//        
//    
//        
//    
//    }
//    va_end(valist);
//    
//
//}



