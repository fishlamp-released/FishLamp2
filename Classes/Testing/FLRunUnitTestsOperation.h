//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLOperation.h"

@interface FLRunUnitTestsOperation : FLOperation {
@private
    FLTestVerifier* testVerifier;
    NSMutableArray* _workers;
}

+ (id) unitTestRunner;

@end