//
//  GtBreadcrumbView.h
//  FishLamp-iOS-Lib
//
//  Created by Fullerton Mike on 1/1/12.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

@protocol GtBreadcrumbViewDelegate;

@interface GtBreadcrumbView : UIView {
@private
    NSInteger m_itemCount;
    NSInteger m_selectedItem;
    CGFloat m_circleSize;
    
    id<GtBreadcrumbViewDelegate> m_delegate;
}

@property (readwrite, assign, nonatomic) id<GtBreadcrumbViewDelegate> delegate;

@property (readwrite, assign, nonatomic) CGFloat circleSize;

@property (readwrite, assign, nonatomic) NSInteger itemCount;
@property (readwrite, assign, nonatomic) NSInteger selectedItem;

@end


@protocol GtBreadcrumbViewDelegate <NSObject>
- (void) breadcrumbViewWasTapped:(GtBreadcrumbView*) view;
@end