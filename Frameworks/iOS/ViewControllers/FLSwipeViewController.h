//
//  FLSwipeViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/31/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLMultiViewController.h"
#import "FLBreadcrumbView.h"
#import "FLAuxiliaryViewController.h"

@interface FLSwipeViewController : FLSelectableViewControllerMultiViewController<UIScrollViewDelegate, FLBreadcrumbViewDelegate> {
@private
    UIView* _breadcrumbHost;
    UIScrollView* _scrollView;
    FLBreadcrumbView* _breadCrumbview;
    FLAuxiliaryViewController* _bottomAuxiliaryViewController;
}

@property (readwrite, retain, nonatomic) FLAuxiliaryViewController* bottomAuxiliaryViewController;

- (void) didChooseMenuItem:(NSInteger) menuItem;

- (void) recalculateScrollView:(BOOL) animate;


@end

