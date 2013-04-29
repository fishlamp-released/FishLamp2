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
#import "FLOrderedCollection.h"

@protocol FLPanelManagerDelegate;

typedef void (^FLPanelViewControllerBlock)(FLPanelViewController* panel);

@interface FLPanelManager : NSViewController {
@private
    FLOrderedCollection* _panels;
    id _visiblePanelIdentifier;
    
    FLViewTransition* _forwardTransition;
    FLViewTransition* _backwardTransition;
    
    IBOutlet NSView* _contentEnclosure;
    IBOutlet NSView* _contentView;
    
    BOOL _started;

    NSMutableArray* _panelViews;
    NSMutableArray* _panelAreas;
}

@property (readonly, assign, nonatomic) NSUInteger panelCount;
@property (readonly, strong, nonatomic) FLPanelViewController* visiblePanel;
@property (readonly, strong, nonatomic) id visiblePanelIdentifier;

@property (readwrite, strong, nonatomic) FLViewTransition* forwardTransition;
@property (readwrite, strong, nonatomic) FLViewTransition* backwardTransition;

- (void) showPanelsInWindow:(NSWindow*) window;

- (void) showPanelsInView:(NSView*) window;

- (void) addPanel:(FLPanelViewController*) panel forIdentifier:(id) identifier;

- (void) addPanel:(FLPanelViewController*) panel forIdentifier:(id) identifier withDelegate:(id) delegate;

- (id) panelForIdentifier:(id) identifier;

- (void) removePanelForIdentifier:(id) identifier;

- (BOOL) canOpenPanelForIdentifier:(id) identifier;

//
// panel switching
//
- (void) showNextPanelAnimated:(BOOL) animated
                    completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPreviousPanelAnimated:(BOOL) animated
                        completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPanelForIdentifier:(id) identifier 
                       animated:(BOOL) animated
                     completion:(FLPanelViewControllerBlock) completion;

- (BOOL) isShowingFirstPanel;

- (BOOL) isShowingLastPanel;

// panel views

- (void) addPanelView:(SDKView*) panelView 
               toView:(SDKView*) superview 
             animated:(BOOL) animated;

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
- (void) panelManagerWillStart;
- (void) panelManagerDidStart;

- (void) showAlertView:(NSViewController*) toShow
    overViewController:(NSViewController*) toHide
        withTransition:(FLViewTransition*) transition 
            completion:(dispatch_block_t) completion;

@end

@interface FLPanelManager ()
- (void) panelDidChangeCanOpenValue:(FLPanelViewController*) panel;
@end