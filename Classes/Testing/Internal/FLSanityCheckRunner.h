//
//  FLSanityCheckRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLAsyncWorker.h"
#import "FLUnitTestDiscovery.h"

@interface FLSanityCheckRunner : NSObject<FLAsyncWorker, FLUnitTestDiscovery> {
@private
    NSMutableSet* _sanityTests;
}
+ (FLSanityCheckRunner*) sanityTestRunner;
@end


@interface NSObject (FLUnitTest)
+ (void) addTestCasesToSanityChecks:(NSMutableSet*) testCases;
@end