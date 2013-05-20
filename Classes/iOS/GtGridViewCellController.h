//
//  GtGridViewCellController.h
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtViewLayout.h"

@class GtGridViewController;

@protocol GtGridViewCellSelectionHandler;
@protocol GtGridViewCellTouchHandler;
@class GtGridViewCellController;

@interface NSObject (GtGridViewCell)
- (id) dataForDataID:(id) dataID;
- (void) releaseData;
@end

@interface UIView (GtGridViewCellView)
@property (readwrite, assign, nonatomic) GtGridViewCellController* gridViewCellController;
- (void) didMoveToGridViewCellController;
@end

typedef enum {
    GtGridViewCellDisplayStateFirst,    // e.g. loading
    GtGridViewCellDisplayStateSecond,   // e.g. visible and loaded
    GtGridViewCellDisplayStateThird     // e.g. failed to load
} GtGridViewCellDisplayState;

@class GtGridViewCellDisplayContext;

@interface GtGridViewCellController : NSObject {
@private
    CGRect m_frame;
    id m_gridViewObject;
    GtGridViewCellDisplayContext* m_displayContext;
    struct {
        unsigned int isHidden: 1;
        unsigned int isHighlighted: 1;
        unsigned int isSelected: 1;
        unsigned int isDisabled: 1;
        GtGridViewCellDisplayState displayState;
        GtGridViewCellDisplayState previousDisplayState;
    } m_flags;
}

- (id) initWithGridViewObject:(id) gridViewObject;

@property (readonly, retain, nonatomic) id<GtGridViewCellTouchHandler> touchHandler;
@property (readonly, retain, nonatomic) id<GtGridViewCellSelectionHandler> selectionHandler;

@property (readwrite, retain, nonatomic) id gridViewObject;

// visible state.
@property (readwrite, assign, nonatomic, getter=isHidden) BOOL hidden;
@property (readwrite, assign, nonatomic, getter=isHighlighted) BOOL highlighted;
@property (readwrite, assign, nonatomic, getter=isSelected) BOOL selected;
@property (readwrite, assign, nonatomic, getter=isDisabled) BOOL disabled;
- (void) cellDidChangeState; 

/// Cell state
@property (readonly, assign, nonatomic) GtGridViewCellDisplayState displayState;
@property (readonly, assign, nonatomic) GtGridViewCellDisplayState previousDisplayState;

- (void) beginChangingDisplayStateTo:(GtGridViewCellDisplayState) state
                            withData:(id) data
                            animated:(BOOL) animated;

- (void) cellWillChangeStateAnimated:(BOOL) animated
                                data:(id) dataOrNil
                  completionCallback:(GtBlock) completionCallback;

- (void) cellDidChangeDisplayState;

// views 
@property (readonly, retain, nonatomic) UIView* view; // view for current state
@property (readonly, retain, nonatomic) UIView* viewForPreviousDisplayState; // view for previous state, only valid during state change. 
- (BOOL) hasViewForDisplayState:(GtGridViewCellDisplayState) displayState;
- (UIView*) viewForDisplayState:(GtGridViewCellDisplayState) displayState; // lazy creates the view
- (void) hideViewForDisplayState:(GtGridViewCellDisplayState) displayState;

// override points
- (UIView*) createViewForDisplayState:(GtGridViewCellDisplayState) displayState; // required override
- (id) cacheKeyForDisplayState:(GtGridViewCellDisplayState) displayState; // optional override

// by default, this sets self.view.frame = self.frame;
- (void) layoutSubviews; 

// events
@property (readonly, assign, nonatomic) BOOL isCellLoaded;
- (void) cellWillLoad; // override point.
- (void) cellWillUnload;
- (void) cellDidUnload;       
                  

- (BOOL) touchPointSelectsCell:(CGPoint) point; // by default tests frame of cell.

// misc. These are pulled from context when cell is loaded.
@property (readonly, assign, nonatomic) GtGridViewController* viewController;
@property (readonly, assign, nonatomic) UIView* superview;
@property (readwrite, retain, nonatomic) id transactionID;

// layout
@property (readwrite, assign, nonatomic) CGRect frame;

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint;

// internal
- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(GtGridViewController*) controller;
                               
- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(GtGridViewController*) controller;
@end

@protocol GtGridViewCellSelectionHandler <NSObject>
- (void) gridViewCellWasSelected:(GtGridViewCellController*) cell;
@end

@protocol GtGridViewCellTouchHandler <NSObject>

- (void)touchesBeganInGridViewCell:(GtGridViewCellController*) cell
                         superview:(UIView*) superview 
                           touches:(NSSet *)touches 
                         withEvent:(UIEvent *)event;

- (void)touchesMovedInGridViewCell:(GtGridViewCellController*) cell
                         superview:(UIView*) superview 
                           touches:(NSSet *)touches 
                         withEvent:(UIEvent *)event;
        
- (void)touchesEndedInGridViewCell:(GtGridViewCellController*) cell
                         superview:(UIView*) superview 
                           touches:(NSSet *)touches 
                         withEvent:(UIEvent *)event; 
        
- (void)touchesCancelledInGridViewCell:(GtGridViewCellController*) cell
                             superview:(UIView*) superview 
                               touches:(NSSet *)touches 
                             withEvent:(UIEvent *)event;

@end



