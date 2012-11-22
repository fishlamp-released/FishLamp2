//
//  FLLogSink.h
//  FishLampCocoa
//
//  Created by Mike Fullerton on 6/7/12.
//  Copyright (c) 2012 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"
#import "FLTrackerSink.h"

@interface FLLoggerTrackerSink : FLTrackerSink
FLSingletonProperty(FLLoggerTrackerSink);
@end
