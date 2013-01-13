//
//  FLUnitTestSubclassRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLTestFinder.h"
#import "FLOperation.h"

@interface FLUnitTestSubclassRunner : FLOperation<FLTestFinder> {
@private
    NSMutableArray* _classList;
}
+ (id) unitTestSubclassRunner;

@end