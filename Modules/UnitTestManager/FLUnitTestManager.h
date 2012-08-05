//
//	FLUnitTestManager.h
//	WreckingBall
//
//	Created by Mike Fullerton on 9/12/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//
#import "FishLampCore.h"

@class FLUnitTest;
@class FLUnitTestGroup;

@protocol FLUnitTestManagerDelegate;

@interface FLUnitTestManager : NSObject {
    __weak id<FLUnitTestManagerDelegate> _delegate;
}

@property (readwrite, weak, nonatomic) id<FLUnitTestManagerDelegate> delegate;

+ (FLUnitTestManager*) unitTestManager;

- (void) runTests;
@end

@protocol FLUnitTestManagerDelegate <NSObject> 

- (BOOL) unitTestManager:(FLUnitTestManager*) manager 
shouldDiscoverTestsInGroup:(FLUnitTestGroup*) group;

- (BOOL) unitTestManager:(FLUnitTestManager*) manager 
      shouldDiscoverTest:(FLUnitTest*) test 
                 inGroup:(FLUnitTestGroup*) group;

- (void) unitTestManager:(FLUnitTestManager*) manager 
didDiscoverTestsInGroups:(NSArray*) arrayOfGroups 
               testCount:(NSInteger) testCount;

- (void) unitTestManager:(FLUnitTestManager*) manager 
     willRunTestsInGroup:(FLUnitTestGroup*) group;

- (void) unitTestManager:(FLUnitTestManager*) manager 
      didRunTestsInGroup:(FLUnitTestGroup*) group;

- (void) unitTestManager:(FLUnitTestManager*) manager 
             willRunTest:(FLUnitTest*) test 
                 inGroup:(FLUnitTestGroup*) group;

- (void) unitTestManager:(FLUnitTestManager*) manager 
              didRunTest:(FLUnitTest*) test 
                 inGroup:(FLUnitTestGroup*) group;

- (void) unitTestManager:(FLUnitTestManager*) manager 
               logOutput:(NSString*) output;

@end