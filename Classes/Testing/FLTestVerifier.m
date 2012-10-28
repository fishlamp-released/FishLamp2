//
//  FLTestVerifier.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/21/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestVerifier.h"

//@interface FLTestResult ()
////@property (readwrite, strong) id what;
////@property (readwrite, strong) int result;
////@property (readwrite, strong) NSString* comment;
//@end
//
//@implementation FLTestResult
//@synthesize what = _what;
//@synthesize result = _result;
//@synthesize comment = _comment;
//
//- (id) initWithResult:(int) result what:(id) what comment:(NSString*) comment {
//    self = [super init];
//    if(self) {
//        self.what = what;
//        self.result = result;
//        self.comment = comment;
//    }
//    return self;
//}
//+ (id) testResult:(int) result what:(id) what comment:(NSString*) comment{
//    return FLReturnAutoreleased([[[self class] alloc] initWithResult:result what:what comment:(NSString*) comment]);
//}
//
//#if FL_NO_ARC
//- (void) dealloc {
//    [_comment release];
//    [_what release];
//    [super dealloc];
//}
//#endif
//
//
//@end


@implementation FLTestVerifier

@synthesize testResults = _results;

- (id) init {
    self = [super init];
    if(self) {
        _expected = [[NSMutableSet alloc] init];
        _handled = [[NSMutableSet alloc] init];
        _results = [[NSMutableArray alloc] init];
    }
    return self;
}

#if FL_NO_ARC
- (void) dealloc {
    [_expected release];
    [_results release];
    [super dealloc];
}
#endif

- (void) reset {
    @synchronized(self) {
        [_expected unionSet:_handled];
        [_handled removeAllObjects];
        [_results removeAllObjects];
    }
}

- (void) clear {
    @synchronized(self) {
        [_expected unionSet:_handled];
        [_handled removeAllObjects];
        [_results removeAllObjects];
    }
}

- (void) addExpectedSelector:(SEL) selector {
    [self addExpectedResult:NSStringFromSelector(selector)];
}

- (void) addExpectedResult:(id) expected {
    @synchronized(self) {
    
        FLConfirm_v(![_expected containsObject:expected],
                        @"test results '%@' already in expected list",
                        [expected description]);
        
        FLConfirm_v(![_results containsObject:expected],
                        @"test results '%@' already in handled list",
                        [expected description]);
        
        [_expected addObject:expected];
    }
}

- (void) addHandledSelector:(SEL) selector {
    [self addHandledResult:NSStringFromSelector(selector)];
}

- (void) addHandledResult:(id) result {
    @synchronized(self) {
        FLConfirm_v([_expected containsObject:result], @"unexpected results");
        FLConfirm_v(![_results containsObject:result], @"already got result");
        [_results addObject:result];
        [_handled addObject:result];
        [_expected removeObject:result];
    }
}

- (BOOL) checkResults {
    @synchronized(self) {
//        for(FLTestResult* result in self.testResults) {
//            if(result.result != FLTestResultPass) {
//                return NO;
//            }
//        }
    
        return _expected.count == 0 && _handled.count == _results.count;
    }
}

//- (void) addTestResult:(FLTestResult*) result {
//    [_results addObject:result];
//}

//- (void) willThrowException:(NSException*) ex {
//    [self addTestResult:[FLTestResult testResult:FLTestException what:ex comment:[ex reason]]];
//    [[self class] willThrowException:ex fromObject:self];
//}


@end
