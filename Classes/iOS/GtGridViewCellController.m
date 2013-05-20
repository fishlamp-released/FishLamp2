//
//  GtGridViewCellController.m
//  FishLamp-iOS-Lib
//
//  Created by Mike Fullerton on 12/17/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtGridViewCellController.h"
#import "GtGridViewCellTouchHandler.h"
#import "GtGridViewController.h"
#import "GtGridViewCellView.h"

@implementation NSObject (GtGridViewCell)

- (id) dataForDataID:(id) dataID
{
    return self;
}
- (void) releaseData
{
}

@end

#define kFirstState GtGridViewCellDisplayStateFirst
#define kLastState GtGridViewCellDisplayStateSecond

#define GtGridViewCellDisplayStateCount (kLastState + 1)

@interface GtGridViewCellDisplayContext : NSObject {
@private
    GtGridViewController* m_viewController;
    id<GtGridViewCellTouchHandler> m_touchHandler;
    id<GtGridViewCellSelectionHandler> m_selectionHandler;
    UIView* m_superview;
    id m_transactionID;
    UIView* m_views[GtGridViewCellDisplayStateCount];
    id m_viewKeys[GtGridViewCellDisplayStateCount];
}

+ (GtGridViewCellDisplayContext*) displayContext;

@property (readwrite, assign, nonatomic) GtGridViewController* viewController;
@property (readwrite, assign, nonatomic) UIView* superview;
@property (readwrite, retain, nonatomic) id transactionID;
@property (readwrite, retain, nonatomic) id<GtGridViewCellTouchHandler> touchHandler;
@property (readwrite, retain, nonatomic) id<GtGridViewCellSelectionHandler> selectionHandler;

- (UIView*) viewForDisplayState:(GtGridViewCellDisplayState) state;
- (id) cacheKeyForDisplayState:(GtGridViewCellDisplayState) state;

- (void) setView:(UIView*) view forDisplayState:(GtGridViewCellDisplayState) displayState cacheKey:(id) cacheKey;
- (void) hideViewForDisplayState:(GtGridViewCellDisplayState) state;
- (void) hideAllViews;

@end


@implementation GtGridViewCellDisplayContext

@synthesize viewController = m_viewController;
@synthesize superview = m_superview;
@synthesize transactionID = m_transactionID;
@synthesize touchHandler = m_touchHandler;
@synthesize selectionHandler = m_selectionHandler;

+ (GtGridViewCellDisplayContext*) displayContext
{
    return GtReturnAutoreleased([[GtGridViewCellDisplayContext alloc] init]); 
}

- (void) hideViewForDisplayState:(GtGridViewCellDisplayState) state
{
    if(m_views[state])
    {
        [m_viewController.objectCache cacheObject:&m_views[state] reuseIdentifier:m_viewKeys[state]];

        if(m_views[state])
        {
            [m_views[state] removeFromSuperview];
            GtReleaseWithNil(m_views[state]);
        }
    }
}

- (void) hideAllViews
{
    for(GtGridViewCellDisplayState state = kFirstState; state <= kLastState; state++)
    {
        [self hideViewForDisplayState:state];
    }
}

- (void) dealloc 
{
    [self hideAllViews];
    
    for(GtGridViewCellDisplayState state = kFirstState; state <= kLastState; state++)
    {
        if(m_views[state])
        {
            [m_views[state] removeFromSuperview];
            GtRelease(m_views[state]);
            GtRelease(m_viewKeys[state]);
        }
    }
    GtRelease(m_selectionHandler);
    GtRelease(m_touchHandler);
    GtRelease(m_transactionID);
    GtSuperDealloc();
}

- (void) setView:(UIView*) view forDisplayState:(GtGridViewCellDisplayState) state cacheKey:(id) cacheKey
{
    if(view != m_views[state])
    {
        [self hideViewForDisplayState:state];
        
        GtAssignObject(m_views[state], view);
        GtAssignObject(m_viewKeys[state], cacheKey);
    }
}

- (UIView*) viewForDisplayState:(GtGridViewCellDisplayState) state
{
    return m_views[state];
}

- (id) cacheKeyForDisplayState:(GtGridViewCellDisplayState) state
{
    return m_viewKeys[state];
}

- (void) objectCacheWillCacheObject:(GtObjectCache*) cache
{
   [self hideAllViews];
    
    m_superview = nil;
    m_viewController = nil;
}

- (void) objectCacheWillUncacheObject:(GtObjectCache*) cache
{
}

- (void) objectCacheWillPurgeObject:(GtObjectCache*) cache
{
}

@end

@interface GtGridViewCellController ()
@property (readwrite, retain, nonatomic) GtGridViewCellDisplayContext* visibleContext;
@property (readwrite, assign, nonatomic) GtGridViewController* viewController;
@property (readwrite, assign, nonatomic) UIView* superview;
@end

@implementation GtGridViewCellController

@synthesize gridViewObject = m_gridViewObject;
@synthesize visibleContext = m_displayContext;

@synthesize frame = m_frame;

GtSynthesizeStructProperty(isHidden, setHidden, BOOL, m_flags)
GtSynthesizeStructProperty(displayState, setDisplayState, GtGridViewCellDisplayState, m_flags)
GtSynthesizeStructProperty(previousDisplayState, setPreviousDisplayState, GtGridViewCellDisplayState, m_flags)

GtSynthesizeStructGetterProperty(isHighlighted, BOOL, m_flags)
GtSynthesizeStructGetterProperty(isSelected, BOOL, m_flags)
GtSynthesizeStructGetterProperty(isDisabled, BOOL, m_flags)

- (CGRect) calculateLayoutFrameInBounds:(CGRect) bounds
{
    return bounds;
}

- (CGSize) calculateSizeForLayout:(GtArrangeableViewHint) hint
{
    return hint.size;
}

- (void) setSelected:(BOOL) selected
{
//    if(m_flags.isSelected != selected)
    {
        m_flags.isSelected = selected;
        [self cellDidChangeState];
        
        if(self.isSelected)
        {
            [self.visibleContext.viewController gridViewCellWasSelected:self];
        }
    }
}

- (void) setHighlighted:(BOOL) highlighted
{
//    if(m_flags.isHighlighted != highlighted)
    {
        m_flags.isHighlighted = highlighted;
        [self cellDidChangeState];
    }
}

- (void) cellDidChangeState
{
    [self.view setNeedsDisplay];
}

- (void) setDisabled:(BOOL) disabled
{
//    if(m_flags.isDisabled != disabled)
    {
        m_flags.isDisabled = disabled;
        [self cellDidChangeState];
    }
}


#if DEBUG
- (void) setGridViewObject:(id) object
{
    GtAssertImplementsGridViewObjectProtocol(object);
    GtAssignObject(m_gridViewObject, object);
}
#endif

- (id) init
{
    if((self = [super init]))
    {
    }
    
    return self;
}

- (id) initWithGridViewObject:(id) gridViewObject
{
    if((self = [self init]))
    {
        self.gridViewObject = gridViewObject;
    }
    
    return self;
}

- (void) dealloc 
{   
    GtRelease(m_displayContext);
    GtRelease(m_gridViewObject);
    GtSuperDealloc();
}

- (BOOL) touchPointSelectsCell:(CGPoint) point
{
    return CGRectContainsPoint(self.frame, point);
}

- (void) cellWillLoad
{
}

- (void) cellDidUnload
{
}

- (void) cellWillUnload
{
}

- (BOOL) isCellLoaded
{
    return m_displayContext != nil;
}

- (void) cellWillAppearInSuperview:(UIView*) superview 
                    viewController:(GtGridViewController*) controller
{
    [controller.objectCache uncacheObject:&m_displayContext reuseIdentifier:[self class]];
    if(!m_displayContext)
    {
        self.visibleContext = [GtGridViewCellDisplayContext displayContext];
        self.visibleContext.touchHandler = [self.gridViewObject createGridViewTouchHandler];
        self.visibleContext.selectionHandler = [self.gridViewObject createGridViewSelectionHandler];
    }
    self.visibleContext.viewController = controller;
    self.visibleContext.superview = superview;
    [self cellWillLoad];
    [self cellDidChangeState];
}

- (void) cellDidDisappearFromSuperview:(UIView*) superview  
                        viewController:(GtGridViewController*) controller
{
    [self cellWillUnload];
    
    if(self.transactionID)
    {
        [m_displayContext.viewController.actionContext cancelActionByID:self.transactionID];
    }
    
    [controller.objectCache cacheObject:&m_displayContext reuseIdentifier:[self class]];
    
    [self cellDidUnload];
}

- (void) setWasSelectedInViewController:(GtGridViewController*) controller
{
}

- (id) transactionID
{
    return m_displayContext.transactionID;
}

- (void) setTransactionID:(id) transactionID
{
    m_displayContext.transactionID = transactionID;
}

- (UIView*) superview
{
    return m_displayContext.superview;
}

- (id<GtGridViewCellTouchHandler>) touchHandler
{
    return m_displayContext.touchHandler;
}

- (id<GtGridViewCellSelectionHandler>) selectionHandler
{
    return m_displayContext.selectionHandler;
}

- (void) setSuperview:(UIView*) superview
{
    m_displayContext.superview = superview;
}

- (GtGridViewController*) viewController
{
    return m_displayContext.viewController;
}

- (void) setViewController:(GtGridViewController*) viewController
{
   m_displayContext.viewController = viewController;
}

- (UIView*) viewForDisplayState:(GtGridViewCellDisplayState) displayState
{
    UIView* view = [m_displayContext viewForDisplayState:displayState];
    if(!view)
    {
        view = [self createViewForDisplayState:displayState];
        [m_displayContext setView:view forDisplayState:displayState cacheKey:[self cacheKeyForDisplayState:displayState]];
        [self.superview addSubview:view];
    }
    if(view.gridViewCellController != self)
    {
        view.gridViewCellController = self;
    }
    return view;
}

- (UIView*) view
{
    return [self viewForDisplayState:self.displayState];
}

- (UIView*) viewForPreviousDisplayState
{
    return [self viewForDisplayState:self.previousDisplayState];
}

- (UIView*) createViewForDisplayState:(GtGridViewCellDisplayState) displayState
{
    GtAssertFailedNotImplemented();
    return nil;
}

- (id) cacheKeyForDisplayState:(GtGridViewCellDisplayState) displayState
{
    switch(displayState)
    {
        case GtGridViewCellDisplayStateFirst:
            return @"first";
        break;
        
        case GtGridViewCellDisplayStateSecond:
            return @"second";
        break;

        case GtGridViewCellDisplayStateThird:
            return @"third";
        break;

    }
}

- (void) hideViewForDisplayState:(GtGridViewCellDisplayState) displayState
{
    [m_displayContext hideViewForDisplayState:displayState];
}

- (void) cellWillChangeStateAnimated:(BOOL) animated
                            data:(id) dataOrNil
              completionCallback:(GtBlock) completionCallback;
{
    completionCallback();
}

- (void) _hideViewsForInactiveStates
{
    for(GtGridViewCellDisplayState state = kFirstState;
        state <= kLastState;
        state++)
    {
        if(state != self.displayState)
        {
            [m_displayContext hideViewForDisplayState:state];
        }
    }
}

- (void) layoutSubviews
{
    self.view.frameOptimizedForLocation = self.frame;
}

- (void) cellDidChangeDisplayState
{
}

- (void) beginChangingDisplayStateTo:(GtGridViewCellDisplayState) state
                            withData:(id) dataOrNil
                            animated:(BOOL) animated
{
    GtBlock changeState = ^{
        [self layoutSubviews];
        [self cellDidChangeDisplayState];
        [self _hideViewsForInactiveStates];
    };

    self.previousDisplayState = self.displayState;
    self.displayState = state;

    [self cellWillChangeStateAnimated:animated
        data:dataOrNil 
        completionCallback:GtReturnAutoreleased([changeState copy])];
}

- (BOOL) hasViewForDisplayState:(GtGridViewCellDisplayState) displayState
{
    return [m_displayContext viewForDisplayState:displayState] != nil;
}

- (void) setFrame:(CGRect) frame
{
    m_frame = frame;
    [self layoutSubviews];
}

@end



