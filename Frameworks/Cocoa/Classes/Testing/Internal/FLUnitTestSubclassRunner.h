//
//  FLUnitTestSubclassRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestFinder.h"
#import "FLSynchronousOperation.h"

@interface FLUnitTestSubclassRunner : FLSynchronousOperation<FLTestFinder> {
@private
    NSMutableArray* _classList;
}
+ (id) unitTestSubclassRunner;

@end