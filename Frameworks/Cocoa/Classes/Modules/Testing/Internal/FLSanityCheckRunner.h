//
//  FLSanityCheckRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
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