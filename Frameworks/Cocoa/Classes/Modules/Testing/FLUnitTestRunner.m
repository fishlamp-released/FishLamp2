//
//  FLUnitTestRunnerBot.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTestRunner.h"
#import "FLAsyncQueue.h"
#import "FLSanityCheckRunner.h"
#import "FLUnitTestSubclassRunner.h"
#import "FLStaticTestMethodRunner.h"
#import "FLObjcRuntime.h"
#import "FLUnitTest.h"

@implementation FLUnitTestRunner 

+ (id) unitTestRunner {
    return FLAutorelease([[[self class] alloc] init]);
}

- (NSArray*) findTestWorkers {

    NSMutableArray* workers = [NSMutableArray array];
//    [workers addObject:[FLSanityCheckRunner sanityTestRunner]];
    [workers addObject:[FLUnitTestSubclassRunner unitTestSubclassRunner]];

    FLRuntimeVisitEveryClass(
        ^(FLRuntimeInfo classInfo, BOOL* stop) {
            for(id runner in workers) {
                [runner addPossibleUnitTestClass:classInfo];
            }

            FLRuntimeVisitEachSelectorInClass(classInfo.class,
                ^(FLRuntimeInfo methodInfo, BOOL* stopInner) {
                    for(id runner in workers) {
                        [runner addPossibleTestMethod:methodInfo];
                    }
                }
            );
            
        }
    );

    return workers;
}

- (FLPromisedResult) performSynchronously {

    NSMutableArray* array = [NSMutableArray array];
    NSArray* workers = [self findTestWorkers];
    for(id worker in workers) {
        id result = [self runChildSynchronously:worker];
        FLThrowIfError(result);
    
        [array addObject:result];
    }

    int errorCount = 0;
    for(NSArray* resultArray in array) {
        for(FLTestResultCollection* result in resultArray) {
            errorCount += [[result failedResults] count];
        }
    }
    
    if(errorCount) {
        
        [[FLUnitTest outputLog] appendLine:@"Unit Tests Failed"];
    
        return [NSError errorWithDomain:FLErrorDomain code:FLErrorResultFailed localizedDescription:@"Unit Tests Failed"];
    }

    [[FLUnitTest outputLog] appendLine:@"Unit Tests Passed"];

    return array;
}

@end
