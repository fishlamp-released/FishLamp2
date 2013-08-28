//
//  FLTestCaseOperation.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 8/26/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseOperation.h"
#import "FLTestCaseResult.h"
#import "FLUnitTest.h"
#import "FLTestCaseRunner.h"

//#import "FLUnitTest.h"
//#import "FLObjcRuntime.h"


@implementation FLTestCaseOperation

@synthesize testCase = _testCase;

- (id) initWithTestCase:(FLTestCase*) testCase {
	self = [super init];
	if(self) {
		_testCase = FLRetain(testCase);
	}
	return self;
}

+ (id) testCaseOperation:(FLTestCase*) testCase {
   return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void)dealloc {
	[_testCase release];
	[super dealloc];
}
#endif

- (FLPromisedResult) performSynchronously {
    FLTestCaseRunner* runner = [self.testCase testRunner];
    return [runner performTestCase:self.testCase];
}


@end
