//
//  FLSanityCheckRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestFinder.h"
#import "FLSynchronousOperation.h"

@interface FLSanityCheckRunner : FLSynchronousOperation<FLTestFinder> {
@private
    NSMutableSet* _sanityTests;
}
+ (id) sanityTestRunner;
@end


@interface NSObject (FLUnitTest)
+ (void) addTestCasesToSanityChecks:(NSMutableSet*) testCases;
@end