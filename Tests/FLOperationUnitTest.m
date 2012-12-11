//
//  FLOperationUnitTest.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/25/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperationUnitTest.h"
#import "FLOperation.h"
#import "FLOperationQueue.h"

@implementation FLOperation (Tests)

//- (void) assertNotRun {
//    FLAssertIsFalse_v(self.wasCancelled, nil);
//    FLAssertIsFalse_v(self.wasStarted, nil);
//    FLAssertIsFalse_v(self.isFinished, nil);
//    FLAssertIsFalse_v(self.didSucceed, nil);
//    FLAssertIsNil_v(self.error, nil);
//}
//
//- (void) assertRanOk {
//    FLAssertIsFalse_v(self.wasCancelled, nil);
//    FLAssertIsTrue_v(self.wasStarted, nil);
//    FLAssertIsTrue_v(self.isFinished, nil);
//    FLAssertIsTrue_v(self.didSucceed, nil);
//    FLAssertIsNil_v(self.error, nil);
//}
//
//- (void) assertNotInQueue {
////    FLAssertIsNil_v(self.operationQueue, nil);
//}
//
//- (void) assertInQueue {
////    FLAssertIsNotNil_v(self.operationQueue, nil);
//}
//
//- (void) assertWasCancelled {
//    FLAssertIsKindOfClass_v(self.error, NSError, nil);
//    FLAssertIsTrue_v(self.wasCancelled, nil);
//}

@end

@implementation FLOperationUnitTest


- (void) testSimpleCase {
    FLOperation* op = [FLOperation operation];
    FLThrowError([op runSynchronously]);
}

- (void) testInQueue {

//    FLOperationQueue* q = [FLOperationQueue operationQueue];
//    [q assertNotRun];
//    [q assertNotInQueue];
//
//    FLOperation* op = [FLOperation operation];
//    
//    
//    [op assertNotRun];
//    [op assertNotInQueue];
//
//    [q addOperation:op];
//    [op assertNotRun];
//    [op assertInQueue];
//    
//    [q run];
//    
//    [op assertInQueue];
//    [op assertRanOk];
//    [q assertRanOk];
    
//    [op assertWasCancelled];
}
@end
