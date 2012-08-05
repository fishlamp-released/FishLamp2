//
//  FLGridViewCellDisplayContext.m
//  FishLampiOS
//
//  Created by Mike Fullerton on 6/3/12.
//  Copyright (c) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGriddableViewManager.h"
#import "FLGridViewCell.h"
#import "FLGridViewController.h"
#import "FLGriddableView.h"

#define kFirstState 0
#define kLastState 2


@interface FLGriddableViewManager ()
@property (readwrite, assign, nonatomic) FLGridViewController* viewController;
@property (readwrite, assign, nonatomic) UIView* superview;
@end

@implementation FLGriddableViewManager

@synthesize viewController = _viewController;
@synthesize superview = _superview;
@synthesize transactionID = _transactionID;

+ (FLGriddableViewManager*) gridViewCellManager {
    return FLReturnAutoreleased([[FLGriddableViewManager alloc] init]); 
}

- (void) cacheView:(FLGridViewCellVisibleView) state {
    if(_views[state]) {
        [_views[state] didMoveToGridViewCell:nil];
        [_viewController.objectCache cacheObject:&_views[state] reuseIdentifier:_viewKeys[state]];
        if(_views[state]) {
            [_views[state] removeFromSuperview];
            FLReleaseWithNil(_views[state]);
        }
    }
}

- (void) cacheAllViews {
    for(FLGridViewCellVisibleView state = kFirstState; state <= kLastState; state++) {
        [self cacheView:state];
    }
}

- (void) dealloc 
{
    [self cacheAllViews];
    
    for(FLGridViewCellVisibleView state = kFirstState; state <= kLastState; state++) {
        if(_views[state]) {
            [_views[state] removeFromSuperview];
            FLRelease(_views[state]);
            FLRelease(_viewKeys[state]);
        }
    }
    
    FLRelease(_transactionID);
    FLSuperDealloc();
}

- (void) showView:(UIView*) view 
   forVisibleView:(FLGridViewCellVisibleView) state 
         cacheKey:(id) cacheKey {

    if(view != _views[state]) {
        if(_views[state] != nil) {
            [self cacheView:state];
        }
        [_superview addSubview:view];
        [view didMoveToGridViewCell:_gridViewCell];
        FLAssignObject(_views[state], view);
        FLAssignObject(_viewKeys[state], cacheKey);
    }
}

- (UIView*) viewForVisibleView:(FLGridViewCellVisibleView) state {
    return _views[state];
}

- (id) cacheKeyForVisibleView:(FLGridViewCellVisibleView) state {
    return _viewKeys[state];
}

- (void) objectCacheWillCacheObject:(FLObjectCache*) cache {
   [self deactivate];
   [self cacheAllViews];
}

- (void) objectCacheWillUncacheObject:(FLObjectCache*) cache {
}

- (void) objectCacheWillPurgeObject:(FLObjectCache*) cache {
}

- (void) deactivateHiddenViews:(FLGridViewCellVisibleView) visibleView {
    for(FLGridViewCellVisibleView state = kFirstState;
        state <= kLastState;
        state++) {
        if(state != visibleView) {
            [self cacheView:state];
        }
    }
}

- (void) activateForCell:(FLGridViewCell*) cell 
      gridViewController:(FLGridViewController*) viewController
               superview:(UIView*) superview {
    _viewController = viewController;
    _superview = superview;
    _gridViewCell = cell;
}

- (void) deactivate {
    _gridViewCell = nil;
    _viewController = nil;
    _superview = nil;
}

@end