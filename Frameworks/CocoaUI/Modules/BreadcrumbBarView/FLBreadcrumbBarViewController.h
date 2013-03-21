//
//  FLBreadcrumbBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumbBarView.h"
#import "FLCompatibleViewController.h"

@protocol FLBreadcrumbBarViewControllerDelegate;

@interface FLBreadcrumbBarViewController : FLCompatibleViewController<FLBreadcrumbBarViewDelegate> {
@private
    __unsafe_unretained id<FLBreadcrumbBarViewControllerDelegate> _delegate;
    UIFont* _textFont;
    FLStringDisplayStyle* _titleStyle;
}

@property (readwrite, strong, nonatomic) UIFont* textFont;
@property (readwrite,assign,nonatomic) id<FLBreadcrumbBarViewControllerDelegate> delegate;

@property (readwrite, strong, nonatomic) NSView* contentView;

- (void) addBreadcrumb:(NSString*) title;
- (void) removeBreadcrumb:(NSString*) title;

- (void) updateViewsAnimated:(BOOL) animated;

@end

@protocol FLBreadcrumbBarViewControllerDelegate <NSObject>
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(NSString*) title;
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(NSString*) title;
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbWasClicked:(NSString*) title;
@end

