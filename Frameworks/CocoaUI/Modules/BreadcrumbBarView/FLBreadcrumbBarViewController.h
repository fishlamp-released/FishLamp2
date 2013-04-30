//
//  FLBreadcrumbBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumbBarView.h"
#import "FLNavigationTitle.h"

@protocol FLBreadcrumbBarViewControllerDelegate;

@interface FLBreadcrumbBarViewController : FLCompatibleViewController<FLBreadcrumbBarViewDelegate> {
@private
    __unsafe_unretained id<FLBreadcrumbBarViewControllerDelegate> _delegate;
}

@property (readwrite, strong, nonatomic) FLStringDisplayStyle* titleStringStyle;

@property (readwrite,assign,nonatomic) id<FLBreadcrumbBarViewControllerDelegate> delegate;

- (void) addNavigationTitle:(FLNavigationTitle*) title;
- (void) removeNavigationTitleForIdentifier:(id) identifier;

- (void) updateNavigationTitlesAnimated:(BOOL) animated;

@end

@protocol FLBreadcrumbBarViewControllerDelegate <NSObject>

- (BOOL) titleNavigationController:(FLBreadcrumbBarViewController*) controller 
          navigationTitleIsVisible:(FLNavigationTitle*) title;

- (BOOL) titleNavigationController:(FLBreadcrumbBarViewController*) controller 
          navigationTitleIsEnabled:(FLNavigationTitle*) title;
          
- (void) titleNavigationController:(FLBreadcrumbBarViewController*) controller 
         navigationTitleWasClicked:(FLNavigationTitle*) title;

- (void) titleNavigationController:(FLBreadcrumbBarViewController*) controller 
             didAddNavigationTitle:(FLNavigationTitle*) title;

@end

