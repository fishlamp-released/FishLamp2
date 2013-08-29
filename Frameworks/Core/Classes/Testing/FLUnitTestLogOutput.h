//
//  FLUnitTestLogOutput.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"
#import "FLUnitTestDefines.h"
@protocol FLStringFormatter;

@interface FLUnitTestLogOutput : NSObject {
@private
    id<FLStringFormatter> _stringFormatter;
    FLUnitTestLogLevel _logLevel;
}

@property (readonly, strong) id<FLStringFormatter> stringFormatter;
@property (readonly, assign) FLUnitTestLogLevel logLevel;

+ (id) unitTestLogOutput:(id<FLStringFormatter>) stringFormatter
                logLevel:(FLUnitTestLogLevel) logLevel;

- (BOOL) willLogWithLevel:(FLUnitTestLogLevel) logLevel;

@end
