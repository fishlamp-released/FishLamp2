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
- (IBAction)resetLogin:(id)sender;
- (IBAction) passwordCheckboxToggled:(id) sender;

- (void) applicationWillTerminate:(id)sender;
@end

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"com.fishlamp.wizard.username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"com.fishlamp.wizard.savepassword";

@implementation FLLoginPanel

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;
@synthesize delegate = _delegate;

- (id) init {
    return [self initWithNibName:@"FLLoginPanel" bundle:nil];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.breadcrumbTitle = NSLocalizedString(@"Login", nil);
        self.title =  NSLocalizedString(@"Login to your account", nil);
    
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

+ (id) loginPanel:(id<FLLoginPanelDelegate>) delegate {
    FLLoginPanel* panel = [self loginPanel];
    panel.delegate = delegate;
    return self;
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
			[[self.wizard nextButton] performSelector:@selector(performClick:) withObject:nil afterDelay:0.1];
		}
	}
}


- (void)controlTextDidChange:(NSNotification *)note {
	if ( [note object] == self.userNameTextField || [note object] == self.passwordEntryField ) {
        [self updateNextButton];
    }
}

#endif


- (IBAction)resetLogin:(id)sender {
    FLPerformSelector1(self.delegate, @selector(loginPanelResetPassword:), self);
}

//- (void) didFinishAuthenticatingWithResult:(FLResult) result {
//
//    self.wizard.otherButton.enabled = NO;
//    
//    if([result error]) {
//    
//        NSTextField* textField = FLAutorelease([[NSTextField alloc] initWithFrame:CGRectZero]);
//        textField.font = [NSFont fontWithName:@"MyriadPro-Bold" size:12];
//        textField.stringValue = @"We didn't recognize your username or password.";
//        textField.textColor = [NSColor redColor];
//        textField.drawsBackground = NO;
//        textField.bordered = NO;
//        [textField setBezeled:NO];
//        [textField setEditable:NO];
//        [textField setAlignment:NSLeftTextAlignment];
//        
////        [self.wizard.statusBar setStatusView:textField animated:YES completion:^{
////            self.wizard.nextButton.enabled = YES;
////        }];
//    }
//    else {
////        [self.wizard.statusBar removeAllStatusViewsAnimated:YES  completion:nil];
//    }
//}

- (void) updateVisibleCredentials {

    NSString* userName = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardLastUserNameKey];
    if(FLStringIsNotEmpty(userName)) {
        self.userName = userName;
     
        NSNumber* rememberPW = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardSavePasswordKey];

        if(rememberPW) {
            [self setSavePasswordInKeychain:rememberPW.boolValue];
         
            if(rememberPW.boolValue) {
                NSString* pw = [FLKeychain httpPasswordForUserName:userName withDomain:[self.delegate loginPanelPasswordDomain:self]];
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
    if(FLStringIsNotEmpty(self.userName)) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
        if(self.savePasswordInKeychain && !FLStringIsEmpty(self.password)) {
            [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:[self.delegate loginPanelPasswordDomain:self]];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:[self.delegate loginPanelPasswordDomain:self]];
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
   
- (BOOL) respondToNextButton:(FLWizardViewController*) wizard {

    if([self.delegate loginPanelIsAuthenticated:self]) {
        return NO;
    }
    else {
        wizard.buttonViewController.nextButton.enabled = NO;
        FLPerformSelector1( self.delegate, 
                                @selector(loginPanelStartAuthenticating:), 
                                self);
        return YES;
    }
}

- (void) panelDidAppearInWizard:(FLWizardViewController*) wizard {

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

- (void) panelWillAppearInWizard:(FLWizardViewController*) wizard {
    [self updateVisibleCredentials];
    FLPerformSelector1(self.delegate, @selector(loginPanelWillAppear:), self);
    
    [self updateNextButton];
}

- (void) panelWillDisappearInWizard:(FLWizardViewController*) wizard {
    [super panelWillDisappearInWizard:wizard];
    [self saveCredentials];
    [wizard becomeFirstResponder];
    [self.userNameTextField resignFirstResponder];
    [self.passwordEntryField resignFirstResponder];
}

- (void) panelDidDisappearInWizard:(FLWizardViewController*) wizard {
    FLPerformSelector1(self.delegate, @selector(loginPanelDidDisappear:), self);
}

@end
#endif