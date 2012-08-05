//
//  FLHeirarchicalGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHierarchicalGridViewCell.h"
#import "FLHierarchicalGridViewCellView.h"
#import "FLGridViewObject.h"
#import "FLHierarchicalGridViewControllerDataSource.h"
#import "FLHierarchicalGridViewController.h"

@implementation FLHierarchicalGridViewCell

- (id) initWithGridViewObject:(id) object  {
    if((self = [super initWithGridViewObject:object])) {
        self.frame = CGRectMake(0,0, 120, 50);
    }
    return self;
}

+ (FLHierarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject  {
    return FLReturnAutoreleased([[FLHierarchicalGridViewCell alloc] initWithGridViewObject:dataObject]);
}

- (UIView*) createViewForVisibleView:(FLGridViewCellVisibleView)visibleView {
    return FLReturnAutoreleased([[FLHierarchicalGridViewCellView alloc] initWithFrame:self.frame]);
}

- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(FLGridViewController*) controller {
    _discloseFromLeft = ((FLHierarchicalGridViewController*) controller).discloseFromLeft;
    [super cellWillAppearInSuperview:superview viewController:controller];
}    

    
- (void) controlStateDidChangeState:(FLControlState*) state
                       changedState:(FLControlStateMask) changedState  {
    FLHierarchicalGridViewCellView* view = self.view;
    view.selectedGradient.highlighted = YES;
    view.selectedGradient.hidden = !self.isSelected;
    view.selectedGradient.selected = self.isSelected;
    view.titleWidget.selected = self.isSelected;
    view.titleWidget.highlighted = self.isSelected;
    view.titleGradient.selected = NO;
    
    [super controlStateDidChangeState:state changedState:changedState];
}

- (void) gridViewCellView:(FLHierarchicalGridViewCellView*) view objectWasTouched:(id) touchedObject {

    if(touchedObject == view.titleGradient) {
       [self performBlockWithDelay:0.3 block: ^{
            [self.viewController cellWasSelected:self];
        }];
    }
    else if(touchedObject == view.buttonGradient) {
        view.buttonGradient.selected = NO;
        [((FLHierarchicalGridViewController*) self.viewController) discloseButtonPressedForCell:self];
    }

}

- (void) cellDidLoadView:(FLHierarchicalGridViewCellView*) view 
          forVisibleView:(FLGridViewCellVisibleView)state { 

    view.titleWidget.text = [self.gridViewObject gridViewDisplayName];
    view.titleWidget.selected = self.isSelected;
    view.titleGradient.selected = self.isSelected;
    view.selectedGradient.hidden = !self.isSelected;
    view.disclosureButtonHidden = ![self.dataProvider dataObjectHasChildren:self.gridViewObject];
    view.disclosureWidget.selected = self.isSelected;
    view.disclosureButtonOnLeft = _discloseFromLeft;
}


@end