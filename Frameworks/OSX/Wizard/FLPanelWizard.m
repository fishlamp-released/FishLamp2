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

- (void) didAddPanel:(FLPanelViewController*) panel {
    [self.navigationViewController addBreadcrumb:panel.title];
}

- (void) panelManager:(FLPanelManager*) controller didRemovePanel:(FLPanelViewController*) panel {
    [self.navigationViewController removeBreadcrumb:panel.title];
}

#pragma mark breadcrumb bar delegate

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsVisible:(id) title {
    return [title isEqual:[self.visiblePanel title]];
}

- (BOOL) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar breadcrumbIsEnabled:(id) title {
    return [self canOpenPanelForTitle:title];
}
                
- (void) breadcrumbBar:(FLBreadcrumbBarViewController*) breadcrumbBar 
    breadcrumbWasClicked:(NSString*) title {
    [self showPanelForTitle:title animated:YES completion:nil];
}

@end
