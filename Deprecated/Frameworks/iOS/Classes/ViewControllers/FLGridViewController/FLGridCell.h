//
//  FLGridCellData.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "FLFrame.h"
#import "FLDataRef.h"
#import "FLObjectCache.h"

typedef void (^FLFinishedAnimationBlock)();
typedef void (^FLGridCellAnimationBlock)(   UIView* previousView,
                                            UIView* newView,
                                            FLFinishedAnimationBlock finishedAnimating);

@class FLGridViewController;

// these can be anything.
enum {
    FLGridCellStateNormal,
    FLGridCellStateLoading,
    FLGridCellStateError
};

typedef  NSInteger FLGridCellState;

@interface FLGridCell : FLFrame {
@private
    id _dataRef;
    FLGridCellState _cellState;
    FLGridViewController* _viewController;
    UIView* _view;
}

// these are only non nil with the cell is loaded.
@property (readonly, strong, nonatomic) FLGridViewController* viewController;
@property (readonly, strong, nonatomic) UIView* superview;
@property (readonly, strong, nonatomic) FLObjectCache* objectCache;
@property (readonly, strong, nonatomic) id dataModel;
@property (readonly, strong, nonatomic) UIView* view;

// data and frame state persists across loading and unloading of the cell

/// @brief Data for cell, whatever that may be. See FLDataRef.h
@property (readwrite, strong, nonatomic) id cellDataRef;
@property (readonly, strong, nonatomic) id cellDataRefValue;
@property (readonly, strong, nonatomic) id cellDataRefKey;

/// @brief Which view is visible. 
@property (readonly, assign, nonatomic) FLGridCellState gridCellState;

- (id) initWithDataRef:(id) dataRef;

- (void) showViewForState:(FLGridCellState) state
                withBlock:(FLGridCellAnimationBlock) animationBlock;

- (void) showViewForState:(FLGridCellState) state;

// override points

/// @brief override this
- (Class) viewClassForCellState:(FLGridCellState) state; // required override

/// @brief by default this creates a view class using the above class
- (UIView*) createViewForGridCellState:(FLGridCellState) state;

// touches
- (void) objectWasTouched:(id) touchedObject;

// a cell is loaded if it is visible in the gridview
@property (readonly, assign, nonatomic) BOOL isCellLoaded;
- (void) cellWillLoad;
- (void) cellDidLoad;
- (void) cellWillUnload;
- (void) cellDidUnload;       

- (void) willShowView:(UIView*) newView;
- (void) didShowView;

// by default, this sets self.view.frame = self.frame;
- (void) setNeedsLayout; 
- (void) layoutSubviews;

@end



