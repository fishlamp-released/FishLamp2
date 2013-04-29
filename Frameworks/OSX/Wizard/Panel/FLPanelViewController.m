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
@property (readwrite, assign, nonatomic, getter=isVisiblePanel) BOOL visiblePanel;
@end

@implementation FLPanelViewController

@synthesize panelManager = _panelManager;
@synthesize prompt = _prompt;
@synthesize canOpenNextPanel = _canOpenNextPanel;
@synthesize buttons = _buttons;
@synthesize header = _header;
@synthesize panelFillsView = _panelFillsView;
@synthesize authenticated = _authenticated;
@synthesize delegate = _delegate;
@synthesize independent = _independent;
@synthesize hidden = _hidden;
@synthesize enabled = _enabled;
@synthesize identifier = _identifier;
@synthesize alertViewController = _alertViewController;
@synthesize visiblePanel = _visiblePanel;


#if FL_MRC
- (void) dealloc {
    [_alertViewController release];
    [_identifier release];
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
    self.independent = NO;
    self.enabled = YES;
    self.hidden = NO;
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


//- (void) showAlertWithError:(NSError*) error {
//    [self showAlertWithError:error withTitle:nil withCaption:nil];
//}
//
//- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title {
//    [self showAlertWithError:error withTitle:title withCaption:nil];
//}
//
//- (void) showAlertWithError:(NSError*) error withTitle:(NSString*) title withCaption:(NSString*) caption {
//    [self showErrorAlert:title caption:caption error:error];
//}
//
//
//- (void) showErrorAlert:(NSString*) title caption:(NSString*) caption error:(NSError*) error {
//    [self showErrorAlert:title caption:caption error:error];
//}
//
//- (void) didHideAlertWithError:(NSError*) error {
//}

- (void) setCanOpenNextPanel:(BOOL)canOpenNextPanel {
    if(canOpenNextPanel != _canOpenNextPanel) {
        _canOpenNextPanel = canOpenNextPanel;
        [_panelManager panelDidChangeCanOpenValue:self];
    }
}

+ (id) defaultPanelIdentifier {
    return NSStringFromClass([self class]);
}

@end
#endif