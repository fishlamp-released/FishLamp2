//
//  FLBreadcrumbBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLOrderedCollection.h"

@protocol FLBreadcrumbBarViewControllerDelegate;

@interface FLBreadcrumbBarViewController : UIViewController {
@private
    NSMutableArray* _breadcrumbs;
    __unsafe_unretained id<FLBreadcrumbBarViewControllerDelegate> _delegate;
    UIFont* _textFont;
}
@property (readwrite, strong, nonatomic) UIFont* textFont;
@property (readwrite,assign,nonatomic) id<FLBreadcrumbBarViewControllerDelegate> delegate;

- (void) addBreadcrumb:(NSString*) title forKey:(id) key;

- (void) update;

@end

@protocol FLBreadcrumbBarViewControllerDelegate <NSObject>
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(id) key;
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(id) key;
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbWasClicked:(id) key;
@end

