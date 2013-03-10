//
//  FLPanelViewController.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 12/7/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLPanelViewController.h"
#import "FLWizardViewController.h"

@interface FLPanelViewController ()

@end

@implementation FLPanelViewController

@synthesize wizardViewController = _wizardViewController;
@synthesize prompt = _prompt;
@synthesize canOpenNextPanel = _canOpenNextPanel;
@synthesize buttons = _buttons;
@synthesize header = _header;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.canOpenNextPanel = NO;
    }
    
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_header release];
    [_buttons release];
    [_prompt release];
    [super dealloc];
}
#endif

- (void) loadView {
    [super loadView];
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    NSLog(@"panel becomeFirstResponder: %@", [self title]);
    return YES;
}

- (BOOL)resignFirstResponder {
    NSLog(@"panel resignFirstResponder: %@", [self title]);
    return YES;
}


- (void) panelWillAppear {
}

- (void) panelDidAppear {
}

- (void) panelWillDisappear {
}

- (void) panelDidDisappear {
}

- (void) respondToOtherButton:(BOOL*) handledIt {
}

- (void) respondToNextButton:(BOOL*) handledIt {
}

- (void) respondToBackButton:(BOOL*) handledIt {
}

- (void) addPanelView:(FLCompatibleView*) panelView toPanelArea:(id<FLPanelArea>) panelArea animated:(BOOL) animated {
    [_panelManager addPanelView:panelView toView:panelArea.view animated:animated];
}

- (void) didMoveToPanelManager:(FLPanelManager*) manager {
    _panelManager = manager;
    
    if(!_panelManager) {
        self.buttons = nil;
        self.header = nil;
    }
}


@end
#endif