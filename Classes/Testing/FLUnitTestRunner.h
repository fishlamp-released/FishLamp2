//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLTestResultCollection.h"
#import "FLWorker.h"

@interface FLRunUnitTestsOperation : FLOperation {
@private
}

+ (id) unitTestRunnerOperation;

@end

@interface FLUnitTestRunner : FLWorker {
}

+ (id) unitTestRunner;

+ (void) runTests;

@end

