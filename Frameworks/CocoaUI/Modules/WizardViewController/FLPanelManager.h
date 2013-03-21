//
//  FLPanelManager.h
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FLFramedView.h"
#import "FLPanelViewController.h"
#import "FLTransition.h"
#import "FLCompatibleViewController.h"

@protocol FLPanelManagerDelegate;

typedef void (^FLPanelViewControllerBlock)(FLPanelViewController* panel);

@interface FLPanelManager : FLCompatibleViewController {
@private
    NSMutableArray* _panels;
    NSMutableArray* _panelViews;
    NSUInteger _currentPanel;
    BOOL _started;
    id<FLPanelManagerDelegate> _delegate;

    Class _showTransition;
    Class _hideTransition;
}
@property (readwrite, assign, nonatomic) id<FLPanelManagerDelegate> delegate;
@property (readonly, assign, nonatomic) NSUInteger panelCount;
@property (readonly, strong, nonatomic) FLPanelViewController* visiblePanel;

@property (readwrite, assign, nonatomic) Class showTransition;
@property (readwrite, assign, nonatomic) Class hideTransition;


- (void) addPanel:(FLPanelViewController*) panel;

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

- (void) showFirstPanel;
- (BOOL) isShowingFirstPanel;
- (BOOL) isShowingLastPanel;

- (void) addPanelView:(SDKView*) panelView toView:(SDKView*) superview animated:(BOOL) animated;
- (void) removePanelViews:(BOOL) animated;

@end

@protocol FLPanelManagerDelegate <NSObject>

- (void) panelManager:(FLPanelManager*) controller
        willShowPanel:(FLPanelViewController*) panel
        willHidePanel:(FLPanelViewController*) panel
    animationDuration:(CGFloat) animationDuration;

- (void) panelManager:(FLPanelManager*) controller 
         didShowPanel:(FLPanelViewController*) panel
         didHidePanel:(FLPanelViewController*) panel;

- (void) panelManager:(FLPanelManager*) controller 
  panelStateDidChange:(FLPanelViewController*) panel;

- (void) panelManager:(FLPanelManager*) controller 
          didAddPanel:(FLPanelViewController*) panel;

- (void) panelManager:(FLPanelManager*) controller 
       didRemovePanel:(FLPanelViewController*) panel;


@end
