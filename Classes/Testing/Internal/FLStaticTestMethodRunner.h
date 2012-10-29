//
//  FLStaticTestMethodRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLSimpleWorker.h"

@interface FLStaticTestMethodRunner : FLSimpleWorker {
@private
    NSMutableArray* _list;
}
+ (id) staticTestMethodRunner:(NSArray*) selectorInfoList;
@end