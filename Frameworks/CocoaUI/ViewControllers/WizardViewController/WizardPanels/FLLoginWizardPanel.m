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

@interface FLLoginWizardPanel ()
- (IBAction)resetLogin:(id)sender;
@property (readwrite, strong, nonatomic) FLProgressWizardPanel* progress;
@end

@implementation FLLoginWizardPanel

@synthesize userNameTextField = _userNameTextField;
@synthesize passwordEntryField = _passwordEntryField;
@synthesize savePasswordCheckBox = _savePasswordCheckBox;
@synthesize forgotPasswordButton = _forgotPasswordButton;
@synthesize progress = _progress;

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
    [_progress release];
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
#endif

- (void) updateButtonSelectedState {
    self.wizard.nextButton.enabled = [self canLogin];
}

- (void)controlTextDidChange:(NSNotification *)note {
	if ( [note object] == self.userNameTextField || [note object] == self.passwordEntryField ) {
        [self updateButtonSelectedState];
    }
}

- (IBAction)resetLogin:(id)sender {
    FLPerformSelector1(self.delegate, @selector(loginWizardPanelResetPassword:), self);
}

- (void) startLoginProgress {
    self.progress = [FLProgressWizardPanel progressWizardPanel];
    self.progress.delegate = self;
    
    [self.wizard pushWizardPanel:self.progress animated:YES completion:nil];
}

- (void) removeProgress {
    [self.wizard removeWizardPanel:self.progress];
    self.progress.delegate = nil;
    self.progress = nil;
}

- (void) stopLoginProgress {
    [self.wizard popWizardPanelAnimated:YES completion:^(FLWizardPanel* panel){
        [self removeProgress];
    }];
}

- (void) didFinishAuthenticatingWithResult:(FLResult) result {
    [self stopLoginProgress];
    
    if(![result error]) {
        [self.wizard presentNextWizardPanelAnimated:YES completion:^(FLWizardPanel *newPanel) {
            [self removeProgress];
        }];
    }
}

- (void) didCancelAuthenticationWithResult:(FLResult) result {
    [self stopLoginProgress];
}
    
- (void) beginCancelling {
    if(!FLPerformSelector2(self.delegate, 
                          @selector(loginWizardPanel:cancelAuthenticating:), 
                          self, 
                          [FLFinisher finisher:^(FLResult result) { 
                            [self didCancelAuthenticationWithResult:result]; }])) {
        [self didCancelAuthenticationWithResult:FLSuccessfullResult];
    }
}
    
- (void) respondToNextButton {
    [self startLoginProgress];
    FLPerformSelector2( self.delegate, 
                        @selector(loginWizardPanel:startAuthenticating:), 
                        self, 
                        [FLFinisher finisher:^(FLResult result) { [self didFinishAuthenticatingWithResult:result]; }]);
}

- (void) respondToBackButton:(FLWizardViewController *)wizard {
    [self beginCancelling];
}

- (void) wizardPanelRespondToBackButton:(FLWizardPanel *)wizardPanel {
    [self beginCancelling];
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



@end
