//
//  FLOperationUnitTest.m
//  FishLampFrameworks
//
//  Created by Mike Fullerton on 8/25/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLOperationUnitTest.h"
#import "FLOperation.h"

@implementation FLOperation (Tests)

//- (void) assertNotRun {
//    FLAssertIsFalseWithComment(self.wasCancelled, nil);
//    FLAssertIsFalseWithComment(self.wasStarted, nil);
//    FLAssertIsFalseWithComment(self.isFinished, nil);
//    FLAssertIsFalseWithComment(self.didSucceed, nil);
//    FLAssertIsNilWithComment(self.error, nil);
//}
//
//- (void) assertRanOk {
//    FLAssertIsFalseWithComment(self.wasCancelled, nil);
//    FLAssertIsTrueWithComment(self.wasStarted, nil);
//    FLAssertIsTrueWithComment(self.isFinished, nil);
//    FLAssertIsTrueWithComment(self.didSucceed, nil);
//    FLAssertIsNilWithComment(self.error, nil);
//}
//
//- (void) assertNotInQueue {
////    FLAssertIsNilWithComment(self.operationQueue, nil);
//}
//
//- (void) assertInQueue {
////    FLAssertIsNotNilWithComment(self.operationQueue, nil);
//}
//
//- (void) assertWasCancelled {
//    FLAssertIsKindOfClassWithComment(self.error, NSError, nil);
//    FLAssertIsTrueWithComment(self.wasCancelled, nil);
//}

@end

@implementation FLOperationUnitTest

+ (FLUnitTestGroup*) unitTestGroup {
    return [FLUnitTest frameworkTestGroup];
}

- (void) testSimpleCase {
    FLOperation* op = FLAutorelease([[FLSynchronousOperation alloc] init]);
    FLThrowIfError([op runSynchronously]);
}

- (void) testInQueue {

//    FLSynchronousOperationQueueOperation* q = [FLSynchronousOperationQueueOperation operationQueue];
//    [q assertNotRun];
//    [q assertNotInQueue];
//
//    FLOperation* op = [FLOperation operation];
//    
//    
//    [op assertNotRun];
//    [op assertNotInQueue];
//
//    [q queueOperation:op];
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
