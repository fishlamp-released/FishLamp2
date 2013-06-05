//
//  FLLogSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLLoggerTrackerSink.h"

@implementation FLLoggerTrackerSink

FLSynthesizeSingleton(FLLoggerTrackerSink);

- (void) trackEvent:(NSString*) message {
}

- (void) logEvent:(NSString*) eventName 
          message:(NSString*) message {

    FLLog(@"[%@]: %@", eventName, message);
}          


@end
