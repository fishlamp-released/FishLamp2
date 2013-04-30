//
//  FLPanelWizard.m
//  FishLampCocoaUI
//
//  Created by Mike Fullerton on 4/17/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLPanelWizard.h"

@interface FLWizardView : NSView
@end

@implementation FLWizardView 

#if DEBUG
- (void) setFrame:(CGRect) frame {
//    [super setFrame:frame];

    if(frame.size.height > 0 && frame.size.width > 0) {
        [super setFrame:frame];
    }
}
#endif

@end

@implementation FLPanelWizard
@synthesize navigationViewController = _navigationViewController;

- (void) awakeFromNib {
    [super awakeFromNib];
    self.navigationViewController.delegate = self;
}

//- (BOOL)acceptsFirstResponder {
//    return YES;
//}
//
//- (BOOL)becomeFirstResponder {
//    return YES;
//}
//
//- (BOOL)validateMenuItem:(NSMenuItem *)item {
//    return YES;
//}

- (void) panelManagerDidStart {
    [self.navigationViewController updateNavigationTitlesAnimated:NO];
}

- (void) didAddPanel:(FLPanelViewController*) panel {

    FLNavigationTitle* title = 
        [FLNavigationTitle navigationTitle:panel.identifier];
    title.localizedTitle = panel.title;

    [self.navigationViewController addNavigationTitle:title];
}

- (void) didRemovePanel:(FLPanelViewController*) panel {
    [self.navigationViewController removeNavigationTitleForIdentifier:panel.identifier];
}

- (void) panelStateDidChange:(FLPanelViewController *)panel {
    [super panelStateDidChange:panel];
}

#pragma mark breadcrumb bar delegate

- (BOOL) titleNavigationController:(FLBreadcrumbBarViewController*) titleNavigationController navigationTitleIsVisible:(FLNavigationTitle*) title {
    return [title.identifier isEqual:self.visiblePanelIdentifier];
}

- (BOOL) titleNavigationController:(FLBreadcrumbBarViewController*) titleNavigationController navigationTitleIsEnabled:(FLNavigationTitle*) title {
    return [self canOpenPanelForIdentifier:title.identifier];
}
                
- (void) titleNavigationController:(FLBreadcrumbBarViewController*) titleNavigationController 
    navigationTitleWasClicked:(FLNavigationTitle*) title {
    [self showPanelForIdentifier:title.identifier animated:YES completion:nil];
}

- (void) titleNavigationController:(FLBreadcrumbBarViewController*) controller 
             didAddNavigationTitle:(FLNavigationTitle*) title {
             
} 

@end
