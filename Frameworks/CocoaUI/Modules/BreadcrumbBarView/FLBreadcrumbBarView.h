//
//  FLBreadcrumbBarView.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 1/15/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"

#import "FLAttributedString.h"
#import "FLOrderedCollection.h"
#import "FLMouseTrackingView.h"
#import "FLBarTitleLayer.h"
#import "FLBarHighlightBackgoundLayer.h"

@class FLBarTitleLayer;
@protocol FLBreadcrumbBarViewDelegate;

@interface FLBreadcrumbBarView : FLMouseTrackingView  {
@private
    NSMutableArray* _titles;
    FLBarHighlightBackgoundLayer* _highlightLayer;
    CGFloat _titleTop;
   
    IBOutlet NSView* _contentEnclosure;
    IBOutlet NSView* _contentView;
    
    __unsafe_unretained id<FLBreadcrumbBarViewDelegate> _delegate;
}
@property (readonly, strong, nonatomic) NSArray* titles;
@property (readonly, strong, nonatomic) FLBarHighlightBackgoundLayer* highlightLayer;
@property (readwrite, assign, nonatomic) CGFloat titleTop;

@property (readwrite, assign, nonatomic) id<FLBreadcrumbBarViewDelegate> delegate;

- (void) addTitle:(FLBarTitleLayer*) title;
- (void) updateHighlightedTitle:(BOOL) animated;

@end

@protocol FLBreadcrumbBarViewDelegate <NSObject>
- (void) breadcrumbBar:(FLBreadcrumbBarView*) view handleMousedownInTitle:(FLBarTitleLayer*) title;
@end