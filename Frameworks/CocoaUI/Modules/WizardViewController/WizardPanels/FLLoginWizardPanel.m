//
//  FLLoginWizardPanel.m
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FLLoginWizardPanel.h"
#import "FLProgressWizardPanel.h"
#import "NSObject+Blocks.h"
#import "UIViewController+FLAdditions.h"

@interface FLLoginWizardPanel ()
- (IBAction)resetLogin:(id)sender;
@end

@implementation FLLoginWizardPanel

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;

- (id) init {
    return [self initWithDefaultNibName];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Start", nil);
        self.wizardPanelPrompt =  NSLocalizedString(@"Login to your account", nil);
    }
    
    return self;
}

+ (id) loginWizardPanel {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_userNameTextField release];
    [_passwordEntryField release];
    [_savePasswordCheckBox release];
    [_forgotPasswordButton release];
    [super dealloc];
}
#endif

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
			[self.wizard.nextButton performSelector:@selector(performClick:) withObject:nil afterDelay:0.1];
		}
	}
}


- (void)controlTextDidChange:(NSNotification *)note {
	if ( [note object] == self.userNameTextField || [note object] == self.passwordEntryField ) {
        [self updateButtonSelectedState];
    }
}

#endif

- (void) updateButtonSelectedState {
    self.wizard.nextButton.enabled = [self canLogin];
}

- (IBAction)resetLogin:(id)sender {
    FLPerformSelector1(self.delegate, @selector(loginWizardPanelResetPassword:), self);
}


//- (void) didFinishAuthenticatingWithResult:(FLResult) result {
//    
//    if([result error]) {
//    }
//    else {
//        [self.wizard presentNextWizardPanelAnimated:YES completion:^(FLWizardPanel *newPanel) {
//            [self.wizard removeWizardPanel:self.progress];
//            self.progress = nil;
//        }];
//    }
//}
    
- (void) respondToNextButton:(id) sender {

    if([ ((id)self.delegate) loginWizardPanelIsAuthenticated:self]) {
        [super respondToNextButton:sender];
    }
    else {
        FLProgressWizardPanel* progress = [FLProgressWizardPanel progressWizardPanel];
        progress.delegate = self;
        progress.nextPanelBlock = self.nextPanelBlock;
        
        FLProgressWizardPanelProgressView* progressView = progress.progressView1;
        progressView.progressText = @"Logging in...";
        [progress setInitialView:progressView];
        
        [self.wizard pushWizardPanel:progress animated:YES completion:^(FLWizardPanel* panel) {
            FLPerformSelector1( self.delegate, 
                                @selector(loginWizardPanelStartAuthenticating:), 
                                self);
            }];
    }
}

- (void) wizardPanelDidAppear {
    [super wizardPanelDidAppear];
    [self updateButtonSelectedState];

    [self performBlockOnMainThread:^{
        if(FLStringIsEmpty(self.userName)) {
            [self.userNameTextField becomeFirstResponder];
        }
        else {
            [self.passwordEntryField becomeFirstResponder];
        }
    }];
}

- (void) wizardPanelWillAppear {
    [super wizardPanelWillAppear];
    FLPerformSelector1( self.delegate, 
                        @selector(loginWizardPanelCancelAuthentication:), 
                        self);
}

- (void) wizardPanelWillDisappear {
    [super wizardPanelWillDisappear];
    [self.wizard becomeFirstResponder];
    
    [self.userNameTextField resignFirstResponder];
    [self.passwordEntryField resignFirstResponder];
}

- (void) wizardPanelDidDisappear {
    [super wizardPanelDidDisappear];
    if(!self.savePasswordInKeychain) {
        self.password = @"";
    }
}

- (void) wizardPanelDidDisappear:(FLWizardPanel*) wizardPanel {

// don't want it in the wizard stack.
    [self.wizard removeWizardPanel:wizardPanel];
}



@end
