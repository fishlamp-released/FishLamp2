//
//  FLUnitTestSubclassRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLWorker.h"
#import "FLTestFinder.h"
#import "FLSimpleWorker.h"

@interface FLUnitTestSubclassRunner : FLSimpleWorker<FLTestFinder> {
@private
    NSMutableArray* _classList;
}
+ (id) unitTestSubclassRunner;
@end