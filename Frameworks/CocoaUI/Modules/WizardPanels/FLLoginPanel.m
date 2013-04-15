//
//  FLLoginPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//
#if OSX
#import "FLLoginPanel.h"
#import "NSObject+Blocks.h"
#import "FLViewController.h"
#import "FLKeychain.h"

@interface FLLoginPanel ()
- (void) applicationWillTerminate:(id)sender;
@property (readwrite, strong, nonatomic) FLUserService* userService;
- (void) updateNextButton;
- (IBAction) resetLogin:(id) sender;
@end

@implementation FLLoginPanel

@synthesize userService = _userService;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:nil];
}

- (void) awakeFromNib {
    [super awakeFromNib];

    self.title = NSLocalizedString(@"Login", nil);
    self.prompt =  NSLocalizedString(@"Login to your account", nil);

    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(applicationWillTerminate:)
                                                 name: NSApplicationWillTerminateNotification
                                               object: [NSApplication sharedApplication]];

    self.panelFillsView = NO;
}

+ (id) loginPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if FL_MRC
    [_userService release];
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
    self.canOpenNextPanel = self.canLogin;
}

#if OSX
- (void)controlTextDidChange:(NSNotification *)note {
    
    if(self.userService.isServiceOpen) {
        [self.userService closeService:self];
    }
    
    [self updateNextButton];
}

#endif

- (IBAction) resetLogin:(id) sender {
    // this is from the "forgot login" button
    
    [self.delegate loginPanelForgotPasswordButtonWasClicked:self];
}

- (void) loadCredentials {
    [self.userService loadCredentials];
    [self setSavePasswordInKeychain:self.userService.rememberPassword];
    [self setUserName:self.userService.userName];
    [self setPassword:self.userService.password];
}

- (void) saveCredentials {  
    self.userService.rememberPassword = [self savePasswordInKeychain];
    self.userService.userName = self.userName;
    self.userService.password = self.password;
    [self.userService saveCredentials];
}

- (IBAction) passwordCheckboxToggled:(id) sender {
}

- (void) applicationWillTerminate:(id)sender {
    [self saveCredentials];
}
   
- (void) respondToNextButton:(BOOL*) handledIt {
    if(self.canLogin) {
        [self saveCredentials];
    }
    else {
        *handledIt = YES; 
    }
}

- (void) panelDidAppear {
    [super panelDidAppear];
    [self updateNextButton];

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

//- (BOOL) becomeFirstResponder {
//    [self updateNextButton];
//    return YES;
//}

- (void) panelWillAppear {
    [super panelWillAppear];
    _userNameTextField.stringValue = @"";
    _passwordEntryField.stringValue = @"";

    self.userService = [self.delegate loginPanelGetUserService:self];
    [self loadCredentials];
    [self updateNextButton];
}

- (void) panelWillDisappear {
    [self.view.window makeFirstResponder:self.view.window];
    [super panelWillDisappear];
    [self saveCredentials];
    self.userService = nil;
}

- (void) panelDidDisappear {
    [super panelDidDisappear];
    
    _userNameTextField.stringValue = @"";
    _passwordEntryField.stringValue = @"";
}

@end

#endif