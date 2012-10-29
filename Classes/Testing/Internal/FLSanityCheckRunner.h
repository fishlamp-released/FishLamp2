//
//  FLSanityCheckRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"
#import "FLTestFinder.h"

@interface FLSanityCheckRunner : FLSimpleWorker<FLTestFinder> {
@private
    NSMutableSet* _sanityTests;
}
+ (FLSanityCheckRunner*) sanityTestRunner;
@end


@interface NSObject (FLUnitTest)
+ (void) addTestCasesToSanityChecks:(NSMutableSet*) testCases;
@end