
//
//  FLTestResultList.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestResultList.h"

@implementation FLTestResultList

@synthesize results = _results;
@synthesize runCount = _runCount;
@synthesize failCount = _failCount;

- (id) init {
    self = [super init];
    if(self) {
        _results = [[NSMutableArray alloc] init];
    }
    
    return self;
}

#if FL_NO_ARC
- (void) dealloc {
    [_results release];
    [super dealloc];
}
#endif

+ (FLTestResultList*) testResultList {
    return FLReturnAutoreleased([[FLTestResultList alloc] init]);
}

- (void) addTestResult:(id<FLTestResult>) result {
    [_results addObject:result];
    if(result.didRun) {
        ++_runCount;
    
        if(!result.didPass) {
            ++_failCount;
        }
    }
}

- (BOOL) didRun {
    return _results.count > 0; 
}

- (BOOL) didPass {
    return _failCount == 0;
}

- (NSString*) runSummary {
    
    return nil;
}

- (NSString*) failureDescription {

    return nil;
}

- (NSString*) testName {
    return nil;
}


@end