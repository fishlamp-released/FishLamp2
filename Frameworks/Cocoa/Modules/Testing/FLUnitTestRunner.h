//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSynchronousOperation.h"
#import "FLTestResultCollection.h"

@interface FLUnitTestRunner : FLSynchronousOperation {
}

+ (id) unitTestRunner;

// returns array of FLTestResultCollection
@end

