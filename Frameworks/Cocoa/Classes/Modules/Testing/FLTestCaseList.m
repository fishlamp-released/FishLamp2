//
//  FLTestCaseList.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 7/4/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLTestCaseList.h"
#import "FLTestCaseResult.h"
#import "FLObjcRuntime.h"
#import "FLUnitTest.h"
#import "FLTestCase.h"
#import "FLTestResultCollection.h"


@implementation FLTestCaseList

- (id) init {	
	self = [super init];
	if(self) {
        _testCases = [[NSMutableArray alloc] init];

	}
	return self;
}

+ (id) testCaseList {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void)dealloc {
    [_testCases release];
	[super dealloc];
}
#endif

- (FLTestCase*) findTestCaseForName:(NSString*) name {

    for(FLTestCase* testCase in _testCases) {
        if([testCase.testCaseName isEqual:name]) {
            return testCase;
        }
    }
    
    return nil;
}
- (FLTestCase*) findTestCaseForSelector:(SEL) selector {
    for(FLTestCase* testCase in _testCases) {
        if(FLSelectorsAreEqual(testCase.testCaseSelector, selector)) {
            return testCase;
        }
    }
    
    return nil;
}

- (void) addTestCase:(FLTestCase*) testCase {
    [_testCases addObject:testCase];

    [_testCases sortUsingComparator:^NSComparisonResult(FLTestCase* obj1, FLTestCase* obj2) {
        NSString* lhs = NSStringFromSelector(obj1.testCaseSelector);
        NSString* rhs = NSStringFromSelector(obj2.testCaseSelector);

        if( [lhs rangeOfString:@"first" options:NSCaseInsensitiveSearch].length > 0 ||
            [rhs rangeOfString:@"last" options:NSCaseInsensitiveSearch].length > 0) {
            return NSOrderedAscending;
        }
        else if ([rhs rangeOfString:@"first" options:NSCaseInsensitiveSearch].length > 0 ||
                 [lhs rangeOfString:@"last" options:NSCaseInsensitiveSearch].length > 0) {
            return NSOrderedDescending;
        }

        return [lhs compare:rhs];
    }];
}

- (NSUInteger)countByEnumeratingWithState:(NSFastEnumerationState *)state objects:(id __unsafe_unretained [])buffer count:(NSUInteger)len {
    return [_testCases countByEnumeratingWithState:state objects:buffer count:len];
}


@end
