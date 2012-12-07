//
//  FLUnitTestRunnerBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestRunner.h"
#import "FLDispatchQueue.h"
#import "FLSanityCheckRunner.h"
#import "FLUnitTestSubclassRunner.h"
#import "FLStaticTestMethodRunner.h"
#import "FLObjcRuntime.h"

@interface FLRunUnitTestsOperation()
@end

@implementation FLRunUnitTestsOperation

+ (id) unitTestRunnerOperation {
    return FLAutorelease([[[self class] alloc] init]);
}

- (FLResult) runSelf {
    FLUnitTestRunner* runner = [FLUnitTestRunner unitTestRunner];
    return [runner runAllTests];
}

@end

@implementation FLUnitTestRunner 

+ (id) unitTestRunner {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSArray*) findTestWorkers {

    NSMutableArray* workers = [NSMutableArray array];
//    [workers addObject:[FLSanityCheckRunner sanityTestRunner]];
    [workers addObject:[FLUnitTestSubclassRunner unitTestSubclassRunner]];

    FLRuntimeClassVisitor classVisitor = ^(FLRuntimeInfo classInfo, BOOL* stop) {
        for(id runner in workers) {
            [runner addPossibleUnitTestClass:classInfo];
        }

        [NSObject visitEachSelectorInClass:classInfo.class visitor:^(FLRuntimeInfo methodInfo, BOOL* stopInner) {
            for(id runner in workers) {
                [runner addPossibleTestMethod:methodInfo];
            }
        }];
        
    };

    [NSObject visitEveryClass:classVisitor];
    
    return workers;
}

- (NSArray*) runTestWorkers:(NSArray*) testWorkers {
    NSMutableArray* array = [NSMutableArray array];
    NSArray* workers = [self findTestWorkers];
    for(id worker in workers) {
        FLResult result = [worker runTests];
        [array addObject:result];
    }
    return array;
}

- (NSArray*) runAllTests {
    return [self runTestWorkers:[self findTestWorkers]];
}

@end
