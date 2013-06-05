//
//  FLLogFileSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLCocoaRequired.h"
#import "FishLamp.h"

#import "FLTrackerSink.h"

@interface FLLogFileTrackerSink : FLTrackerSink

FLSingletonProperty(FLLogFileTrackerSink);

@end
