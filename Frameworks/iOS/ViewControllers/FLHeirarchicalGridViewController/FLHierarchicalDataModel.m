//
//  FLHierarchicalDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLHierarchicalDataModel.h"

@implementation FLAction (FLHierarchicalDataModel)

- (NSArray*) loadChildrenResult {
    return FLAssertObjectIsType(self.result, NSArray);
}

@end
