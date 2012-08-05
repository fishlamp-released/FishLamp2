//
//  FLGridViewCellController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2011 GreenTongue Software, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "FLArrangement.h"
#import "FLFrame.h"
#import "FLGriddableViewManager.h"
#import "FLWidget.h"

@class FLGridViewController;

@protocol FLGridViewCellSelectionHandler;
@protocol FLGridViewCellTouchHandler;
@class FLGridViewCell;

typedef void (^FLGridViewCellCallback)(id theCell);

@interface FLGridViewCell : FLFrame {
@private
    id _gridViewObject;
    FLGriddableViewManager* _viewManager;
    FLGridViewCellVisibleView _visibleView;
    FLGridViewCellVisibleView _previousVisibleView;
}

- (id) initWithGridViewObject:(id) gridViewObject;

/// @brief Data for cell, whatever that may be
@property (readwrite, retain, nonatomic) id gridViewObject;

/// @brief Which view is visible. 
/// This is a enum because we cache the views
@property (readwrite, assign, nonatomic) FLGridViewCellVisibleView visibleView;

/// @brief Change the view of the current cell. 
/// You are required to call finishChangingVisibleView if you call with a block
- (void) setVisibleView:(FLGridViewCellVisibleView) view
              withBlock:(void (^)()) block;

/// @brief finishChangingViewView
- (void) finishChangingVisibleView;                    


/// @brief Which view was previously visible. 
/// This is a enum because we cache the views
@property (readonly, assign, nonatomic) FLGridViewCellVisibleView previousVisibleView;

// views 
@property (readonly, retain, nonatomic) id view; // view for current state

@property (readonly, retain, nonatomic) id viewForPreviousVisibleView; // view for previous state, only valid during state change. 

- (BOOL) hasViewForVisibleView:(FLGridViewCellVisibleView) visibleView;

- (id) viewForVisibleView:(FLGridViewCellVisibleView) visibleView; // lazy creates the view

- (void) hideViewForVisibleView:(FLGridViewCellVisibleView) visibleView;

// override points
- (UIView*) createViewForVisibleView:(FLGridViewCellVisibleView) visibleView; // required override

- (id) cacheKeyForVisibleView:(FLGridViewCellVisibleView) visibleView; // optional override

/// @brief override this
- (void) didChangeVisibleView;

// by default, this sets self.view.frame = self.frame;
- (void) layoutSubviews; 

- (void) gridViewCellView:(UIView*) view objectWasTouched:(id) touchedObject;

// events
@property (readonly, assign, nonatomic) BOOL isCellLoaded;
- (void) cellWillLoad; // override point.
- (void) cellDidLoadView:(id) view forVisibleView:(FLGridViewCellVisibleView) state;
- (void) cellWillUnload;
- (void) cellDidUnload;       
                  
// misc. These are pulled from context when cell is loaded.
@property (readonly, assign, nonatomic) FLGridViewController* viewController;
@property (readonly, assign, nonatomic) id dataProvider;
@property (readonly, assign, nonatomic) UIView* superview;
@property (readwrite, retain, nonatomic) id transactionID;

// internal
- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(FLGridViewController*) controller;
                               
- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(FLGridViewController*) controller;
@end



