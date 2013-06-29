//
//  FLUnitTestSubclassRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUnitTestSubclassRunner.h"

#import "FLUnitTest.h"
#import "FLUnitTestGroup.h"

@implementation FLUnitTestSubclassRunner

- (id) init {
    self = [super init];
    if(self) {
        _classList = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) unitTestSubclassRunner {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) sortClassList:(NSMutableArray*) classList {

    int i = classList.count - 1;
    while(i >= 0) {
        
        Class bottom = [classList objectAtIndex:i];
        
        int newIndex = i;
        
        for(int j = i - 1; j >= 0; j--) {
            Class top = [classList objectAtIndex:j];

            BOOL bottomDependsOnTop = [bottom unitTestClassDependsOnUnitTestClass:top];
            BOOL topDependsOnBottom = [top unitTestClassDependsOnUnitTestClass:bottom];
            
            FLConfirmWithComment(bottomDependsOnTop == NO || topDependsOnBottom == NO, @"%@ and %@ can't depend on each other", NSStringFromClass(top), NSStringFromClass(bottom));
            
            if(topDependsOnBottom) {
                newIndex = j;
            }
        }
        
        if(newIndex != i) {
            [classList removeObjectAtIndex:i];
            [classList insertObject:bottom atIndex:newIndex];
        }
        else {
            --i;
        }
    }
}

- (id) performSynchronously {
    
    NSMutableDictionary* groups = [NSMutableDictionary dictionary];
    
    for(Class aClass in _classList) {
        FLUnitTestGroup* group = [aClass unitTestGroup];
        NSMutableArray* groupClassList = [groups objectForKey:group];
        if(!groupClassList) {
            groupClassList = [NSMutableArray array];
            [groups setObject:groupClassList forKey:group];
        }
        
        [groupClassList addObject:aClass];
    }
    
    NSMutableArray* groupList = FLAutorelease([[groups allKeys] mutableCopy]);
    [groupList sortUsingComparator:^NSComparisonResult(FLUnitTestGroup* obj1, FLUnitTestGroup* obj2) {
        
        if(obj1.groupPriority == obj2.groupPriority) {
            return NSOrderedSame;
        }
    
        return obj1.groupPriority  > obj2.groupPriority ? NSOrderedAscending : NSOrderedDescending;
    }]; 
    
    [[FLUnitTest outputLog] appendLineWithFormat:@"Found %d unit test classes in %d groups", _classList.count, groupList.count];
    
    NSMutableArray* resultArray = [NSMutableArray array];
    
    for(FLUnitTestGroup* group in groupList) {
    
        [[FLUnitTest outputLog] appendLineWithFormat:@"UnitTest Group: %@ (priority: %d)", group.groupName, group.groupPriority];
        
        NSMutableArray* classList = [groups objectForKey:group];
        [self sortClassList:classList];
        
        for(Class aClass in classList) {
            FLUnitTest* test = FLAutorelease([[[aClass class] alloc] init]);

            [[FLUnitTest outputLog] indent:^{
                id results = [self runChildSynchronously:test];
                FLThrowIfError(results);
                
                [resultArray addObject:results];
            }];
                
//            if(results.testResults.count) {
//                NSArray* failedResults = [results failedResults];
//                if(failedResults && failedResults.count) {
//                    FLTestLog(@"%@: %d test cases failed", test.unitTestName, failedResults.count);
//                }
//                else {
//                    FLTestLog(@"%@: %d test cases passed", test.unitTestName, results.testResults.count);
//                }
//            }
        }
    }
    
    return resultArray;
    
// - (id) performSynchronously {
//
//    NSMutableArray* array = [NSMutableArray array];
//    NSArray* allResults = [self findUnitTests];
//    
//    for(FLUnitTest* test in tests) {
//
//        FLTestLog(@"%Running @ Test Cases:", test.unitTestName);
//
//        [[FLUnitTest logger] indent:^{
//            FLTestResultCollection* results = [self runChildSynchronously:test];
//            NSArray* failedResults = [results failedResults];
//            if(result && results.count) {
//                FLTestLog(@"%@ test cases failed", failedResults.count);
//            }
//            else {
//                FLTestLog(@"%@ test cases passed", results.count);
//            }
//            
//            [allResults addObject:results];
//        }];
//    }
//
//    return allResults;
//}   
}

#if FL_MRC
- (void) dealloc {
    [_classList release];
    [super dealloc];
}
#endif

- (void) addPossibleTestMethod:(FLRuntimeInfo) info {
}

- (void) addPossibleUnitTestClass:(FLRuntimeInfo) info {
//class_conformsToProtocol
    if(!info.isMetaClass) {
        if([NSObject superclass:[FLUnitTest class] hasSubclass:info.class]) {
            [_classList addObject:info.class];
        }
    }

}

@end
