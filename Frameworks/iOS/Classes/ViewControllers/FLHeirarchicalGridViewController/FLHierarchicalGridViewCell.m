//
//  FLHeirarchicalGridViewCell.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 4/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLHierarchicalGridViewCell.h"
#import "FLHierarchicalGridViewCellView.h"
#import "FLGridViewObject.h"
#import "FLHierarchicalDataModel.h"
#import "FLHierarchicalGridViewController.h"

@implementation FLHierarchicalGridViewCell

- (id) initWithDataRef:(id) object  {
    if((self = [super initWithDataRef:object])) {
        self.frame = CGRectMake(0,0, 120, 50);
    }
    return self;
}

+ (FLHierarchicalGridViewCell*) hierarchicalGridViewCell:(id) dataObject  {
    return FLAutorelease([[FLHierarchicalGridViewCell alloc] initWithDataRef:dataObject]);
}

- (UIView*) createViewForGridCellState:(FLGridCellState)visibleViewID {
    return FLAutorelease([[FLHierarchicalGridViewCellView alloc] initWithFrame:self.frame]);
}

//- (void) cellWillAppearInSuperview:(UIView*) superview 
//                    viewController:(FLGridViewController*) controller {
//    _discloseFromLeft = ((FLHierarchicalGridViewController*) controller).discloseFromLeft;
//    [super cellWillAppearInSuperview:superview viewController:controller];
//}    

    
//- (void) controlStateDidChangeState:(FLControlState*) state
//                       changedState:(FLControlStateMask) changedState  {
//    FLHierarchicalGridViewCellView* view = self.view;
//    view.selectedGradient.highlighted = YES;
//    view.selectedGradient.hidden = !self.isSelected;
//    view.selectedGradient.selected = self.isSelected;
//    view.titleWidget.selected = self.isSelected;
//    view.titleWidget.highlighted = self.isSelected;
//    view.titleGradient.selected = NO;
//    
//    [super controlStateDidChangeState:state changedState:changedState];
//}

- (void) objectWasTouched:(id) touchedObject {

    FLHierarchicalGridViewCellView* view = (FLHierarchicalGridViewCellView*) self.view;

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

- (void) didShowView {

    [super didShowView];
    
    FLHierarchicalGridViewCellView* view = (FLHierarchicalGridViewCellView*) self.view;
    view.titleWidget.text = [self.cellDataRef gridViewDisplayName];
    view.titleWidget.selected = self.isSelected;
    view.titleGradient.selected = self.isSelected;
    view.selectedGradient.hidden = !self.isSelected;
    view.disclosureButtonHidden = ![self.dataModel dataObjectHasChildren:self.cellDataRef];
    view.disclosureWidget.selected = self.isSelected;
    view.disclosureButtonOnLeft = _discloseFromLeft;
}


@end