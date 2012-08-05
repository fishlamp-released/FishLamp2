//
//  FLHierarchicalDataViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/24/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewController.h"

#import "FLHierarchicalGridViewControllerDataSource.h"
#import "FLHierarchicalGridViewCell.h"
#import "FLHierarchicalGridViewCellView.h"

@interface FLHierarchicalGridViewController : FLGridViewController {
@private
    id _parentObject;
    BOOL _discloseFromLeft;
    BOOL _isChild;
}

@property (readwrite, assign, nonatomic) BOOL discloseFromLeft;
@property (readwrite, retain, nonatomic) id parentDataObject;

+ (FLHierarchicalGridViewController*) hierarchicalGridViewController;

- (void) discloseButtonPressedForCell:(FLGridViewCell*) cell;

- (void) willUpdateTitle; // called when parentDataObject is set.
- (void) willCreateToolbar;

@property (readonly, assign, nonatomic) BOOL isChildViewController;
- (void) willBecomeChildOfHierarchicalViewController:(FLHierarchicalGridViewController*) controller;

@end

