//
//  FLUnitTestRunnerBot.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/19/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSynchronousOperation.h"
#import "FLTestResultCollection.h"

@interface FLUnitTestRunner : FLSynchronousOperation {
}

+ (id) unitTestRunner;

// returns array of FLTestResultCollection
@end

