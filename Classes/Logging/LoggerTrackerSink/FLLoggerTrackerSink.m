//
//  FLLogSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
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
