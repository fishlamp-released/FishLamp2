//
//  FLLoginWizardPanel.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "FLCocoa.h"
#import "FLWizardViewController.h"
#import "FLFinisher.h"
#import "FLProgressWizardPanel.h"

@protocol FLLoginWizardPanelDelegate;

@interface FLLoginWizardPanel : FLWizardPanel<NSControlTextEditingDelegate> {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    FLProgressWizardPanel* _progress;
}

@property (readonly, strong, nonatomic) NSTextField* userNameTextField;
@property (readonly, strong, nonatomic) NSSecureTextField* passwordEntryField;
@property (readonly, strong, nonatomic) NSButton* savePasswordCheckBox;
@property (readonly, strong, nonatomic) NSButton* forgotPasswordButton;

@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL savePasswordInKeychain; // doesn't actually save it, that's up to the delegate.

+ (id) loginWizardPanel;

// optional overriddes
- (void) didFinishAuthenticatingWithResult:(FLResult) result;

- (void) didCancelAuthenticationWithResult:(FLResult) result;

@end

@protocol FLLoginWizardPanelDelegate <FLWizardPanelDelegate>
@optional
- (void) loginWizardPanel:(FLLoginWizardPanel*) loginPanel startAuthenticating:(FLFinisher*) finisher;

- (void) loginWizardPanel:(FLLoginWizardPanel*) loginPanel cancelAuthenticating:(FLFinisher*) finisher;

- (void) loginWizardPanelResetPassword:(FLLoginWizardPanel*) loginPanel;
@end


