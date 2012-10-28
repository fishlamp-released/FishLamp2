//
//  FLStaticTestMethodRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLStaticTestMethodRunner.h"
#import "FLObjcRuntime.h"

@interface FLStaticTestMethodRunner ()
@property (readwrite, strong) NSArray* list;
@end

@implementation FLStaticTestMethodRunner
@synthesize list = _list;

- (id) initWithSelectorInfoList:(NSArray*) list {
    self = [super init];
    if(self) {
        self.list = list;
    }
    return self;
}

+ (id) staticTestMethodRunner:(NSArray*) selectorInfoList {
    return FLReturnAutoreleased([[FLStaticTestMethodRunner alloc] init]);
}

- (BOOL) runTestWithFinisher:(FLSelectorInfo*) info {
    __block BOOL wasRun = NO;
    
    FLFinisher* notifier = [FLFinisher finisher:^(id<FLAsyncResult> result){
        wasRun = YES;
    }];

    [info.target performSelectorSafely:info.selector
                            withObject:notifier];

    if(!wasRun) {
        NSLog(@"Test not run ([finisher setFinished] not called)");
    }

    return wasRun;
}

- (BOOL) runOneSelector:(FLSelectorInfo*) info {
    
    FLConfirmIsNotNil_(info.target);
    FLConfirmIsNotNil_(info.selector);
    
    int selectorArgCount = info.argumentCount;
    NSLog([info prettyString]);
    BOOL passed = NO;

    @try {
    
        switch(selectorArgCount) {
            
            case 2:
                [info.target performSelectorSafely:info.selector];
                passed = YES;
                break;
            
            case 3:
                passed = [self runTestWithFinisher:info];
                break;
        
            default:
                NSLog(@"SKIPPING (expecting 0 or 1 arguments, got %d", selectorArgCount);
                passed = YES;
            break;
        }
            
    }
    @catch(NSException* ex) {
        NSLog(@"FAIL: %@", [ex description]);
        passed = NO;
    }

    if(passed) {
        NSLog(@"PASS!");
    }

    return passed;
}

- (BOOL) runBatchOfMethods:(NSArray*) methods
                haltOnFail:(BOOL) haltOnFail {
    
    BOOL passed = YES;
    for(FLSelectorInfo* info in methods) {
        if(![self runOneSelector:info]) {
            passed = NO;
            if(haltOnFail) {
                return NO;
            }
        }
    }
    
    return passed;
}

- (void) startWorking:(FLFinisher*) finisher {
//    FLAssert_([self runBatchOfMethods:_sanityChecks haltOnFail:YES]);
//    FLAssert_([self runBatchOfMethods:_finishSanityChecks haltOnFail:YES]);
//    FLAssert_([self runBatchOfMethods:_selfTests haltOnFail:NO]);
    [finisher setFinished];
}

#if FL_NO_ALLOC
- (void) dealloc {
    [_list release];
    [super dealloc];
}
#endif

@end
