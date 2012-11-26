//
//  FLTrackerSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

typedef enum {
    FLTrackerSinkEventMessages          = (1 << 1),
    FLTrackerSinkEventExceptions        = (1 << 2),
    FLTrackerSinkEventErrors            = (1 << 3),
    FLTrackerSinkEventWithParameters    = (1 << 4),
    
    FLTrackerSinkEventsAll              =   FLTrackerSinkEventMessages | 
                                            FLTrackerSinkEventExceptions | 
                                            FLTrackerSinkEventErrors | 
                                            FLTrackerSinkEventWithParameters
} FLTrackerSinkEventMask;

typedef enum {
    FLTrackerLevelNone          = 0,
    FLTrackerLevelEvent         = (1 << 1),
    FLTrackerLevelAnalytic      = (1 << 2),
    FLTrackerLevelDiagnostic    = (1 << 3),
    
    FLTrackerLevelMinimum       = FLTrackerLevelEvent,
    FLTrackerLevelNormal        = FLTrackerLevelEvent | FLTrackerLevelAnalytic,
    FLTrackerLevelAll           = FLTrackerLevelEvent | FLTrackerLevelAnalytic | FLTrackerLevelDiagnostic
} FLTrackerLevel;


@protocol FLTrackerSink <NSObject>

@property (readwrite, assign) FLTrackerLevel trackLevel;

@property (readwrite, assign) FLTrackerSinkEventMask subscribedEvents;

@property (readwrite, assign, getter = isDisabled) BOOL disabled;

- (void) logEvent:(NSString*) eventName 
          message:(NSString*) message;

//- (void) logEvent:(NSString*) eventName
//    exception:(NSException*) exception
//          message:(NSString*)  message;
//
//- (void) logEvent:(NSString*) eventName
//        error:(NSError*) error
//          message:(NSString*)  message;

//- (void) logEvent:(NSString*) eventName
//   withParameters:(NSDictionary*) parameters 
//          message:(NSString*)  message;

@end


@interface FLTrackerSink : NSObject<FLTrackerSink> {
@private    
    BOOL _disabled;
    FLTrackerSinkEventMask _subscribedEvents;
    FLTrackerLevel _trackLevel;
}

@end

