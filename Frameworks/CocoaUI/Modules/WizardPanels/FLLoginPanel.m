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
#import "UIViewController+FLAdditions.h"
#import "FLKeychain.h"

@interface FLLoginPanel ()
- (void) applicationWillTerminate:(id)sender;
@end

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"com.fishlamp.wizard.username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"com.fishlamp.wizard.savepassword";

@implementation FLLoginPanel {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    NSString* _passwordKeychainKey;
}

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;
@synthesize passwordKeychainKey = _passwordKeychainKey;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Login", nil);
        self.prompt =  NSLocalizedString(@"Login to your account", nil);
    
    [[NSNotificationCenter defaultCenter] 
    addObserver: self
       selector: @selector(applicationWillTerminate:)
           name: NSApplicationWillTerminateNotification
         object: [NSApplication sharedApplication]];
    }
    
    return self;
}

+ (id) loginPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
#if FL_MRC
    [_userNameTextField release];
    [_passwordEntryField release];
    [_savePasswordCheckBox release];
    [_forgotPasswordButton release];
    [super dealloc];
#endif
}

- (void) setUserName:(NSString*) userName {
    [self.userNameTextField setStringValue:userName];
}

- (NSString *)userName {
	return [self.userNameTextField stringValue];
}

- (void) setPassword:(NSString*) password {
    [self.passwordEntryField setStringValue:password];
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


- (void) resetLogin {
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
    FLAssertStringIsNotEmpty_v(self.passwordKeychainKey, @"domain for password in keychain not set");
    
    NSString* userName = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardLastUserNameKey];
    if(FLStringIsNotEmpty(userName)) {
        self.userName = userName;
     
        NSNumber* rememberPW = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardSavePasswordKey];

        if(rememberPW) {
            [self setSavePasswordInKeychain:rememberPW.boolValue];
         
            if(rememberPW.boolValue) {
                NSString* pw = [FLKeychain httpPasswordForUserName:userName withDomain:self.passwordKeychainKey];
                if(FLStringIsNotEmpty(pw)) {
                    self.password = pw;
                }
            }
        }
        else {
            [self setSavePasswordInKeychain:NO];
        }
    }
}

- (void) saveCredentials {
    FLAssertStringIsNotEmpty_v(self.passwordKeychainKey, @"domain for password in keychain not set");
    
    if(FLStringIsNotEmpty(self.userName)) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
        if(self.savePasswordInKeychain && !FLStringIsEmpty(self.password)) {
            [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:self.passwordKeychainKey];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.passwordKeychainKey];
        }
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLDefaultsKeyWizardLastUserNameKey];
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.savePasswordInKeychain] forKey:FLDefaultsKeyWizardSavePasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (IBAction) passwordCheckboxToggled:(id) sender {
    [self saveCredentials];
}

- (void) applicationWillTerminate:(id)sender {
    [self saveCredentials];
}
   
- (void) respondToNextButton:(BOOL*) handledIt {

    [self saveCredentials];
    if(self.isAuthenticated) {
        *handledIt = NO;
    }
    else {
        self.buttons.nextButton.enabled = NO;
        [self startAuthenticating];
        *handledIt = YES;
    }
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

- (BOOL) becomeFirstResponder {
    [self updateNextButton];
    return YES;
}

- (void) panelWillAppear {
    [super panelWillAppear];
    
    FLAssertStringIsNotEmpty_v(self.passwordKeychainKey, @"domain for password in keychain not set");
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