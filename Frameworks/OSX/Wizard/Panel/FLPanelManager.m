//
//  FLPanelManager.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPanelManager.h"
#import "FLWizardStyleViewTransition.h"

@interface FLPanelViewController()
@property (readwrite, assign, nonatomic, getter=isVisiblePanel) BOOL visiblePanel;
@end

@interface FLPanelManager ()
@property (readonly, strong, nonatomic) FLOrderedCollection* panels;
@property (readwrite, strong, nonatomic) id visiblePanelIdentifier;

- (void) showPanelAtIndex:(NSUInteger) idx 
                 animated:(BOOL) animated
               completion:(FLPanelViewControllerBlock) completion;

@end

@implementation FLPanelManager

@synthesize visiblePanelIdentifier = _visiblePanelIdentifier;
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
    [_visiblePanelIdentifier release];
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
    _panels = [[FLOrderedCollection alloc] init];
    _started = NO;
    self.forwardTransition = [FLWizardStyleForwardTransition wizardStyleForwardTransition];
    self.backwardTransition = [FLWizardStyleBackwardTransition wizardStyleBackwardTransition];
    
    self.view.autoresizesSubviews = YES;
    _contentEnclosure.autoresizesSubviews = YES;
    _contentView.autoresizesSubviews = NO;
    
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSUInteger) panelCount {
    return _panels.count;
}

- (NSUInteger) currentPanelIndex {
    return _visiblePanelIdentifier ? [_panels indexForKey:_visiblePanelIdentifier] : NSNotFound;
}

- (void) setPanelFrame:(FLPanelViewController*) panel {

    CGRect bounds = _contentView.bounds;
    if(panel.panelFillsView) {
        panel.view.frame = _contentView.bounds;
    }
    else {
        CGRect frame = FLRectCenterRectInRectHorizontally(_contentView.bounds, panel.view.frame);
        frame.origin.y = FLRectGetBottom(bounds) - frame.size.height - 60.0f; // = FLRectCenterRectInRectVertically(bounds, frame);
        panel.view.frame = FLRectOptimizedForViewLocation(frame);
    }
    
//    FLLog(@"panel frame view %@", NSStringFromRect(panel.view.frame));

}

- (void) panelDidChangeCanOpenValue:(FLPanelViewController*) panel {
    [self panelStateDidChange:panel];
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(FLStringsAreEqual(keyPath, @"frame")) {
        [self setPanelFrame:self.visiblePanel];
        
//        FLLog(@"wizard view %@, encl view: %@, content view: %@", NSStringFromRect(self.view.frame), NSStringFromRect(_contentEnclosure.frame), NSStringFromRect(_contentView.frame));
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) addPanel:(FLPanelViewController*) panel forIdentifier:(id) identifier withDelegate:(id) delegate {
    [panel view]; // make sure it's loaded from nib

    panel.identifier = identifier;
    
//    panel.view.wantsLayer = YES;
    [panel didMoveToPanelManager:self];
    [_panels setObject:panel forKey:identifier];
    [self didAddPanel:panel];
    [self panelStateDidChange:panel];
    
    if(delegate) {
        [panel setDelegate:delegate];
    }
}

- (void) addPanel:(FLPanelViewController*) panel forIdentifier:(id) identifier {
    [self addPanel:panel forIdentifier:identifier withDelegate:nil];
}

- (void) removePanelForIdentifier:(id) identifier {
    FLPanelViewController* panel = [self panelForIdentifier:identifier];
    [_panels removeObject:panel];
    [panel didMoveToPanelManager:nil];
    [self didRemovePanel:panel];
    [self panelStateDidChange:panel];
}

- (FLPanelViewController*) visiblePanel {
    return _started ? [_panels objectForKey:_visiblePanelIdentifier] : nil;
}

- (BOOL) canOpenPanelForIdentifier:(id) identifier {
    if(!_started) {
        return NO;
    }
    
    NSUInteger idx = [_panels indexForKey:identifier];
    if(idx == NSNotFound) {
        return NO;
    }
    
    FLPanelViewController* currentPanel = [_panels objectForKey:identifier];
    if([currentPanel isHidden]) {
        return NO;
    }
    
    if([currentPanel isIndependent]) {
        return [currentPanel isEnabled];
    }
    
    NSUInteger currentIdx = [self currentPanelIndex];
    if(idx <= currentIdx) {
        return [currentPanel isEnabled];
    }
       
    for(NSUInteger i = currentIdx; i < idx; i++) {
        FLPanelViewController* panel = [_panels objectAtIndex:i];
        if(panel.canOpenNextPanel == NO) {
            return NO;
        }
    }

    return [currentPanel isEnabled];
}

- (id) panelForIdentifier:(id) identifier {
    return [_panels objectForKey:identifier];
}

- (void) showNextPanelAnimated:(BOOL) animated
                    completion:(void (^)(FLPanelViewController*)) completion {
                    
    NSUInteger nextIndex = [self currentPanelIndex] + 1;
    while(nextIndex < _panels.count) {
        
        if(![[_panels objectAtIndex:nextIndex] isHidden]) {
            [self showPanelAtIndex:nextIndex
                      animated:animated 
                    completion:completion];
            break;
        }

        ++nextIndex;
    }

}

- (void) showPreviousPanelAnimated:(BOOL) animated
                        completion:(void (^)(FLPanelViewController*)) completion {

    NSInteger prevIndex = [self currentPanelIndex] - 1;
    
    while(prevIndex >= 0) {
    
        if(![[_panels objectAtIndex:prevIndex] isHidden]) {
            [self showPanelAtIndex:prevIndex 
                          animated:animated 
                        completion:completion];
        
            break;
        }
    
        --prevIndex;
    }
}       

- (void) didShowPanel:(FLPanelViewController*) toShow 
         didHidePanel:(FLPanelViewController*) toHide {

    if(toHide) {
        [toHide.view removeFromSuperview];
        [self didHidePanel:toHide];
        [toHide panelDidDisappear];
    }
    
    toShow.visiblePanel = YES;
    
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

    // make sure they're loaded from nib.
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

    toHide.visiblePanel = NO;
    if([toHide alertViewController]) {
        [[toHide.alertViewController view] removeFromSuperview];
        toHide.alertViewController = nil;
    }
    
    FLViewTransition* transition = nil;

#if BROKEN
    NSUInteger currentIdx = [self currentPanelIndex]

    CGFloat animationDuration = 0.0f;
    if(animated) {
        if(idx > currentIdx) {
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

    self.visiblePanelIdentifier = [_panels keyAtIndex:idx];
    
    [_contentView addSubview:[toShow view]];
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

- (void) showPanelForIdentifier:(id) identifier 
                       animated:(BOOL) animated
                     completion:(FLPanelViewControllerBlock) completion {

    NSUInteger idx = [_panels indexForKey:identifier];
    FLAssert(idx != NSNotFound);
    
    if(idx != NSNotFound) {
        [self showPanelAtIndex:idx
                      animated:YES 
                    completion:completion];
    }
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

- (void) startPanelManager {
    [self setNextResponder:self.view.window];
    [self panelManagerWillStart];
    [self showFirstPanel];  
    [self panelManagerDidStart];
}

- (void) showPanelsInWindow:(NSWindow*) window {
    [window setContentView:self.view];
    [self startPanelManager];
}

- (void) showPanelsInView:(NSView*) view {
    self.view.frame = view.bounds;
    [view addSubview:self.view];
    [self startPanelManager];
}
- (void) panelManagerWillStart {
}
- (void) panelManagerDidStart {
}

//- (void) showAlertView:(NSViewController*) viewController
//               overView:(NSView*) view
//               animated:(BOOL) animated;

- (void) showAlertView:(NSViewController*) toShow
    overViewController:(NSViewController*) toHide
        withTransition:(FLViewTransition*) transition 
            completion:(dispatch_block_t) completion {
    
    [_contentView addSubview:[toShow view]];
    
    if(transition) {
        completion = FLCopyWithAutorelease(completion);
        
        [transition startShowingView:toShow.view 
                          viewToHide:toHide.view 
                          completion:^{

            
            [toHide.view removeFromSuperview];
              
            if(completion) {
              completion();
            }
        }];
    }
    else {
            
        [toHide.view removeFromSuperview];

        if(completion) {
            completion();
        }
    }

    
}               

- (void) hideAlertView {

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