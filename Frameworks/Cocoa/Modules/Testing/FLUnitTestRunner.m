//
//  FLUnitTestRunnerBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestRunner.h"
#import "FLAsyncQueue.h"
#import "FLSanityCheckRunner.h"
#import "FLUnitTestSubclassRunner.h"
#import "FLStaticTestMethodRunner.h"
#import "FLObjcRuntime.h"

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

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {

    NSMutableArray* array = [NSMutableArray array];
    NSArray* workers = [self findTestWorkers];
    for(id worker in workers) {
        [array addObject:[context runWorker:worker withObserver:observer]];
    }

    return array;
}

@end
