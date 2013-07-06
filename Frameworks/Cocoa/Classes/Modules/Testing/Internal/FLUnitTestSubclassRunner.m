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

- (NSDictionary*) sortClassesIntoGroups:(NSArray*) classList {
    NSMutableDictionary* groups = [NSMutableDictionary dictionary];
    for(Class aClass in classList) {
        FLUnitTestGroup* group = [aClass unitTestGroup];
        NSMutableArray* groupClassList = [groups objectForKey:group];
        if(!groupClassList) {
            groupClassList = [NSMutableArray array];
            [groups setObject:groupClassList forKey:group];
        }
        
        [groupClassList addObject:aClass];
    }
    return groups;
}

- (NSArray*) sortedGroupListWithGroupDictionary:(NSDictionary*) groups {
    return [[groups allKeys] sortedArrayUsingComparator:
        ^NSComparisonResult(FLUnitTestGroup* obj1, FLUnitTestGroup* obj2) {
        if(obj1.groupPriority == obj2.groupPriority) {
            return NSOrderedSame;
        }
    
        return obj1.groupPriority  > obj2.groupPriority ? NSOrderedAscending : NSOrderedDescending;
    }];
}

- (NSArray*) classListWithRemovingBaseClasses:(NSArray*) classList {
    NSMutableArray* newList = [NSMutableArray array];

    for(NSInteger i = 0; i < classList.count; i++) {
        Class outerClass = [classList objectAtIndex:i];

        BOOL foundSubclass = NO;

        for(NSInteger j = i + 1; j < classList.count; j++) {
            Class innerClass = [classList objectAtIndex:j];

            if( [innerClass isSubclassOfClass:outerClass]) {
                foundSubclass = YES;
                break;
            }

        }

        if(!foundSubclass) {
            [newList addObject:outerClass];
        }
    }

    return newList;
}

- (FLPromisedResult) performSynchronously {

    NSArray* allClassesList = [self classListWithRemovingBaseClasses:_classList];
    
    NSDictionary* groups = [self sortClassesIntoGroups:allClassesList];

    NSArray* groupList = [self sortedGroupListWithGroupDictionary:groups];

    [[FLUnitTest outputLog] appendLineWithFormat:@"Found %d unit test classes in %d groups", allClassesList.count, groupList.count];
    
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
    
// - (FLPromisedResult) performSynchronously {
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
        if(FLRuntimeClassHasSubclass([FLUnitTest class], info.class)) {
            [_classList addObject:info.class];
        }
    }

}

@end
