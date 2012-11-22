//
//  TestFlightTrackerSink.h
//  TestFlightTrackerSink
//
//  Created by Mike Fullerton on 6/8/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
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
