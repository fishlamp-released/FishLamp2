//
//  FLHierarchicalDataViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/24/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGridViewController.h"

#import "FLHierarchicalDataModel.h"
#import "FLHierarchicalGridViewCell.h"
#import "FLHierarchicalGridViewCellView.h"

@interface FLHierarchicalGridViewController : FLGridViewController {
@private
    id _parentDataRef;
    BOOL _discloseFromLeft;
    BOOL _isChild;
}

@property (readwrite, assign, nonatomic) BOOL discloseFromLeft;

@property (readwrite, retain, nonatomic) id parentDataRef;

+ (FLHierarchicalGridViewController*) hierarchicalGridViewController;

- (void) discloseButtonPressedForCell:(FLGridCell*) cell;

- (void) willUpdateTitle; // called when parentDataRef is set.
- (void) willCreateToolbar;

@property (readonly, assign, nonatomic) BOOL isChildViewController;
- (void) willBecomeChildOfHierarchicalViewController:(FLHierarchicalGridViewController*) controller;

@end

