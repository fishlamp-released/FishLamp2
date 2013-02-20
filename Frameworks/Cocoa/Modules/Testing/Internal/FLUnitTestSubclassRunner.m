//
//  FLUnitTestSubclassRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
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
            
            FLConfirm_v(bottomDependsOnTop == NO || topDependsOnBottom == NO, @"%@ and %@ can't depend on each other", NSStringFromClass(top), NSStringFromClass(bottom));
            
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

- (FLResult) runOperationInContext:(id) context withObserver:(id) observer {
    
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
    
    NSMutableArray* resultArray = [NSMutableArray array];
    
    for(FLUnitTestGroup* group in groupList) {
    
        FLLog(@"\n- GROUP: %@ (priority: %d)", group.groupName, group.groupPriority);
        
        NSMutableArray* classList = [groups objectForKey:group];
        [self sortClassList:classList];
        
        for(Class aClass in classList) {
            FLUnitTest* test = FLAutorelease([[[aClass class] alloc] init]);
            FLUnitTestResult* result = [context runWorker:test withObserver:observer];
            [resultArray addObject:result];
        }
    }
    
    return resultArray;
    
    
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
