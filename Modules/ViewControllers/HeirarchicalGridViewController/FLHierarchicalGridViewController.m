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
#import "FLAsyncEventHandler.h"
#import "FLToolbarView.h"
#import "UIImage+FLColorize.h"
#import "FLToolbarView.h"

#import "FLViewControllerStack.h"
#import "FLProgressViewController.h"
#import "FLVerticalGridArrangement.h"
#import "FLToolbarTitleView.h"
#import "FLImageButtonToolbarItem.h"

@implementation FLHierarchicalGridViewController 

@synthesize parentDataObject = _parentObject;
@synthesize discloseFromLeft = _discloseFromLeft;
@synthesize isChildViewController = _isChild;

- (id) init {
    self = [super init];
    if(self) {
        self.cellArrangement = [FLVerticalGridArrangement verticalGridArrangement];
    }
    
    return self;
}

+ (FLHierarchicalGridViewController*) hierarchicalGridViewController {
    return FLReturnAutoreleased([[[self class] alloc] init]);
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
    
//    FLGradientView* gradient = FLReturnAutoreleased([[FLGradientView alloc] initWithFrame:self.view.bounds]);
//    gradient.autoresizingMask = UIViewAutoresizingFlexibleEverything;
//    gradient.alpha = 0.4;
//    [self.view insertSubview:gradient belowSubview:self.scrollView];
    
    self.view.backgroundColor = [UIColor clearColor];
    self.scrollView.backgroundColor = [UIColor clearColor];
    [self willCreateToolbar];
}

- (void) _beginLoadingChildren {
    FLAsyncEventProgressHandler* eventHandler = [FLAsyncEventProgressHandler asyncEventProgressHandler];

    eventHandler.onShowProgress = ^(FLAsyncEventProgressHandler* theHandler) {
        theHandler.progressController = [FLProgressViewOwner progressViewOwner];
        theHandler.progressController.onShowProgress = ^(id theProgress) {
            [theProgress setProgressView: [[UIApplication visibleViewController] addActivityIndicatorView:UIActivityIndicatorViewStyleWhite]];
            
        };
        
        [theHandler.progressController showProgress];
    };

    eventHandler.onEvent = ^(id theEventHandler, BOOL success, id result, FLAsyncEventHint hint) {
    
        [self performBlockOnMainThread:^{
            if(success) {
                [self mergeGridViewObjects:result];
            }
            else {
                // handle error?
            }
            
            [self setFinishedRefreshing];
        }];        
    
    };

    [self.dataSource beginLoadingChildenForDataObject:self.parentDataObject eventHandler:eventHandler];
}

- (void) willUpdateTitle {
    NSString* title = [self.parentDataObject gridViewDisplayName];

    if(FLStringIsNotEmpty(title)) {
        self.title = title;
    }
}

- (void) setParentDataObject:(id) object {
    FLAssignObject(_parentObject, object);
    [self willUpdateTitle];
}

- (void) viewWillAppear:(BOOL) animated {
    [super viewWillAppear:animated];

    if(self.parentDataObject) {
        [self _beginLoadingChildren];
    }
    else {
        FLAsyncEventProgressHandler* eventHandler = [FLAsyncEventProgressHandler asyncEventProgressHandler];
        
        eventHandler.onShowProgress = ^(FLAsyncEventProgressHandler* theHandler) {
            theHandler.progressController = [FLProgressViewOwner progressViewOwner];
            theHandler.progressController.onShowProgress = ^(id theProgress) {
                [theProgress setProgressView: [[UIApplication visibleViewController] addActivityIndicatorView:UIActivityIndicatorViewStyleWhite]];
            };
            
            [theHandler.progressController showProgress];
        };        
        
        eventHandler.onEvent = ^(id theEventHandler, BOOL success, id result, FLAsyncEventHint hint) {
            if(success) {
                self.parentDataObject = result;
                [self _beginLoadingChildren];
            }
            else {
                // TODO: handle error?
            }
        };
        [self.dataSource beginLoadingRootObject:eventHandler];
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

- (UIViewController*) createViewControllerForOpeningCell:(FLGridViewCell *)cell {
    FLHierarchicalGridViewController* controller = FLReturnAutoreleased([[[self class] alloc] init]);
    controller.dataSource = [self dataSourceForCell:cell];
    controller.parentDataObject = cell.gridViewObject;
    controller.dismissHandler = self.dismissHandler;
    [controller willBecomeChildOfHierarchicalViewController:self];
    return controller;
}

- (void) discloseButtonPressedForCell:(FLGridViewCell*) cell {
    [self showViewControllerForCell:cell];
}

- (void) dealloc {
    FLRelease(_parentObject);
    FLSuperDealloc();
}

- (id<FLViewControllerTransitionAnimation>) createOpenAnimationForCell:(FLGridViewCell*) cell {
    return self.discloseFromLeft ?  [FLDropAndSlideInFromLeftAnimation viewControllerTransitionAnimation] : 
                                    [FLDropAndSlideInFromRightAnimation viewControllerTransitionAnimation];
}

- (FLGridViewCell*) createGridViewCellForObject:(id) object {
    return [FLHierarchicalGridViewCell hierarchicalGridViewCell:object];  
}

@end



