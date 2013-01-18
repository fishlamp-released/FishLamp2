//
//  FLLoginWizardPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLoginWizardPanel.h"
#import "NSObject+Blocks.h"
#import "UIViewController+FLAdditions.h"
#import "FLKeychain.h"

@interface FLLoginWizardPanel ()
- (IBAction)resetLogin:(id)sender;
- (IBAction) passwordCheckboxToggled:(id) sender;

- (void) applicationWillTerminate:(id)sender;
@end

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"com.fishlamp.wizard.username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"com.fishlamp.wizard.savepassword";

@implementation FLLoginWizardPanel

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;
@synthesize delegate = _delegate;

- (id) init {
    return [self initWithNibName:@"FLLoginWizardPanel" bundle:nil];
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

+ (id) loginWizardPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

+ (id) loginWizardPanel:(id<FLLoginWizardPanelDelegate>) delegate {
    FLLoginWizardPanel* panel = [self loginWizardPanel];
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
        [self updateButtonSelectedState:[self wizard]];
    }
}

#endif

- (void) updateButtonSelectedState:(FLWizardViewController*) wizard {
    wizard.nextButton.enabled = [self canLogin];
}

- (IBAction)resetLogin:(id)sender {
    FLPerformSelector1(self.delegate, @selector(loginWizardPanelResetPassword:), self);
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
                NSString* pw = [FLKeychain httpPasswordForUserName:userName withDomain:[self.delegate loginWizardPanelPasswordDomain:self]];
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
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.savePasswordInKeychain] forKey:FLDefaultsKeyWizardSavePasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if(self.savePasswordInKeychain) {
        [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:[self.delegate loginWizardPanelPasswordDomain:self]];
    }
    else {
        [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:[self.delegate loginWizardPanelPasswordDomain:self]];
    }
}

- (IBAction) passwordCheckboxToggled:(id) sender {
    [self saveCredentials];
}

- (void) applicationWillTerminate:(id)sender {
    [self saveCredentials];
}
   
- (BOOL) willRespondToNextButtonInWizard:(FLWizardViewController*) wizard {

    if([self.delegate loginWizardPanelIsAuthenticated:self]) {
        return NO;
    }
    else {
        
//        NSTextField* textField = FLAutorelease([[NSTextField alloc] initWithFrame:CGRectZero]);
//        textField.font = [NSFont fontWithName:@"MyriadPro-Bold" size:12];
//        textField.stringValue = @"Logging in…";
//        textField.textColor = [NSColor grayColor];
//        textField.drawsBackground = NO;
//        textField.bordered = NO;
//        [textField setBezeled:NO];
//        [textField setEditable:NO];
//        [textField setAlignment:NSLeftTextAlignment];

        wizard.nextButton.enabled = NO;
        
//        [self.wizard.statusBar setStatusView:textField animated:YES completion:^{
//            self.wizard.otherButton.enabled = YES;

//        [self.wizard setNotificationView:textField animated:YES completion:^{
//            self.wizard.otherButton.enabled = YES;
//            self.wizard.nextButton.enabled = NO;
//
            FLPerformSelector1( self.delegate, 
                                @selector(loginWizardPanelStartAuthenticating:), 
                                self);
//        }];
    
    
//        FLProgressWizardPanel* progress = [FLProgressWizardPanel progressWizardPanel];
//        progress.delegate = self;
//        progress.nextPanelBlock = self.nextPanelBlock;
//        
//        FLProgressWizardPanelProgressView* progressView = progress.progressView1;
//        progressView.progressText = @"Logging in...";
//        [progress setInitialView:progressView];
//        
//        [self.wizard pushWizardPanel:progress animated:YES completion:^(FLWizardPanel* panel) {
//            }];

        return YES;
    }
}


- (void) wizardPanelDidAppearInWizard:(FLWizardViewController*) wizard {

    [self updateButtonSelectedState:wizard];

    [self performBlockOnMainThread:^{
        if(FLStringIsEmpty(self.userName)) {
            [self.userNameTextField becomeFirstResponder];
        }
        else {
            [self.passwordEntryField becomeFirstResponder];
        }
    }];
}

- (void) wizardPanelWillAppearInWizard:(FLWizardViewController*) wizard {
    [self updateVisibleCredentials];

    FLPerformSelector1(self.delegate, @selector(loginWizardPanelWillAppear:), self);
    
    wizard.backButton.enabled = NO;
}

- (void) wizardPanelWillDisappearInWizard:(FLWizardViewController*) wizard {
    [self saveCredentials];
    [wizard becomeFirstResponder];
    [self.userNameTextField resignFirstResponder];
    [self.passwordEntryField resignFirstResponder];
}

- (void) wizardPanelDidDisappearInWizard:(FLWizardViewController*) wizard {
    FLPerformSelector1(self.delegate, @selector(loginWizardPanelDidDisappear:), self);
}

@end
