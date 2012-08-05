//
//  FLTracker.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLTrackerSink.h"

@interface FLTracker : NSObject {
@private    
    NSMutableArray* _sinks;
    BOOL _disabled;
    FLTrackerSinkEventMask _subscribedEvents;
    FLTrackerLevel _trackLevel;
}

FLSingletonProperty(FLTracker);

@property (readwrite, assign) FLTrackerLevel trackLevel;

@property (readwrite, assign) FLTrackerSinkEventMask subscribedEvents;

@property (readwrite, assign, getter = isDisabled) BOOL disabled;

- (void) addSink:(id<FLTrackerSink>) sink;

- (void) logEvent:(NSString*) name
            level:(FLTrackerLevel) trackLevel 
          message:(NSString*) message;

//- (void) logEvent:(NSString*) name
//            level:(FLTrackerLevel) trackLevel 
//        exception:(NSException*) exception
//          message:(NSString*) message;
//
//- (void) logEvent:(NSString*) name
//            level:(FLTrackerLevel) trackLevel 
//            error:(NSError*) error
//          message:(NSString*) message;
//
//          

//- (void) logEvent:(NSString*) eventName
//    withException:(NSException*) error
//          message:(NSString*)  message;
//
//- (void) logEvent:(NSString*) eventName
//        withError:(NSError*) error
//          message:(NSString*)  message;
//
//- (void) logEvent:(NSString*) eventName
//   withParameters:(NSDictionary*) parameters 
//          message:(NSString*)  message;


@end

#define FLLogEvent(__EVENT__, __LEVEL__, __FORMAT__, ...) \
    [[FLTracker instance] logEvent:__EVENT__ level:__LEVEL__ message:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)]
//
//#define FLTrackException(__EVENT__, __LEVEL__, __EX__, __FORMAT__, ...) \
//    [[FLTracker instance] logEvent:__EVENT__ level:__LEVEL__ exception:__EX__ message:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) exception:__EX__ ]
//
//#define FLTrackError(__EVENT__, __LEVEL__, __ERROR__, __FORMAT__, ...) \
//    [[FLTracker instance] logEvent:__EVENT__ level:__LEVEL__ error:__ERROR__ message:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) error:__ERROR__]

//#define FLTrackWithParameters(__EVENT__, __LEVEL__, __PARMS__, __FORMAT__, ...) \
//    [[FLTracker instance] logEvent:__EVENT__ level:__LEVEL__ paramaters:message:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__) parameters:__PARMS__ ]

/*
    extern void FLLogEvent(NSString* event);
    extern void FLLogException(NSString* errorId, NSString* message, NSException* exception);
    extern void FLLogError(NSString* errorId, NSString* message, NSError* error);
    extern void FLLogEventWithParameters(NSString* event, NSDictionary* withParameters);
*/

#define FLTrackEvent(__STR__)
