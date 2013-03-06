//
//  FLPanelManager.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 3/3/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPanelManager.h"

@interface FLPanelManager ()
@property (readonly, strong, nonatomic) NSArray* panels;
@property (readonly, assign, nonatomic) NSUInteger currentPanelIndex;
@end

@implementation FLPanelManager

@synthesize currentPanelIndex = _currentPanel;
@synthesize panels = _panels;
@synthesize delegate = _delegate;
@synthesize showTransition = _showTransition;
@synthesize hideTransition = _hideTransition;

- (void) dealloc {
    [self.view removeObserver:self forKeyPath:@"frame" context:nil];
#if FL_MRC
    [_panelViews release];
    [_panels release];
    [super dealloc];
#endif
}

- (void) awakeFromNib {
    [super awakeFromNib];
    _panels = [[NSMutableArray alloc] init];
    _currentPanel = 0;
    _started = NO;
    [self.view setWantsLayer:YES];
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSUInteger) panelCount {
    return _panels.count;
}

- (void) setPanelFrame:(FLPanelViewController*) panel {

    CGRect frame = panel.view.frame;
    CGRect bounds = self.view.bounds;
    bounds = CGRectInset(bounds, 1.0, 1.0);
    
    NSUInteger originalMask = panel.view.autoresizingMask;
    
    if(FLBitTest(originalMask, (NSViewWidthSizable))) {
        frame.size.width = bounds.size.width;
        frame.origin.x = bounds.origin.x;
    }
    else {
        frame = FLRectCenterRectInRectHorizontally(bounds, frame);
    }

    if(FLBitTest(originalMask, (NSViewHeightSizable))) {
        frame.size.height = bounds.size.height;
        frame.origin.y = bounds.origin.y;
    }
    else {
        frame = FLRectCenterRectInRectVertically(bounds, frame);
    }

    panel.view.frame = FLRectOptimizedForViewSize(frame);
}

- (void) observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if(FLStringsAreEqual(keyPath, @"canOpenNextPanel")) {
        [self.delegate panelManager:self panelStateDidChange:object];
    }
    else if(FLStringsAreEqual(keyPath, @"frame")) {
        [self setPanelFrame:self.visiblePanel];
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (void) addPanel:(FLPanelViewController*) panel {
    [panel addObserver:self forKeyPath:@"canOpenNextPanel" options:NSKeyValueObservingOptionNew context:nil];
    panel.view.wantsLayer = YES;
    [panel didMoveToPanelManager:self];
    [_panels addObject:panel];
    [self.delegate panelManager:self didAddPanel:panel];
    [self.delegate panelManager:self panelStateDidChange:panel];
}

- (void) removePanelForTitle:(id) title {
    FLPanelViewController* panel = [self panelForTitle:title];
    [_panels removeObject:panel];
    [panel removeObserver:self forKeyPath:@"canOpenNextPanel" context:nil];
    [panel didMoveToPanelManager:nil];
    [self.delegate panelManager:self didRemovePanel:panel];
    [self.delegate panelManager:self panelStateDidChange:panel];
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
    
    if([self.visiblePanel.title isEqual:title]) {
        return YES;
    }

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
    
    for(NSUInteger i = 0; i < idx; i++) {
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
        [toHide panelDidDisappear];
        [self.delegate panelManager:self panelStateDidChange:toHide];
    }


    [toShow panelDidAppear];

    [self.view.window makeFirstResponder:toShow];
    [toShow setNextResponder:self];
    [self.view.window display];

    [self.delegate panelManager:self didShowPanel:toShow didHidePanel:toHide ];
    [self.delegate panelManager:self panelStateDidChange:toShow];
}                                          

- (void) showPanelAtIndex:(NSUInteger) idx 
                 animated:(BOOL) animated
               completion:(FLPanelViewControllerBlock) completion {
    
    FLPanelViewController* toShow = [_panels objectAtIndex:idx];
    FLAssertNotNil_(toShow);
    
    FLPanelViewController* toHide = [self visiblePanel];
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

    CGFloat animationDuration = 0.0f;
    FLTransition* transition = nil;
    if(animated) {
        Class transitionClass = (idx < _currentPanel) ? _showTransition : _hideTransition;
        if(transitionClass) {
            transition = [transitionClass transitionWithViewToShow:[toShow view] viewToHide:[toHide view]];
            
            if(transition) {
                animationDuration = [transition duration];
            }
        }
    }

    [self removePanelViews:animated];

    [self setPanelFrame:toShow];

    [self.delegate panelManager:self willShowPanel:toShow willHidePanel:toHide animationDuration:animationDuration];
    
    [self.view.window makeFirstResponder:self];
    if(toHide) {
        [toHide panelWillDisappear];
    }
    [toShow panelWillAppear];
    
    _currentPanel = idx;
    [self.view addSubview:[toShow view]];
        
    if(transition) {
        completion = FLCopyWithAutorelease(completion);
        [transition startAnimating:^{
            [self didShowPanel:toShow didHidePanel:toHide];
                
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
          
- (void) addPanelView:(NSView*) panelView toView:(NSView*) superview animated:(BOOL) animated {
    if(!_panelViews) {
        _panelViews = [[NSMutableArray alloc] init];
    }
    [_panelViews addObject:panelView];
    [superview addSubview:panelView];
}

- (void) removePanelViews:(BOOL) animated {
    for(NSView* view in _panelViews) {
        [view removeFromSuperview];
    }

    [_panelViews removeAllObjects];
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
//    FLAssertNotNil_(toShow);
//
//    [self setFirstResponder];
//    [self setPanelFrame:toShow];
//    [self.delegate panelManager:self willHidePanel:toHide willShowPanel:toShow];
//            
//    completion = FLCopyWithAutorelease(completion);
//    [self.view addSubview:[toShow view]];
//        
//    dispatch_block_t finished = ^{
//        [self.delegate panelManager:self didHidePanel:toHide didShowPanel:toShow];
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
////        FLSlideOutAndComeForwardTransition* transition = 
////            [FLSlideOutAndComeForwardTransition transitionWithViewToShow:[toShow view] 
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