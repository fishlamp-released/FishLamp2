//
//  FLHierarchicalDataViewController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 2/24/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLHierarchicalGridViewController.h"
#import "FLArrangement.h"

#import "FLGradientButton.h"
#import "FLToolbarView.h"
#import "SDKImage+Colorize.h"
#import "FLToolbarView.h"

#import "FLViewControllerStack.h"
#import "FLProgressViewController.h"
#import "FLVerticalGridArrangement.h"
#import "FLToolbarTitleView.h"
#import "FLImageButtonToolbarItem.h"

@implementation FLHierarchicalGridViewController 

@synthesize parentDataRef = _parentDataRef;
@synthesize discloseFromLeft = _discloseFromLeft;
@synthesize isChildViewController = _isChild;

- (id) init {
    self = [super init];
    if(self) {
        self.arrangement = [FLVerticalGridArrangement verticalGridArrangement];
    }
    
    return self;
}

+ (FLHierarchicalGridViewController*) hierarchicalGridViewController {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) willBecomeChildOfHierarchicalViewController:(FLHierarchicalGridViewController*) controller {
    _isChild = YES;
    _discloseFromLeft = controller.discloseFromLeft;
}

- (void) willCreateToolbar {
    FLToolbarView* toolbar = [FLToolbarView toolbarView];
    
    FLToolbarTitleView* title = [FLToolbarTitleView toolbarTitleView];
    [title setGrayText];
    [title toolbarTitleDidChange:self.title];
    
    [toolbar.rightItems addToolbarItem:title];
    [toolbar addFramedBlackBackground];
    
    self.topBarView = toolbar; 
    
    self.viewContentsDescriptor = [FLViewContentsDescriptor descriptorWithTopStatusAndToolbar]; 
}

- (void) viewDidLoad {
    [super viewDidLoad];
    
//    FLGradientView* gradient = FLAutorelease([[FLGradientView alloc] initWithFrame:self.view.bounds]);
//    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//    gradient.alpha = 0.4;
//    [self.view insertSubview:gradient belowSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self willCreateToolbar];
}

- (void) _beginLoadingChildren {

    FLAction* loader = [self.dataModel childrenLoaderWithParentObject:self.parentDataRef];
    loader.progressController = [FLProgressViewOwner progressViewOwner: [[UIApplication visibleViewController] addActivityIndicatorView:UIActivityIndicatorViewStyleWhite]];
    [loader.progressController showProgress];
    
    [self startAction:loader completion: ^(id result) {
    
        if(loader.didSucceed) {
            [self mergeCellDataRefs:loader.loadChildrenResult];
        }

        [self setFinishedRefreshing];
    }];
}

- (void) willUpdateTitle {
    NSString* title = [self.parentDataRef gridViewDisplayName];

    if(FLStringIsNotEmpty(title)) {
        self.title = title;
    }
}

- (void) setParentDataObject:(id) object {
    FLAssignObjectWithRetain(_parentDataRef, object);
    [self willUpdateTitle];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];

    if(self.parentDataRef) {
        [self _beginLoadingChildren];
    }
    else {
        
        FLAction* loader = [self.dataModel rootObjectLoader];
        loader.progressController = [FLProgressViewOwner progressViewOwner: [[UIApplication visibleViewController] addActivityIndicatorView:UIActivityIndicatorViewStyleWhite]];
        [loader.progressController showProgress];
        
        [self startAction:loader completion: ^(id result) {
        
            if(loader.didSucceed) {
                self.parentDataRef = loader.result;
                [self _beginLoadingChildren];
            }

            [self setFinishedRefreshing];
        }];
    }

}

- (void) willBePushedOnViewControllerStack:(FLViewControllerStack*) controller {
    [super willBePushedOnViewControllerStack:controller];
    
    FLToolbarView* toolbar = (FLToolbarView*) self.topBarView;
    
    if([self isChildViewController]) {
        [toolbar.leftItems addToolbarItem:
            [FLImageButtonToolbarItem imageButtonToolbarItemWithImageName: self.discloseFromLeft ? @"back.png" : @"forward.png" 
                                               onChosenBlock:^(id item) { 
                                                    [self dismissViewControllerAnimated:YES]; 
                                                } ]];

//        [self.buttonbar addBackButton:@"<<" target:self action:@selector(popChild:)];
    }
//    else
//    {   
//        [toolbar.leftItems addToolbarItem:[FLImageButtonToolbarItem imageButtonToolbarItem:@"x.png" target:self action:@selector(_closeSelf:)]];
//    }
}

- (UIViewController*) createViewControllerForSelectedCell:(FLGridCell *)cell {
    FLHierarchicalGridViewController* controller = FLAutorelease([[[self class] alloc] init]);
    controller.dataModel = [self dataModelForCell:cell];
    controller.parentDataRef = cell.cellDataRef;
    controller.dismissHandler = self.dismissHandler;
    [controller willBecomeChildOfHierarchicalViewController:self];
    return controller;
}

- (void) discloseButtonPressedForCell:(FLGridCell*) cell {
    [self presentViewControllerForSelectedCell:cell];
}

- (void) dealloc {
    FLRelease(_parentDataRef);
    super_dealloc_();
}

- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridCell*) cell {
    return self.discloseFromLeft ?  [FLDropAndSlideInFromLeftAnimation viewControllerTransitionAnimation] : 
                                    [FLDropAndSlideInFromRightAnimation viewControllerTransitionAnimation];
}

- (FLGridCell*) createGridViewCellForObject:(id) object {
    return [FLHierarchicalGridViewCell hierarchicalGridViewCell:object];  
}

@end



