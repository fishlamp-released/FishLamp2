//
//  TestFlightTrackerSink.h
//  TestFlightTrackerSink
//
//  Created by Mike Fullerton on 6/8/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLTrackerSink.h"

@interface FLTestFlightTrackerSink : NSObject<FLTrackerSink> {
@private
    BOOL _disabled;
    FLTrackerSinkEventMask _subscribedEvents;
    FLTrackerLevel _trackLevel;
}

+ (FLTestFlightTrackerSink*) testFlightTrackerSink;

@end
