//
//  FLUnitTestRunnerBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLRunUnitTestsOperation.h"

#import "FLJob.h"
#import "FLDispatchQueues.h"
#import "FLSanityCheckRunner.h"
#import "FLUnitTestSubclassRunner.h"
#import "FLStaticTestMethodRunner.h"
#import "FLObjcRuntime.h"

@interface FLRunUnitTestsOperation()
@end

@implementation FLRunUnitTestsOperation

+ (id) unitTestRunner {
    return [self create];
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

- (void) runSelf {

    NSMutableArray* array = [NSMutableArray array];
    NSArray* workers = [self findTestWorkers];
    for(id<FLWorker, FLRunnable> worker in workers) {

        FLFinisher* finisher = [worker runSynchronously];
 
        if(finisher.output) {
            [array addObject:finisher.output];
        }
    }
    
    self.operationOutput = array;
}

@end

