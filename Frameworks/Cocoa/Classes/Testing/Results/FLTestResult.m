//
//  FLTestResult.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/18/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLTestResult.h"

@interface FLTestResult ()
@property (readwrite, strong, nonatomic) NSError* error;
@property (readwrite, assign, nonatomic) NSUInteger expectedCount;
@property (readwrite, assign, nonatomic) NSUInteger count;
@property (readwrite, strong, nonatomic) NSString* testName;
@end

@implementation FLTestResult 
@synthesize error = _error;
@synthesize expectedCount = _expectedCount;
@synthesize count = _count;
@synthesize testName = _testName;

+ (id) testResult {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) setPassed {
    ++_count;
}

- (BOOL) passed {
    return !self.error && _count == _expectedCount;
}

#if FL_MRC
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
    return [NSString stringWithFormat:@"%@ { testName: %@, passed: %@, error: %@ }", [super description], self.testName, self.passed ? @"YES" : [NSString stringWithFormat:@"NO (%d of %d)", (int)_count, (int)_expectedCount], 
            [_error description]];
}


@end

@implementation FLCountedTestResult 
@dynamic count;
@dynamic expectedCount;

+ (id) countedTestResult:(NSUInteger) expectedCount {
    return FLAutorelease([[[self class] alloc] initWithExpectedCount:expectedCount]);
}

@end
