//
//  FLHeirarchicalGridViewControllerDataProvider.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAction.h"

@protocol FLHierarchicalDataModel <NSObject>

- (FLAction*) rootObjectLoader;

- (FLAction*) childrenLoaderWithParentObject:(id) parentObject;

- (id) parentDataObjectForDataObject:(id) dataObject;

- (BOOL) dataObjectHasChildren:(id) dataObject;

@end


@interface FLAction (FLHierarchicalDataModel)

- (NSArray*) loadChildrenResult;

@end