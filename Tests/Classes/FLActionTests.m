//
//  FLActionTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLActionTests.h"
#import "FLAction.h"

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
    
    dispatch_block_t actionStartBlock = ^{ 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                    
                };
    
    FLFinisher* actionFinisher = [FLFinisher finisherWithBlock:^(id result) { 
                    FLAssert_([NSThread isMainThread]); 
                    [[self.results testResultForKey:@"counter"] setPassed];
                }];
    
    
    FLFinisher* finisher = [action startAction:actionStartBlock finisher:actionFinisher]; 
    FLAssert_(finisher == actionFinisher);
    FLThrowError_([finisher waitUntilFinished]);
}

- (void) testBasicScheduling {
    [self runOneAction];
}

- (void) testBackgroundThreadStart {
//    [[[FLDispatchQueue dispatchBlock:^{
//        [self runOneAction];
//    }] waitUntilFinished];
    FLAssertFailed_v(@"fix this");
}

@end