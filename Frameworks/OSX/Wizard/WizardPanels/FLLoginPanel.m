//
//  FLLoginPanel.m
//  FishLamp
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if OSX
#import "FLLoginPanel.h"
#import "NSObject+Blocks.h"
#import "FLViewController.h"
#import "FLKeychain.h"
#import "FLProgressPanel.h"
#import "NSViewController+FLErrorSheet.h"
#import "NSBundle+FLCurrentBundle.h"



@interface FLLoginPanel ()
- (void) applicationWillTerminate:(id)sender;
- (void) updateNextButton;
- (IBAction) resetLogin:(id) sender;
- (IBAction) startLogin:(id) sender;
- (IBAction) passwordCheckboxToggled:(id) sender;
@property (readwrite, strong, nonatomic) FLCredentialsEditor* credentialsEditor;
@end

@implementation FLLoginPanel

@synthesize credentialsEditor = _credentialsEditor;
@synthesize credentialDataSource = _credentialDataSource;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:[NSBundle currentBundle]];
}

- (void) awakeFromNib {
    [super awakeFromNib];

    self.title = NSLocalizedString(@"Login", nil);
    self.prompt =  NSLocalizedString(@"Login to your account", nil);
    self.panelFillsView = NO;
}

+ (id) loginPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if FL_MRC
    [_credentialsEditor release];
    [super dealloc];
#endif
}

- (void) loadView {
    [super loadView];
    
    [self view];
    _userNameTextField.nextKeyView = _passwordEntryField;
    _passwordEntryField.nextKeyView = _userNameTextField;
}

- (void) setUserName:(NSString*) userName {
    [_userNameTextField setStringValue:FLEmptyStringOrString(userName)];
}

- (NSString *)userName {
	return [_userNameTextField stringValue];
}

- (void) setPassword:(NSString*) password {
    [_passwordEntryField setStringValue:FLEmptyStringOrString(password)];
}

- (NSString *)password {
	return [_passwordEntryField stringValue];
}

- (BOOL) savePasswordInKeychain {
    return [_savePasswordCheckBox integerValue] == 1;
}

- (void) setSavePasswordInKeychain:(BOOL) saveIt {
    [_savePasswordCheckBox setIntegerValue:saveIt];
}

- (BOOL) canLogin {
	return FLStringIsNotEmpty(self.userName) && FLStringIsNotEmpty(self.password);
}

- (void) updateNextButton {
    self.canOpenNextPanel = [self.credentialDataSource loginPanel:self credentialsAreAuthenticated:self.credentialsEditor];
    _loginButton.enabled = self.canLogin;
}

- (void) updateCredentialsEditor {
    _credentialsEditor.userName = self.userName;
    _credentialsEditor.password = self.password;
    _credentialsEditor.rememberPassword = [NSNumber numberWithBool:self.savePasswordInKeychain];
}


#if OSX
- (void)controlTextDidChange:(NSNotification *)note {
    [self updateCredentialsEditor];
    [self updateNextButton];
}

- (void)controlTextDidEndEditing:(NSNotification *) note {

    NSNumber *reason = [[note userInfo] objectForKey:@"NSTextMovement"];
    if ([reason intValue] == NSReturnTextMovement) {
        [self updateNextButton];

        //	leave time for text field to clean up repainting
        if(self.canLogin && !self.canOpenNextPanel) {
            
            double delayInSeconds = 0.1;
            dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
            dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
                [_loginButton performClick:self];
            });
        }
    }
}

#endif

- (void) setNextResponder {
    if(self.view.window) {
        [self performBlockOnMainThread:^{
            if(FLStringIsEmpty(self.userName)) {
                [self.view.window makeFirstResponder:_userNameTextField];
            }
            else {
                [self.view.window makeFirstResponder:_passwordEntryField];
            }
            [self updateNextButton];
        }];
    }
}

- (void) showEntryFields:(BOOL) animated completion:(dispatch_block_t) completion {

    if(self.isSelected) {
        completion = FLCopyWithAutorelease(completion);

        [self.panelManager showAlertView:self 
                      overViewController:self.alertViewController 
                          withTransition:nil 
                          completion:^{
                          
            [self setNextResponder];
            
            if(completion) {
                completion();
            }
        }];
    }
    self.alertViewController = nil;
}

- (void) progressPanelWasCancelled:(FLProgressPanel*) panel {
    [self.credentialDataSource loginPanelDidCancelAuthentication:self];
    [self showEntryFields:YES completion:nil];
}

- (void) beginAuthenticating {

    [self updateCredentialsEditor];
    [self.credentialsEditor stopEditing];

    [self.credentialDataSource  loginPanel:self 
 beginAuthenticatingWithCredentials:self.credentialsEditor 
                         completion:^(id result) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if([result error]) {
                [self showEntryFields:YES completion:^{
                    [self.delegate loginPanel:self authenticationFailed:[result error]];
                }];
            }
            else {
                [self setCanOpenNextPanel:YES];
                [self.delegate loginPanelDidAuthenticate:self];
            }
        });
    }];
}

- (IBAction) startLogin:(id) sender {
    [self updateNextButton];

    if(self.canOpenNextPanel) {
        [self.delegate loginPanelDidAuthenticate:self];
    }
    else {

        FLProgressPanel* panel = [FLProgressPanel progressPanel];
        panel.delegate = self;
        [[panel view] setFrame:self.view.frame];
        [panel setProgressText:NSLocalizedString(@"Logging into your account…", nil)];
        
        self.alertViewController = panel;
        
        [self.panelManager showAlertView:self.alertViewController 
                      overViewController:self withTransition:nil 
                      completion:^{
            [self beginAuthenticating];
        }];
    }
}

- (IBAction) resetLogin:(id) sender {
    // this is from the "forgot login" button
    
    [self.delegate loginPanelForgotPasswordButtonWasClicked:self];
}

- (void) loadCredentials {
    self.credentialsEditor = [self.credentialDataSource  loginPanelGetCredentials:self];
    [self setSavePasswordInKeychain:self.credentialsEditor.rememberPassword];
    [self setUserName:self.credentialsEditor .userName];
    [self setPassword:self.credentialsEditor .password];
}

- (IBAction) passwordCheckboxToggled:(id) sender {
    [self updateCredentialsEditor];
}

- (void) applicationWillTerminate:(id)sender {
    [self updateCredentialsEditor];
    [self.credentialsEditor stopEditing];
}
   
- (void) respondToNextButton:(BOOL*) handledIt {
    if(self.canLogin) {
        [self updateCredentialsEditor];
    }
    else {
        *handledIt = YES; 
    }
}

- (void) panelDidAppear {
    [super panelDidAppear];
    [self updateNextButton];
    [self setNextResponder];

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(applicationWillTerminate:)
                                                 name: NSApplicationWillTerminateNotification
                                               object: [NSApplication sharedApplication]];
    
}

- (void) panelWillAppear {
    [super panelWillAppear];
    _userNameTextField.stringValue = @"";
    _passwordEntryField.stringValue = @"";
    [self loadCredentials];
    [self updateNextButton];
}

- (void) panelWillDisappear {
    [[NSNotificationCenter defaultCenter] removeObserver:self];

    [self.view.window makeFirstResponder:self.view.window];
    [super panelWillDisappear];
    [self updateCredentialsEditor];
    [self.credentialsEditor stopEditing];
    self.credentialsEditor = nil;
}

- (void) panelDidDisappear {
    [super panelDidDisappear];
    
    _userNameTextField.stringValue = @"";
    _passwordEntryField.stringValue = @"";
    
    self.alertViewController = nil;
}

@end

#endif