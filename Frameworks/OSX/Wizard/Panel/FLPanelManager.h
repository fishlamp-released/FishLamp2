//
//  FLPanelManager.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLCocoaUIRequired.h"
#import "FLFramedView.h"
#import "FLPanelViewController.h"
#import "FLViewTransition.h"

@protocol FLPanelManagerDelegate;

typedef void (^FLPanelViewControllerBlock)(FLPanelViewController* panel);

@interface FLPanelManager : NSViewController {
@private
    NSMutableArray* _panels;
    NSMutableArray* _panelViews;
    NSUInteger _currentPanel;
    BOOL _started;

    FLViewTransition* _forwardTransition;
    FLViewTransition* _backwardTransition;
    
    IBOutlet NSView* _contentEnclosure;
    IBOutlet NSView* _contentView;
    
    NSMutableArray* _panelAreas;
}

@property (readonly, assign, nonatomic) NSUInteger panelCount;
@property (readonly, strong, nonatomic) FLPanelViewController* visiblePanel;

@property (readwrite, strong, nonatomic) FLViewTransition* forwardTransition;
@property (readwrite, strong, nonatomic) FLViewTransition* backwardTransition;

- (void) showPanelsInWindow:(NSWindow*) window;

- (void) showPanelsInView:(NSView*) window;

- (void) addPanel:(FLPanelViewController*) panel;
- (void) addPanel:(FLPanelViewController*) panel withDelegate:(id) delegate;

- (FLPanelViewController*) panelForTitle:(id) title;

- (void) removePanelForTitle:(id) title;

- (BOOL) canShowPanelForPanelTitle:(id) title;

- (BOOL) canOpenPanelForTitle:(id) title;

//
// panel switching
//
- (void) showNextPanelAnimated:(BOOL) animated
                    completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPreviousPanelAnimated:(BOOL) animated
                        completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPanelForTitle:(id) title 
                animated:(BOOL) animated
              completion:(FLPanelViewControllerBlock) completion;

- (void) showPanelAtIndex:(NSUInteger) idx 
                 animated:(BOOL) animated
               completion:(FLPanelViewControllerBlock) completion;

- (BOOL) isShowingFirstPanel;

- (BOOL) isShowingLastPanel;

// panel views

- (void) addPanelView:(SDKView*) panelView toView:(SDKView*) superview animated:(BOOL) animated;

- (void) removePanelViews:(BOOL) animated;

// panel areas

- (void) addPanelArea:(id<FLPanelArea>) area;

// optional overrides
- (void) showFirstPanel;

- (void) willShowPanel:(FLPanelViewController*) panel;
- (void) willHidePanel:(FLPanelViewController*) panel;
- (void) didShowPanel:(FLPanelViewController*) panel;
- (void) didHidePanel:(FLPanelViewController*) panel;

- (void) panelStateDidChange:(FLPanelViewController*) panel;

- (void) didAddPanel:(FLPanelViewController*) panel;

- (void) didRemovePanel:(FLPanelViewController*) panel;




@end

@interface FLPanelManager ()
- (void) panelDidChangeCanOpenValue:(FLPanelViewController*) panel;
@end