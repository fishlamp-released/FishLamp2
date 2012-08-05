//
//  FLHeirarchicalGridViewControllerDataProvider.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLAsyncEventHandler.h"

@protocol FLHierarchicalGridViewControllerDataSource <NSObject>

- (void) beginLoadingRootObject:(FLAsyncEventHandler*) eventHandler;

- (void) beginLoadingChildenForDataObject:(id) dataObject
                             eventHandler:(FLAsyncEventHandler*) eventHandler; // returns array of 

- (id) parentDataObjectForDataObject:(id) dataObject;

- (BOOL) dataObjectHasChildren:(id) dataObject;

@end
