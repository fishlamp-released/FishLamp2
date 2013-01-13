//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLTestResultCollection.h"

@interface FLUnitTestRunner : FLOperation {
}

+ (id) unitTestRunner;

// returns array of FLTestResultCollection
@end

