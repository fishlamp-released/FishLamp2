//
//  FLActionTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLActionTests.h"

@implementation FLActionTests

- (void) setupTests {
   [self.results setTestResult:[FLCountedTestResult countedTestResult:6] forKey:@"counter"];
}

- (void) runOneAction {
    FLAction* action = [FLAction action];

    [action.operations addOperationWithBlock:^(FLOperation* block) {
        FLAssert_(![NSThread isMainThread]);
        
        [[self.results testResultForKey:@"counter"] setPassed];
    }];

    FLRunner* runner = [FLRunner runner:[action startAction:^{ 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                    
                }
                finisher:[FLFinisher finisherWithBlock:^(FLFinisher* result) { 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                }]]]; 

    [actionFinisher waitUntilFinished];
 }

- (void) testBasicScheduling {
    [self runOneAction];
}

- (void) testBackgroundThreadStart {
    [[[FLDispatchQueue instance] dispatchBlock:^{
        [self runOneAction];
    }] waitUntilFinished];
}

@end