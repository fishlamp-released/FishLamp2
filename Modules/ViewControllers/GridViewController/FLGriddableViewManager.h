//
//  FLGridViewCellDisplayContext.h
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

@class FLGridViewController; 
@class FLGridViewCell;

/// @brief The idea here is that each cell can have three states, loading, loaded, and error.
typedef enum {
    FLGridViewCellVisibleViewFirst,    // e.g. loading
    FLGridViewCellVisibleViewSecond,   // e.g. visible and loaded
    FLGridViewCellVisibleViewThird     // e.g. failed to load
} FLGridViewCellVisibleView;

#define FLGridViewCellVisibleViewCount 3

@interface FLGriddableViewManager : NSObject {
@private
    FLGridViewController* _viewController;
    UIView* _superview;
    FLGridViewCell* _gridViewCell;
    
    id _transactionID;

// fixed size for efficiency
    UIView* _views[FLGridViewCellVisibleViewCount];
    id _viewKeys[FLGridViewCellVisibleViewCount];
}

+ (FLGriddableViewManager*) gridViewCellManager;

@property (readonly, assign, nonatomic) FLGridViewController* viewController;
@property (readonly, assign, nonatomic) UIView* superview;
@property (readwrite, strong, nonatomic) id transactionID;

- (UIView*) viewForVisibleView:(FLGridViewCellVisibleView) visibleView;

- (id) cacheKeyForVisibleView:(FLGridViewCellVisibleView) visibleView;

- (void) showView:(UIView*) view 
  forVisibleView:(FLGridViewCellVisibleView) visibleView 
        cacheKey:(id) cacheKey;

- (void) cacheView:(FLGridViewCellVisibleView) state;

- (void) cacheAllViews;

- (void) deactivateHiddenViews:(FLGridViewCellVisibleView) visibleView;

- (void) activateForCell:(FLGridViewCell*) cell 
      gridViewController:(FLGridViewController*) viewController
               superview:(UIView*) superview;
        
- (void) deactivate;


@end