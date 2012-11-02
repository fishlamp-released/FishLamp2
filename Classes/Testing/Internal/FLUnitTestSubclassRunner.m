//
//  FLUnitTestSubclassRunner.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLUnitTestSubclassRunner.h"

#import "FLUnitTest.h"

@implementation FLUnitTestSubclassRunner

- (id) init {
    self = [super init];
    if(self) {
        _classList = [[NSMutableArray alloc] init];
    }
    return self;
}

+ (id) unitTestSubclassRunner {
    return [self create];
}

- (void) startWorking:(id<FLFinisher>) finisher {
    
    [_classList sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        
        NSInteger lhs = [[obj1 unitTestGroup] groupPriority];
        NSInteger rhs = [[obj2 unitTestGroup] groupPriority];
        
        if(lhs == rhs) {
            return [NSStringFromClass(obj1) compare:NSStringFromClass(obj2)];
        }

        return lhs > rhs ? NSOrderedAscending: NSOrderedDescending;
    }];
    
    for(Class aClass in _classList) {
        FLUnitTest* test = autorelease_([[[aClass class] alloc] init]);
        [test runSynchronously];
    }
    [finisher setFinished];
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
