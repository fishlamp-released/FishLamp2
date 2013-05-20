//
//  FLGridCellData.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLGridCell.h"
#import "FLGridViewController.h"
#import "_FLGridCell.h"
#import "FLGridCellView.h"

@interface FLGridCell ()
@property (readwrite, strong, nonatomic) UIView* view;
@property (readwrite, strong, nonatomic) FLGridViewController* viewController;
@property (readwrite, assign, nonatomic) FLGridCellState gridCellState;
@end

@implementation FLGridCell 

@synthesize cellDataRef = _dataRef;
@synthesize gridCellState = _cellState;
@synthesize viewController = _viewController;
@synthesize view = _view;

- (CGRect) calculateLayoutFrameInBounds:(CGRect) bounds {
    return bounds;
}

- (void) objectWasTouched:(id) touchedObject {
}

- (void) setControlState:(FLControlState) controlState {
    [super setControlState:controlState];
    if(self.isCellLoaded) {
        [self.view setNeedsDisplay];
    }
}

- (id) init {
    self = [super init];
    if(self) {
    }
    
    return self;
}

- (id) initWithDataRef:(id) dataRef {
    if((self = [self init])) {
        self.cellDataRef = dataRef;
    }
    
    return self;
}

- (void) dealloc  {
    
    if(_view) {
        [self.objectCache cacheObject:_view];
    }

    FLRelease(_viewController);
    FLRelease(_view);
    FLRelease(_dataRef);
    FLSuperDealloc();
}

- (UIView*) superview {
    return _viewController.gridViewSuperview;
}

- (FLObjectCache*) objectCache {
    return _viewController.objectCache;
}

- (id) dataModel {
    return _viewController.dataModel;
}

- (void) cellWillLoad {
}

- (void) cellDidLoad {
}


- (void) cellDidUnload {
}

- (void) cellWillUnload {
}

- (BOOL) isCellLoaded {
    return _view != nil;
}

- (void) setWasSelectedInViewController:(FLGridViewController*) controller {
}

- (Class) viewClassForCellState:(FLGridCellState) state {
    FLAssertIsOverriddenWithComment(nil);
    return nil;
}

- (UIView*) createViewForGridCellState:(FLGridCellState) state {
    return FLAutorelease([[[self viewClassForCellState:state] alloc] initWithFrame:self.frame]);
}
//
//- (void) setView:(UIView*) view {
//    
//    if(_view) {
//        [self.objectCache cacheObject:_view];
//        FLReleaseWithNil(_view);
//    }
//    
//    if(view) {
//        FLSetObjectWithRetain(_view, view);
//        if(_view.superview != self.superview) {
//            [self.superview addSubview:view];
//        }
//    }
//}

- (UIView*) createOrUncacheViewForState:(FLGridCellState) state {

    UIView* view = [self.objectCache uncacheObjectForClass:[self viewClassForCellState:state]];
    if(!view) {
        view = [self createViewForGridCellState:state];
        view.hidden = YES;
        [self.superview addSubview:view];
    }

    FLAssertIsNotNil(view);
    return view;
}


- (void) layoutSubviews {
    [self.view setFrameOptimizedForLocation:self.frame];
    [self.view setNeedsLayout];
}

- (void) setNeedsLayout {
    [self layoutSubviews];
}

- (void) willShowView:(UIView*) view {
}

- (void) didShowView {
}

- (void) finishChangingVisibleView {
    [self setNeedsLayout];
    [self didShowView];
}

- (void) restoreVisibleView {
    self.view = [self createOrUncacheViewForState:self.gridCellState];
    self.view.hidden = NO;
    [self finishChangingVisibleView];
}

- (void) showViewForState:(FLGridCellState) state {
    [self showViewForState:state withBlock:nil];
}

- (void) showViewForState:(FLGridCellState) state
                withBlock:(FLGridCellAnimationBlock) block {


    if(state != self.gridCellState) {

        UIView* prevView = _view;
        self.gridCellState = state;

        UIView* newView = [self createOrUncacheViewForState:self.gridCellState];
        [self willShowView:newView];
        
        if(block) {
            FLFinishedAnimationBlock callback  = ^{
                [self.objectCache cacheObject:prevView];
                self.view = newView;
                [self finishChangingVisibleView];
            };
            
            block(prevView, newView, FLAutorelease([callback copy]));
        }
        else {
            [self.objectCache cacheObject:prevView];
            newView.hidden = NO;
            self.view = newView;
            [self finishChangingVisibleView];
        }
    } 
}

- (void) didChangeFrame {
    [self setNeedsLayout];
}

- (id) cellDataRefValue {
    return [_dataRef dataRefValue];
}

- (id) cellDataRefKey {
    return [_dataRef dataRefKey];
}



@end

@implementation FLGridCell (Internal)

- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(FLGridViewController*) controller {


// first uncache or create a cellController    
    self.viewController = controller;

    [self cellWillLoad];
    
// then restore view.    
    [self restoreVisibleView];
    
    [self cellDidLoad];
}

- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(FLGridViewController*) controller {
    
    [self cellWillUnload];
    
//    if(_cellData.transactionID) {
//        [_cellData.viewController.actionContext cancelOperationByID:_cellData.transactionID];
//    }

    [self.objectCache cacheObject:_view];
    self.viewController = nil;
    self.view = nil;

//    [_cellData deactivate];
//    [controller.objectCache cacheObject:&_cellData reuseIdentifier:[self class]];
    
    [self cellDidUnload];
}


@end