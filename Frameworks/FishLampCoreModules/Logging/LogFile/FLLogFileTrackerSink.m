//
//  FLLogFileSink.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import "FLLogFileTrackerSink.h"
#import "FLLogFileManager.h"

@implementation FLLogFileTrackerSink

FLSynthesizeSingleton(FLLogFileTrackerSink);

- (void) trackEvent:(NSString*) message {
    [[FLLogFileManager instance] logString:message];
}

- (void) logEvent:(NSString*) eventName 
          message:(NSString*) message {
//    [[FLLogFileManager instance] logString:[NSString stringWithString:@"[%@]: %@", eventName, message];
}
          
          




@end
