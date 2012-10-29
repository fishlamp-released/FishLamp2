//
//  FLTestResult.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestResult.h"

@interface FLTestResult ()
@property (readwrite, strong) NSError* error;
@property (readwrite, assign) NSUInteger expectedCount;
@property (readwrite, assign) NSUInteger count;
@property (readwrite, strong) NSString* testName;
@end

@implementation FLTestResult 
@synthesize error = _error;
@synthesize expectedCount = _expectedCount;
@synthesize count = _count;
@synthesize testName = _testName;

- (void) setPassed {
    ++_count;
}

- (BOOL) passed {
    return !self.error && _count == _expectedCount;
}

#if FL_NO_ARC
- (void) dealloc {
    [_testName release];
    [_error release];
    [super dealloc];
}
#endif


- (id) initWithExpectedCount:(NSUInteger) count {
    self = [super init];
    if(self) {
        _expectedCount = count;
        self.testName = NSStringFromClass([self class]);
    }
    return self;
}

- (id) init {
    return [self initWithExpectedCount:1];
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ { testName: %@, passed: %@, error: %@ }", [super description], self.testName, self.passed ? @"YES" : @"NO", [_error description]];
}


@end

@implementation FLCountedTestResult 
@dynamic count;
@dynamic expectedCount;

+ (FLCountedTestResult*) countedTestResult:(NSUInteger) expectedCount {
    return FLReturnAutoreleased([[[self class] alloc] initWithExpectedCount:expectedCount]);
}



@end
