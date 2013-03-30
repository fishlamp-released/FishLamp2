//
//  FLBreadcrumbBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLBreadcrumbBarView.h"

@protocol FLBreadcrumbBarViewControllerDelegate;

@interface FLBreadcrumbBarViewController : FLCompatibleViewController<FLBreadcrumbBarViewDelegate, FLBarTitleStyleProvider> {
@private
    __unsafe_unretained id<FLBreadcrumbBarViewControllerDelegate> _delegate;
    FLStringDisplayStyle* _titleStringStyle;
    IBOutlet SDKView* _contentView;
}

@property (readwrite, strong, nonatomic) FLStringDisplayStyle* titleStringStyle;
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

