//
//  FLStaticTestMethodRunner.h
//  FishLamp
//
//  Created by Mike Fullerton on 10/24/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

@interface FLStaticTestMethodRunner : NSObject {
@private
    NSMutableArray* _list;
}
+ (id) staticTestMethodRunner:(NSArray*) selectorInfoList;
@end