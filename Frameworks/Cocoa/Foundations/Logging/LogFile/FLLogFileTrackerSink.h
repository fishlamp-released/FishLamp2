//
//  FLLogFileSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FLCore.h"

#import "FLTrackerSink.h"

@interface FLLogFileTrackerSink : FLTrackerSink

FLSingletonProperty(FLLogFileTrackerSink);

@end
