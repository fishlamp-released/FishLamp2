//
//  FLGridViewCellController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLGridViewCell.h"
#import "FLGridViewController.h"

@interface FLGridViewCell ()
@property (readwrite, retain, nonatomic) FLGriddableViewManager* viewManager;
@property (readwrite, assign, nonatomic) FLGridViewCellVisibleView previousVisibleView;
@end

@implementation FLGridViewCell 

@synthesize gridViewObject = _gridViewObject;
@synthesize viewManager = _viewManager;

@synthesize visibleView = _visibleView;
@synthesize previousVisibleView = _previousVisibleView;

- (CGRect) calculateLayoutFrameInBounds:(CGRect) bounds {
    return bounds;
}

- (void) gridViewCellView:(UIView*) view objectWasTouched:(id) touchedObject {
}

- (void) controlStateDidChangeState:(FLControlState*) state {
    [self.view setNeedsDisplay];
}

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

- (id) initWithGridViewObject:(id) gridViewObject {
    if((self = [self init])) {
        self.gridViewObject = gridViewObject;
    }
    
    return self;
}

- (void) dealloc  {   
    FLRelease(_viewManager);
    FLRelease(_gridViewObject);
    FLSuperDealloc();
}

- (void) cellWillLoad {
}

- (void) cellDidLoadView:(id) view  
       forVisibleView:(FLGridViewCellVisibleView) visibleView {
}

- (void) cellDidUnload {
}

- (void) cellWillUnload {
}


- (BOOL) isCellLoaded {
    return _viewManager != nil;
}

- (void) setWasSelectedInViewController:(FLGridViewController*) controller {
}

- (id) transactionID {
    return _viewManager.transactionID;
}

- (void) setTransactionID:(id) transactionID {
    _viewManager.transactionID = transactionID;
}

- (UIView*) superview {
    return _viewManager.superview;
}

- (FLGridViewController*) viewController {
    return _viewManager.viewController;
}

- (id) dataProvider {
    return _viewManager.viewController.dataSource;
}

- (id) viewForVisibleView:(FLGridViewCellVisibleView) visibleView {
    UIView* view = [_viewManager viewForVisibleView:visibleView];
    if(!view) {
        view = [self createViewForVisibleView:visibleView];
        [_viewManager showView:view forVisibleView:visibleView cacheKey:[self cacheKeyForVisibleView:visibleView]];
    }
    return view;
}

- (id) view {
    return [self viewForVisibleView:self.visibleView];
}

- (id) viewForPreviousVisibleView {
    return [self viewForVisibleView:self.previousVisibleView];
}

- (UIView*) createViewForVisibleView:(FLGridViewCellVisibleView) visibleView {
    FLRequiredOverride();
    return nil;
}

- (id) cacheKeyForVisibleView:(FLGridViewCellVisibleView) visibleView {
    switch(visibleView) {
        case FLGridViewCellVisibleViewFirst:
            return @"first";
        break;
        
        case FLGridViewCellVisibleViewSecond:
            return @"second";
        break;

        case FLGridViewCellVisibleViewThird:
            return @"third";
        break;

    }
}

- (void) hideViewForVisibleView:(FLGridViewCellVisibleView) visibleView {
    [_viewManager cacheView:visibleView];
}

- (void) layoutSubviews {
    [self.view setFrameOptimizedForLocation:self.frame];
}

- (void) didChangeVisibleView {
}

- (void) finishChangingVisibleView {
    [self cellDidLoadView:self.view forVisibleView:self.visibleView];
    [self layoutSubviews];
    [self didChangeVisibleView];
    [_viewManager deactivateHiddenViews:self.visibleView];
}

- (void) _restoreVisibleView {
    id newView = [self viewForVisibleView:self.visibleView];
    [self layoutSubviews];
    [self cellDidLoadView:newView forVisibleView:self.visibleView];
    [self didChangeVisibleView];
}

- (void) setVisibleView:(FLGridViewCellVisibleView) visibleView {
    [self setVisibleView:visibleView withBlock:nil];
}

- (void) setVisibleView:(FLGridViewCellVisibleView) visibleView
              withBlock:(void (^)()) block {

    if(visibleView != self.visibleView) {
        self.previousVisibleView = self.visibleView;
        self.visibleView = visibleView;
        if(block) {
            block();
        }
        else {
            [self finishChangingVisibleView];
        }
    } 
}

- (BOOL) hasViewForVisibleView:(FLGridViewCellVisibleView) visibleView {
    return [_viewManager viewForVisibleView:visibleView] != nil;
}

- (void) didChangeFrame {
    [self layoutSubviews];
}

- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(FLGridViewController*) controller {

// first uncache or create a viewManager    
    [controller.objectCache uncacheObject:&_viewManager reuseIdentifier:[self class]];
    if(!_viewManager) {
        self.viewManager = [FLGriddableViewManager gridViewCellManager];
    }
    [self.viewManager activateForCell:self gridViewController:controller superview:superview];
    
// then restore view.    
    [self _restoreVisibleView];
}

- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(FLGridViewController*) controller {
    [self cellWillUnload];
    
    if(self.transactionID) {
        [_viewManager.viewController.actionContext cancelActionByID:self.transactionID];
    }

    [_viewManager deactivate];
    [controller.objectCache cacheObject:&_viewManager reuseIdentifier:[self class]];
    
    [self cellDidUnload];
}

@end



