//
//  FLBreadcrumbBarViewController.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "FLOrderedCollection.h"

@protocol FLBreadcrumbBarViewControllerDelegate;

@interface FLBreadcrumbBarViewController : NSViewController {
@private
    NSMutableArray* _breadcrumbs;
    __unsafe_unretained id<FLBreadcrumbBarViewControllerDelegate> _delegate;
}
@property (readwrite,assign,nonatomic) id<FLBreadcrumbBarViewControllerDelegate> delegate;

- (void) addBreadcrumb:(NSString*) title;

- (void) update;

@end

@protocol FLBreadcrumbBarViewControllerDelegate <NSObject>
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(NSString*) title;
- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(NSString*) title;
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbWasClicked:(NSString*) title;
@end
