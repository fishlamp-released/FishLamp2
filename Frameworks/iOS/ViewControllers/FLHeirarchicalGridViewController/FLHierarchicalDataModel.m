//
//  FLHierarchicalDataModel.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/10/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHierarchicalDataModel.h"

@implementation FLAction (FLHierarchicalDataModel)

- (NSArray*) loadChildrenResult {
    return FLAssertObjectIsType(self.result, NSArray);
}

@end
