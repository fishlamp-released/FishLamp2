//
//  FLPanelManager.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPanelManager.h"
#import "FLWizardStyleViewTransition.h"

@interface FLPanelManager ()
@property (readonly, strong, nonatomic) NSArray* panels;
@property (readonly, assign, nonatomic) NSUInteger currentPanelIndex;
@end

@implementation FLPanelManager

@synthesize currentPanelIndex = _currentPanel;
@synthesize panels = _panels;
@synthesize forwardTransition = _forwardTransition;
@synthesize backwardTransition = _backwardTransition;

- (void) dealloc {
#if __MAC_10_8
    [self.view removeObserver:self forKeyPath:@"frame" context:nil];
#else 
    [self.view removeObserver:self forKeyPath:@"frame"];
#endif

#if FL_MRC
    [_panelAreas release];
    [_backwardTransition release];
    [_forwardTransition release];
    [_panelViews release];
    [_panels release];
    [super dealloc];
#endif
}

- (void) awakeFromNib {
    [super awakeFromNib];
     
    _panelAreas = [[NSMutableArray alloc] init];
    _panels = [[NSMutableArray alloc] init];
    _currentPanel = 0;
    _started = NO;
    self.forwardTransition = [FLWizardStyleForwardTransition wizardStyleForwardTransition];
    self.backwardTransition = [FLWizardStyleBackwardTransition wizardStyleBackwardTransition];
    
    self.view.autoresizesSubviews = NO;
    
    _contentEnclosure.autoresizesSubviews = NO;
    _contentView.autoresizesSubviews = NO;
    
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSUInteger) panelCount {
    return _panels.count;
}

- (void) setPanelFrame:(FLPanelViewController*) panel {

    CGRect bounds = self.view.bounds;
    if(panel.panelFillsView) {
        panel.view.frame = self.view.bounds;
    }
    else {
        CGRect frame = FLRectCenterRectInRectHorizontally(self.view.bounds, panel.view.frame);
        frame.origin.y = FLRectGetBottom(bounds) - frame.size.height - 60.0f; // = FLRectCenterRectInRectVertically(bounds, frame);
        panel.view.frame = FLRectOptimizedForViewLocation(frame);
    }
}

- (void) panelDidChangeCanOpenValue:(FLPanelViewController*) panel {
    [self panelStateDidChange:panel];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(FLStringsAreEqual(keyPath, @"frame")) {
        [self setPanelFrame:self.visiblePanel];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) addPanel:(FLPanelViewController*) panel withDelegate:(id) delegate {
    [panel view]; // make sure it's loaded from nib


//    panel.view.wantsLayer = YES;
    [panel didMoveToPanelManager:self];
    [_panels addObject:panel];
    [self didAddPanel:panel];
    [self panelStateDidChange:panel];
    
    if(delegate) {
        [panel setDelegate:delegate];
    }
}

- (void) addPanel:(FLPanelViewController*) panel {
    [self addPanel:panel withDelegate:nil];
}

- (void) removePanelForTitle:(id) title {
    FLPanelViewController* panel = [self panelForTitle:title];
    [_panels removeObject:panel];
    [panel didMoveToPanelManager:nil];
    [self didRemovePanel:panel];
    [self panelStateDidChange:panel];
}

- (FLPanelViewController*) visiblePanel {
    return _started ? [_panels objectAtIndex:_currentPanel] : nil;
}

- (BOOL) canShowPanelForPanelTitle:(id) title {
    
    if(_started) {
        for(FLPanelViewController* panel in _panels) {
            if(panel.canOpenNextPanel == NO) {
                return NO;
            }
            if([title isEqual:[panel title]]) {
                return panel.canOpenNextPanel;
            }
        }
    }
    return NO;
}

- (BOOL) canOpenPanelForTitle:(id) title {
    if(!_started) {
        return NO;
    }
    
//    if([self.visiblePanel.title isEqual:title]) {
//        return YES;
//    }

    NSUInteger idx = NSNotFound;
    for(NSUInteger i = 0; i < _panels.count; i++) {
    
        if([title isEqual:[[_panels objectAtIndex:i] title]]) {
            idx = i;
            break;
        }
    }
    if(idx == NSNotFound) {
        return NO;
    }
    if(idx <= _currentPanel) {
        return YES;
    }
        
    for(NSUInteger i = _currentPanel; i < idx; i++) {
        FLPanelViewController* panel = [_panels objectAtIndex:i];
        if(panel.canOpenNextPanel == NO) {
            return NO;
        }
    }

    return YES;
}

- (FLPanelViewController*) panelForTitle:(id) title {
    for(FLPanelViewController* panel in _panels) {
        if([title isEqual:[panel title]]) {
            return panel;
        }
    }
    
    return nil;
}

- (NSInteger) panelIndexForTitle:(id) title {
    for(NSInteger i = 0; i < _panels.count; i++) {
        if([title isEqual:[[_panels objectAtIndex:i] title]]) {
            return i;
        }
    }
    
    return NSNotFound;
}

- (void) showNextPanelAnimated:(BOOL) animated
                          completion:(void (^)(FLPanelViewController*)) completion {

    [self showPanelAtIndex:_currentPanel + 1 
                        animated:animated 
                      completion:completion];
}

- (void) showPreviousPanelAnimated:(BOOL) animated
                        completion:(void (^)(FLPanelViewController*)) completion {

    [self showPanelAtIndex:_currentPanel - 1 
                        animated:animated 
                      completion:completion];
}       

- (void) didShowPanel:(FLPanelViewController*) toShow 
         didHidePanel:(FLPanelViewController*) toHide {

    if(toHide) {
        [toHide.view removeFromSuperview];
        [self didHidePanel:toHide];
        [toHide panelDidDisappear];
    }
    [toShow setNextResponder:self];
    [self.view.window makeFirstResponder:toShow];

    [toShow panelDidAppear];
    [self didShowPanel:toShow];
}                                          

- (void) showPanelAtIndex:(NSUInteger) idx 
                 animated:(BOOL) animated
               completion:(FLPanelViewControllerBlock) completion {
    
    FLPanelViewController* toShow = [_panels objectAtIndex:idx];
    FLAssertNotNil(toShow);
    
    FLPanelViewController* toHide = [self visiblePanel];
    [toShow view];
    [toHide view];

    if(toShow == toHide) {
        if(toShow.view.superview != nil) {
            // already showing. just return.
            if(completion) {
                completion(toShow);
            }
            return;
        }
        else {
            toHide = nil;
        }
    }
    
    _started = YES;

    FLViewTransition* transition = nil;

#if BROKEN
    CGFloat animationDuration = 0.0f;
    if(animated) {
        if(idx > _currentPanel) {
            transition = self.forwardTransition;
        }
        else {
            transition = self.backwardTransition;
        }
    }
        
    if(transition) {
        animationDuration = [transition duration];
    }
#endif

    [self removePanelViews:animated];

    [self setPanelFrame:toShow];

    if(toHide) {
        [toHide panelWillDisappear];
        [self willHidePanel:toHide];

        for(id panelArea in _panelAreas) {
            FLPerformSelector1(panelArea, @selector(panelWillDisappear:), toHide);
        }
    }

    [self willShowPanel:toShow];

    _currentPanel = idx;
    [self.view addSubview:[toShow view]];
    [toShow panelWillAppear];
    for(id panelArea in _panelAreas) {
        FLPerformSelector1(panelArea, @selector(panelWillAppear:), toShow);
    }
    
    [self.view.window makeFirstResponder:self];

    [self panelStateDidChange:toHide];
    [self panelStateDidChange:toShow];

    if(transition) {
        completion = FLCopyWithAutorelease(completion);
        
        [transition startShowingView:toShow.view 
                          viewToHide:toHide.view 
                          completion:^{

            [self didShowPanel:toShow didHidePanel:toHide];
            
            for(id panelArea in _panelAreas) {
                if(toHide) { 
                    FLPerformSelector1(panelArea, @selector(panelDidDisappear:), toHide);
                }
                FLPerformSelector1(panelArea, @selector(panelDidAppear:), toShow);
            }
              
            if(completion) {
              completion(toShow);
            }
        }];
    }
    else {
        [self didShowPanel:toShow didHidePanel:toHide];
            
        if(completion) {
            completion(toShow);
        }
    }
}      

- (void) showFirstPanel {
    [self showPanelAtIndex:0 animated:NO completion:nil];
}

- (void) showPanelForTitle:(id) title 
                animated:(BOOL) animated
              completion:(FLPanelViewControllerBlock) completion {

    [self showPanelAtIndex:[self panelIndexForTitle:title] 
                  animated:YES 
                completion:completion];
}    

- (BOOL) isShowingFirstPanel {
    return _started && self.currentPanelIndex == 0;
}

- (BOOL) isShowingLastPanel {
    return _started && self.currentPanelIndex == (_panels.count - 1);
}
          
- (void) addPanelView:(SDKView*) panelView toView:(SDKView*) superview animated:(BOOL) animated {

// TODO: animate
//    panelView.wantsLayer = YES;
    if(!_panelViews) {
        _panelViews = [[NSMutableArray alloc] init];
    }
    [_panelViews addObject:panelView];
    [superview addSubview:panelView];
}

- (void) removePanelViews:(BOOL) animated {

// TODO: animate

    for(SDKView* view in _panelViews) {
        [view removeFromSuperview];
    }

    [_panelViews removeAllObjects];
}

- (void) addPanelArea:(id<FLPanelArea>) area {
    [_panelAreas addObject:area];
}

- (void) willShowPanel:(FLPanelViewController*) panel {
}

- (void) willHidePanel:(FLPanelViewController*) panel {
}

- (void) didShowPanel:(FLPanelViewController*) panel {
}

- (void) didHidePanel:(FLPanelViewController*) panel {
}

- (void) panelStateDidChange:(FLPanelViewController*) panel {
}

- (void) didAddPanel:(FLPanelViewController*) panel {
}

- (void) didRemovePanel:(FLPanelViewController*) panel {
}

- (void) showPanelsInWindow:(NSWindow*) window {
    [window setContentView:self.view];
    [self setNextResponder:window];
    [self showFirstPanel];  
}

- (void) showPanelsInView:(NSView*) view {
    
}


@end


//        FLSlideInAndDropTransition* transition = 
//            [FLSlideInAndDropTransition transitionWithViewToShow:[toShow view] 
//                                                      viewToHide:toHide ? [toHide view] : nil];

                             
//- (void) hidePanelAnimated:(BOOL) animated 
//                            hide:(FLPanelViewController*) toHide
//                            show:(FLPanelViewController*) toShow
//                      completion:(FLPanelViewControllerBlock) completion {                            
//
//    FLAssertNotNil(toShow);
//
//    [self setFirstResponder];
//    [self setPanelFrame:toShow];
//    [self willHidePanel:toHide willShowPanel:toShow];
//            
//    completion = FLCopyWithAutorelease(completion);
//    [self.view addSubview:[toShow view]];
//        
//    dispatch_block_t finished = ^{
//        [self didHidePanel:toHide didShowPanel:toShow];
//         
//        if(completion) {
//            completion(toShow);
//        }        
//        [self.view.window display];
//    };
//      
//    if(0 && animated) {
//
//        FLSlideInAndDropTransition* transition = 
//            [FLSlideInAndDropTransition transitionWithViewToShow:[toShow view] 
//                                                      viewToHide:toHide ? [toHide view] : nil];
//
//        
////        FLWizardStyleViewTransition* transition = 
////            [FLWizardStyleViewTransition transitionWithViewToShow:[toShow view] 
////                                                              viewToHide:toHide != nil ? [toHide view] : nil];
//
//        [transition startAnimating:^{
//            finished();
//        }];
//    }
//    else {
//        [toHide.view removeFromSuperview];
//        finished();
//    }
//}