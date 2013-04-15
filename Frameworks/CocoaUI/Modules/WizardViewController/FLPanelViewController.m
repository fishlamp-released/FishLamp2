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
//@property (readwrite, assign, nonatomic) id wizardViewController;

@end

@implementation FLPanelViewController

@synthesize wizardViewController = _wizardViewController;
@synthesize prompt = _prompt;
@synthesize canOpenNextPanel = _canOpenNextPanel;
@synthesize buttons = _buttons;
@synthesize header = _header;
@synthesize panelFillsView = _panelFillsView;
@synthesize isAuthenticated = _isAuthenticated;
@synthesize delegate = _delegate;

#if FL_MRC
- (void) dealloc {
    [_header release];
    [_buttons release];
    [_prompt release];
    [super dealloc];
}
#endif

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self) {
        [self view]; // force it to load
    }

    return self;
}
- (void) awakeFromNib {
    [super awakeFromNib];
    self.canOpenNextPanel = NO;
    self.panelFillsView = YES;
}

- (BOOL)acceptsFirstResponder {
    return YES;
}

- (BOOL)becomeFirstResponder {
    return YES;
}

- (BOOL)resignFirstResponder {
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

- (void) addPanelView:(SDKView*) panelView toPanelArea:(id<FLPanelArea>) panelArea animated:(BOOL) animated {
    [_panelManager addPanelView:panelView toView:panelArea.contentView animated:animated];
}

- (void) didMoveToPanelManager:(FLPanelManager*) manager {
    _panelManager = manager;
    
    if(!_panelManager) {
        self.buttons = nil;
        self.header = nil;
    }
}

- (void) showAlertWithTitle:(NSString*) title {

}

- (void) showAlertWithTitle:(NSString*) title withCaption:(NSString*) caption {

}

- (void) showAlertWithError:(NSError*) error {
    [self showAlertWithError:error withTitle:nil withCaption:nil];
}

- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title {
    [self showAlertWithError:error withTitle:title withCaption:nil];
}

- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title withCaption:(NSString*) caption {
    [[self wizardViewController] showErrorAlert:title caption:caption error:error];
}


- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error {
    [[self wizardViewController] showErrorAlert:title caption:caption error:error];
}

- (void) didHideAlertWithError:(NSError*) error {
}

- (void) setCanOpenNextPanel:(BOOL)canOpenNextPanel {
    if(canOpenNextPanel != _canOpenNextPanel) {
        _canOpenNextPanel = canOpenNextPanel;
        [_panelManager panelDidChangeCanOpenValue:self];
    }
}

@end
#endif