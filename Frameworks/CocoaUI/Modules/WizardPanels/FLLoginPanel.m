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
@end

@implementation FLLoginPanel

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;
@synthesize userLogin = _userLogin;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", nil);
        self.prompt =  NSLocalizedString(@"Login to your account", nil);
    
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillTerminate:)
                                                     name: NSApplicationWillTerminateNotification
                                                   object: [NSApplication sharedApplication]];
    
        self.panelFillsView = NO;
    }
    
    return self;
}

+ (id) loginPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if FL_MRC
    [_userLogin release];
    [_userNameTextField release];
    [_passwordEntryField release];
    [_savePasswordCheckBox release];
    [_forgotPasswordButton release];
    [super dealloc];
#endif
}

- (void) setUserName:(NSString*) userName {
    [self.userNameTextField setStringValue:FLEmptyStringOrString(userName)];
}

- (NSString *)userName {
	return [self.userNameTextField stringValue];
}

- (void) setPassword:(NSString*) password {
    [self.passwordEntryField setStringValue:FLEmptyStringOrString(password)];
}

- (NSString *)password {
	return [self.passwordEntryField stringValue];
}

- (BOOL) savePasswordInKeychain {
    return [_savePasswordCheckBox integerValue] == 1;
}

- (void) setSavePasswordInKeychain:(BOOL) saveIt {
    [_savePasswordCheckBox setIntegerValue:saveIt];
}

- (BOOL) canLogin {
	return	FLStringIsNotEmpty(self.userName) && FLStringIsNotEmpty(self.password);
}

- (void) updateNextButton {
    self.canOpenNextPanel = self.canLogin;
}

#if OSX
- (void)controlTextDidEndEditing:(NSNotification *)note {
	if ( [note object] == self.userNameTextField || [note object] == self.passwordEntryField ) {
		if ( ![self canLogin] ) {
			return;
		}
		
		NSNumber *reason = [[note userInfo] objectForKey:@"NSTextMovement"];
		if ([reason intValue] == NSReturnTextMovement) {
			//	leave time for text field to clean up repainting
			[[self.buttons nextButton] performSelector:@selector(performClick:) withObject:nil afterDelay:0.1];
		}
	}
}


- (void)controlTextDidChange:(NSNotification *)note {
	if ( [note object] == self.userNameTextField || [note object] == self.passwordEntryField ) {
        if([self isAuthenticated]) {
            [self logoutUser];
        }
        [self updateNextButton];
    }
}

#endif


- (IBAction) resetLogin:(id) sender {
}

- (BOOL) isAuthenticated {
    return NO;
}

- (void) startAuthenticating {
}

- (void) requestCancel {
}

- (void) resetPassword {
}

- (void) logoutUser {
}

- (void) updateVisibleCredentials {
    if(!self.userLogin) {
        [self.userLogin loadFromStorage];
    }
    [self setSavePasswordInKeychain:self.userLogin.rememberPassword];
    [self setUserName:self.userLogin.userName];
    [self setPassword:self.userLogin.password];
}

- (void) saveCredentials {  

    self.userLogin.userName = self.userName;
    self.userLogin.password = self.password;
    self.userLogin.rememberPassword = self.savePasswordInKeychain;

    [self.userLogin saveToStorage];
}

- (IBAction) passwordCheckboxToggled:(id) sender {
    [self saveCredentials];
}

- (void) applicationWillTerminate:(id)sender {
    [self saveCredentials];
}
   
- (void) respondToNextButton:(BOOL*) handledIt {
    [self saveCredentials];
//    if(self.isAuthenticated) {
//        *handledIt = NO;
//    }
//    else {
//        self.buttons.nextButton.enabled = NO;
//        [self startAuthenticating];
//        *handledIt = YES;
//    }
}

- (void) panelDidAppear {
    [super panelDidAppear];
    [self updateNextButton];

    [self performBlockOnMainThread:^{
        if(FLStringIsEmpty(self.userName)) {
            [self.userNameTextField becomeFirstResponder];
        }
        else {
            [self.passwordEntryField becomeFirstResponder];
        }
    }];
}

//- (BOOL) becomeFirstResponder {
//    [self updateNextButton];
//    return YES;
//}

- (void) panelWillAppear {
    [super panelWillAppear];
    
    [self updateVisibleCredentials];
    [self updateNextButton];
    
    if(!self.savePasswordInKeychain && [self isAuthenticated]) {
        [self logoutUser];
    }
}

- (void) panelWillDisappear {
    [super panelWillDisappear];
    [self saveCredentials];
    [self.userNameTextField resignFirstResponder];
    [self.passwordEntryField resignFirstResponder];
    
    if(!self.savePasswordInKeychain) {
        self.passwordEntryField.stringValue = @"";
    }
}

@end

#endif