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

@protocol FLPanelManagerDelegate;

typedef void (^FLPanelViewControllerBlock)(FLPanelViewController* panel);

@interface FLPanelManager : NSViewController {
@private
    NSMutableArray* _panels;
    NSUInteger _currentPanel;
    BOOL _started;
    id<FLPanelManagerDelegate> _delegate;
}
@property (readwrite, assign, nonatomic) id<FLPanelManagerDelegate> delegate;
@property (readonly, assign, nonatomic) NSUInteger panelCount;
@property (readonly, strong, nonatomic) FLPanelViewController* visiblePanel;

- (void) addPanel:(FLPanelViewController*) panel;

- (FLPanelViewController*) panelForKey:(id) key;

- (void) removePanel:(FLPanelViewController*) panel;

- (BOOL) canShowPanelForPanelKey:(id) key;

- (BOOL) canOpenPanelForKey:(id) key;

//
// panel switching
//
- (void) showNextPanelAnimated:(BOOL) animated
                    completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPreviousPanelAnimated:(BOOL) animated
                        completion:(void (^)(FLPanelViewController*)) completion;

- (void) showPanelForKey:(id) key 
                animated:(BOOL) animated
              completion:(FLPanelViewControllerBlock) completion;

- (void) showFirstPanel;
- (BOOL) isShowingFirstPanel;
- (BOOL) isShowingLastPanel;

@end

@protocol FLPanelManagerDelegate <NSObject>

- (void) panelManager:(FLPanelManager*) controller
                       willHidePanel:(FLPanelViewController*) panel
                       willShowPanel:(FLPanelViewController*) panel;

- (void) panelManager:(FLPanelManager*) controller 
                        didHidePanel:(FLPanelViewController*) panel
                        didShowPanel:(FLPanelViewController*) panel;

- (Class) panelManagerGetForwardTransitionClass:(FLPanelManager*) controller; 

- (Class) panelManagerGetBackwardTransitionClass:(FLPanelManager*) controller; 


//- (BOOL) wizardViewController:(FLWizardViewController*) wizard
//panelWillRespondToNextButton:(FLPanelViewController*) panel;
//
//- (BOOL) panel:(FLPanelViewController*) panel respondToBackButton:(FLWizardViewController*) wizard;
//- (BOOL) panel:(FLPanelViewController*) panel willRespondToOtherButtonInWizard:(FLWizardViewController*) wizard;


@end
