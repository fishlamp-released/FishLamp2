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

#if FL_MRC
- (void) dealloc {
    [_panels release];
    [super dealloc];
}
#endif

- (void) awakeFromNib {
    [super awakeFromNib];
    _panels = [[NSMutableArray alloc] init];
    _currentPanel = INT_MAX;
    [self.view setWantsLayer:YES];
    [self.view addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (NSUInteger) panelCount {
    return _panels.count;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    [self setPanelFrame:self.visiblePanel];
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
//        frame = FLRectPositionRectInRectVerticallyBottomThird(bounds, frame);
        frame = FLRectCenterRectInRectVertically(bounds, frame);
    }

    panel.view.frame = FLRectOptimizedForViewSize(frame);
}

- (void) addPanel:(FLPanelViewController*) panel {
    panel.view.wantsLayer = YES;
    [_panels addObject:panel];
}

- (void) removePanel:(FLPanelViewController*) panel {
    [_panels removeObject:panel];
}

- (FLPanelViewController*) visiblePanel {
    return (_started && _panels.count > _currentPanel) ? [_panels objectAtIndex:_currentPanel] : nil;
}

- (BOOL) canShowPanelForPanelKey:(id) key {
    
    if(_started) {
        for(FLPanelViewController* panel in _panels) {
            if(panel.canOpenNextPanel == NO) {
                return NO;
            }
            if([key isEqual:[panel key]]) {
                return panel.canOpenNextPanel;
            }
        }
    }
    return NO;
}

- (BOOL) canOpenPanelForKey:(id) key {
    if(!_started) {
        return NO;
    }
    
    if([self.visiblePanel.key isEqual:key]) {
        return YES;
    }

    NSUInteger idx = NSNotFound;
    for(NSUInteger i = 0; i < _panels.count; i++) {
        if([key isEqual:[[_panels objectAtIndex:i] key]]) {
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

- (FLPanelViewController*) panelForKey:(id) key {
    for(FLPanelViewController* panel in _panels) {
        if([key isEqual:[panel key]]) {
            return panel;
        }
    }
    
    return nil;
}

- (NSInteger) panelIndexForKey:(id) key {
    for(NSInteger i = 0; i < _panels.count; i++) {
        if([key isEqual:[[_panels objectAtIndex:i] key]]) {
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

- (void) finishAnimation:(FLPanelViewController*) toShow
                  toHide:(FLPanelViewController*) toHide
              completion:(FLPanelViewControllerBlock) completion {

    [toHide.view removeFromSuperview];
    [self.view.window makeFirstResponder:toShow];
    [toShow setNextResponder:self];
    [self.view.window display];
        
    [self.delegate panelManager:self didHidePanel:toHide didShowPanel:toShow];
    if(completion) {
        completion(toShow);
    }
}                     

- (void) showPanelAtIndex:(NSUInteger) idx 
                       animated:(BOOL) animated
                     completion:(FLPanelViewControllerBlock) completion {
    _started = YES;

    Class transitionClass = nil;
    if(animated) {
        transitionClass = (idx < _currentPanel) ? 
            [self.delegate panelManagerGetForwardTransitionClass:self] :
            [self.delegate panelManagerGetBackwardTransitionClass:self];
    }

    FLPanelViewController* toShow = [_panels objectAtIndex:idx];
    FLAssertNotNil_(toShow);
    
    FLPanelViewController* toHide = [self visiblePanel];
    if(toHide) {
        [self.view.window makeFirstResponder:self];
    }

    [self setPanelFrame:toShow];
    [self.delegate panelManager:self willHidePanel:toHide willShowPanel:toShow];
    
    _currentPanel = idx;
    [self.view addSubview:[toShow view]];
    
    FLTransition* transition = nil;
    if(transitionClass) {
        transition = [transitionClass transitionWithViewToShow:[toShow view] viewToHide:[toHide view]];
    }
    
    if(transition) {
        completion = FLCopyWithAutorelease(completion);
        [transition startAnimating:^{
            [self finishAnimation:toShow toHide:toHide completion:completion];
        }];
    }
    else {
        [self finishAnimation:toShow toHide:toHide completion:completion];
    }
}      

- (void) showFirstPanel {
    [self showPanelAtIndex:0 animated:NO completion:nil];
}

- (void) showPanelForKey:(id) key 
                animated:(BOOL) animated
              completion:(FLPanelViewControllerBlock) completion {

    [self showPanelAtIndex:[self panelIndexForKey:key] 
                  animated:YES 
                completion:completion];
}    

- (BOOL) isShowingFirstPanel {
    return _started && self.currentPanelIndex == 0;
}

- (BOOL) isShowingLastPanel {
    return _started && self.currentPanelIndex == (_panels.count - 1);
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