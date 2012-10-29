//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"
#import "FLTestResultCollection.h"

@interface FLRunUnitTestsOperation : FLOperation {
@private
    NSMutableArray* _workers;
    NSMutableArray* _results;
}

+ (id) unitTestRunner;

@end