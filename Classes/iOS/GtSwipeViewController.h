//
//  GtSwipeViewController.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 12/31/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtMultiViewController.h"
#import "GtBreadcrumbView.h"
#import "GtAuxiliaryViewController.h"

@interface GtSwipeViewController : GtSelectableViewControllerMultiViewController<UIScrollViewDelegate, GtBreadcrumbViewDelegate> {
@private
    UIView* m_breadcrumbHost;
    UIScrollView* m_scrollView;
    GtBreadcrumbView* m_breadCrumbview;
    GtAuxiliaryViewController* m_bottomAuxiliaryViewController;
}

@property (readwrite, retain, nonatomic) GtAuxiliaryViewController* bottomAuxiliaryViewController;

- (void) didChooseMenuItem:(NSInteger) menuItem;

- (void) recalculateScrollView:(BOOL) animate;


@end

