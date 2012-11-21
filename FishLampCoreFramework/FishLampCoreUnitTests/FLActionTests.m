//
//  FLActionTests.m
//  FishLampCore
//
//  Created by Mike Fullerton on 11/15/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLActionTests.h"
#import "FLAction.h"
#import "FLDispatchQueues.h"

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
    
    action.starting = ^(FLAction* theAction){ 
        FLAssert_([NSThread isMainThread]); 
        [[self.results testResultForKey:@"counter"] setPassed];
        
    };
    
    action.finished = ^(FLAction* theAction) {
        FLAssert_([NSThread isMainThread]); 
        [[self.results testResultForKey:@"counter"] setPassed];
    };
    
    FLFinisher* finisher = [action startAction]; 
    [finisher waitUntilFinished];
    FLThrowError_(finisher.result);
}

- (void) testBasicScheduling {
    [self runOneAction];
}

- (void) testBackgroundThreadStart {
    [[FLDispatchQueue dispatchBlock:^{
        [self runOneAction];
    }] waitUntilFinished];
}

@end