//
//  FLBreadcrumbView.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 1/1/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

@protocol FLBreadcrumbViewDelegate;

#import "FLWidgetView.h"

@interface FLBreadcrumbView : FLWidgetView {
@private
    NSInteger _itemCount;
    NSInteger _selectedItem;
    CGFloat _circleSize;
    
    __unsafe_unretained id<FLBreadcrumbViewDelegate> _delegate;
}

@property (readwrite, assign, nonatomic) id<FLBreadcrumbViewDelegate> delegate;

@property (readwrite, assign, nonatomic) CGFloat circleSize;

@property (readwrite, assign, nonatomic) NSInteger itemCount;
@property (readwrite, assign, nonatomic) NSInteger selectedItem;

@end


@protocol FLBreadcrumbViewDelegate <NSObject>
- (void) breadcrumbViewWasTapped:(FLBreadcrumbView*) view;
@end