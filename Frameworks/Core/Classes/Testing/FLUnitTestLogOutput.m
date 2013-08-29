//
//  FLUnitTestLogOutput.m
//  FishLampCore
//
//  Created by Mike Fullerton on 8/29/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestLogOutput.h"
#import "FLStringFormatter.h"

@implementation FLUnitTestLogOutput

@synthesize stringFormatter = _stringFormatter;
@synthesize logLevel = _logLevel;

- (id) initWithStringFormatter:(id<FLStringFormatter>) formatter logLevel:(FLUnitTestLogLevel) logLevel {
	self = [super init];
	if(self) {
        _stringFormatter = FLRetain(formatter);
        _logLevel = logLevel;
	}
	return self;
}

+ (id) unitTestLogOutput:(id<FLStringFormatter>) stringFormatter logLevel:(FLUnitTestLogLevel) logLevel{
   return FLAutorelease([[[self class] alloc] initWithStringFormatter:stringFormatter logLevel:logLevel]);
}

#if FL_MRC
- (void)dealloc {
	[_stringFormatter release];
	[super dealloc];
}
#endif

- (BOOL) willLogWithLevel:(FLUnitTestLogLevel) logLevel {

    if(self.logLevel == FLUnitTestLogLevelAll) {
        return YES;
    }

    return self.logLevel == logLevel;

}
@end
