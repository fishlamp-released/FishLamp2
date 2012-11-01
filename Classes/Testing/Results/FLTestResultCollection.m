//
//  FLTestResultCollection.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 9/1/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestResultCollection.h"

@implementation FLTestResultCollection

@synthesize testResults = _results;

- (id) init {
    self = [super init];
    if(self) {
        _results = [[NSMutableDictionary alloc] init];
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_results release];
    [super dealloc];
}
#endif

- (id) setTestResultForSelector:(SEL) selector {
    return [self setTestResultForKey:NSStringFromSelector(selector)];
}

- (id) setTestResultForNumber:(int) number {
    return [self setTestResultForKey:[NSNumber numberWithInt:number]];
}

- (id) setTestResultForKey:(id) key {
    id test = [FLTestResult create];
    [self setTestResult:test forKey:key];
    return test;
}

- (void) setTestResult:(id<FLTestResult>) result forKey:(id) key {

    FLConfirmIsNotNil_(result);
    FLConfirmIsNotNil_(key);

    @synchronized(self) {
    
        FLConfirm_v([_results objectForKey:key] == nil,
                        @"test results '%@' already in expected list",
                        key);

        [_results setObject:result forKey:key];
    }
}

- (BOOL) hasTestResultForKey:(id) key {
    return [_results objectForKey:key] != nil;
}

- (BOOL) hasTestResultForNumber:(int) number {
    return [_results objectForKey:[NSNumber numberWithInt:number]] != nil;
}

- (BOOL) hasTestResultForSelector:(SEL) selector {
    return [_results objectForKey:NSStringFromSelector(selector)] != nil;
}

- (id) testResultForSelector:(SEL) selector {
    return [self testResultForKey:NSStringFromSelector(selector)];
}

- (id) testResultForNumber:(int) number {
    return [self testResultForKey:[NSNumber numberWithInt:number]];
}

- (id) testResultForKey:(id) key {
    id result = nil;
    @synchronized(self) {
        result = [_results objectForKey:key];
    }
    FLConfirmIsNotNil_v(result, @"can't find result for %@", [key description]);
    return result;
}

- (BOOL) allTestsPassed {
    BOOL passed = YES;
    @synchronized(self) {
        for(id result in _results.objectEnumerator) {
            if(![result passed]) {
                FLLog(@"FAIL: %@", [result description]);
                passed = NO;
            }
        }
    }
    
    return passed;
}

- (NSString*) description {
    return [NSString stringWithFormat:@"%@ %@", [super description], [_results description]];
}

//- (void) addTestResult:(FLTestResult*) result {
//    [_results addObject:result];
//}

//- (void) willThrowException:(NSException*) ex {
//    [self addTestResult:[FLTestResult testResult:FLTestException what:ex comment:[ex reason]]];
//    [[self class] willThrowException:ex fromObject:self];
//}


@end


//@implementation FLTestResultCollection
//
//@synthesize results = _results;
//@synthesize runCount = _runCount;
//@synthesize failCount = _failCount;
//
//- (id) init {
//    self = [super init];
//    if(self) {
//        _results = [[NSMutableArray alloc] init];
//    }
//    
//    return self;
//}
//
//#if FL_MRC
//- (void) dealloc {
//    [_results release];
//    [super dealloc];
//}
//#endif
//
//+ (FLTestResultCollection*) testResultList {
//    return autorelease_([[FLTestResultCollection alloc] init]);
//}
//
//- (void) addTestResult:(id<FLTestResult>) result {
//    [_results addObject:result];
//    if(result.didRun) {
//        ++_runCount;
//    
//        if(!result.didPass) {
//            ++_failCount;
//        }
//    }
//}
//
//- (BOOL) didRun {
//    return _results.count > 0; 
//}
//
//- (BOOL) didPass {
//    return _failCount == 0;
//}
//
//- (NSString*) runSummary {
//    
//    return nil;
//}
//
//- (NSString*) failureDescription {
//
//    return nil;
//}
//
//- (NSString*) testName {
//    return nil;
//}
//
//
//@end

