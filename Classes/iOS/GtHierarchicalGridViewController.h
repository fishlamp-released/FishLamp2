//
//  GtHierarchicalDataViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/24/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewController.h"
#import "GtAsyncEventHandler.h"
#import "GtViewControllerStack.h"

@protocol GtHierarchicalDataProvider <NSObject>

- (void) beginLoadingChildenForDataObject:(id) dataObject
                             eventHandler:(GtAsyncEventHandler*) eventHandler; // returns array of 

- (BOOL) dataObjectHasChildren:(id) dataObject;

@end

@interface GtHeirarchicalGridViewCell : GtGridViewCellController {
}

- (void) discloseButtonPressed;
+ (GtHeirarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject;

@end

@interface GtHierarchicalGridViewController : GtGridViewController {
@private
    id m_parentObject;
    GtGridViewCellController* m_previousSelectedCell;
    GtGridViewCellController* m_selectedCell;
}

@property (readonly, assign, nonatomic) BOOL isChildViewController;

@property (readwrite, retain, nonatomic) GtGridViewCellController* previousSelectedCell;
@property (readwrite, retain, nonatomic) GtGridViewCellController* selectedCell;
- (void) selectedCellDidChange;

@property (readwrite, retain, nonatomic) id parentDataObject;

- (id) initWithDataProvider:(id) dataProvider;
- (id) initWithDataProvider:(id) dataProvider parentDataObject:(id) parentDataObject;

// optional overrides

- (UIViewController*) viewControllerForCell:(GtGridViewCellController *)cell;
- (id<GtViewControllerStackAnimation>) disclosureAnimationForCell:(GtGridViewCellController *)cell;
- (id) dataProviderForCell:(GtGridViewCellController *)cell;

- (void) discloseButtonPressedForCell:(GtGridViewCellController*) cell;
- (void) showViewControllerForCell:(GtGridViewCellController *)cell;

@end
