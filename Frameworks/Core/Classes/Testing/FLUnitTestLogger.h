//
//  FLUnitTestLogger.h
//  FishLampCore
//
//  Created by Mike Fullerton on 8/28/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCoreRequired.h"

@protocol FLStringFormatter;

@interface FLUnitTestLogger : NSObject {
@private
    NSMutableArray* _loggers;

}
FLSingletonProperty(FLUnitTestLogger);

- (void) pushLogger:(id<FLStringFormatter>) formatter
          propagate:(BOOL) propage;
          
- (void) popLogger:(BOOL) withFlush;

@end

#ifndef FLTestLog
#define FLTestLog NSLog
#endif

#ifndef FLTestLog
#define FLTestLog(__FORMAT__, ...) [self.logger appendLine:FLStringWithFormatOrNil(__FORMAT__, ##__VA_ARGS__)]
#endif
