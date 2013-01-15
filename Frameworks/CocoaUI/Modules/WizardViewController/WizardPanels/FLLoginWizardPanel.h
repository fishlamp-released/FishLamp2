//
//  FLLoginWizardPanel.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLWizardPanel.h"
#import "FLWizardViewController.h"
#import "FLFinisher.h"

@protocol FLLoginWizardPanelDelegate;

@interface FLLoginWizardPanel : FLWizardPanel<NSControlTextEditingDelegate> {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    id<FLLoginWizardPanelDelegate> _delegate;
    __unsafe_unretained FLWizardViewController* _wizard;
}

@property (readonly, strong, nonatomic) NSTextField* userNameTextField;
@property (readonly, strong, nonatomic) NSSecureTextField* passwordEntryField;
@property (readonly, strong, nonatomic) NSButton* savePasswordCheckBox;
@property (readonly, strong, nonatomic) NSButton* forgotPasswordButton;

@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL savePasswordInKeychain; // doesn't actually save it, that's up to the delegate.

@property (readwrite, assign, nonatomic) id<FLLoginWizardPanelDelegate> delegate;

+ (id) loginWizardPanel;

@end

@protocol FLLoginWizardPanelDelegate <NSObject>
- (void) loginWizardPanelStartAuthenticating:(FLLoginWizardPanel*) loginPanel;
- (BOOL) loginWizardPanelIsAuthenticated:(FLLoginWizardPanel*) loginPanel;
- (void) loginWizardPanelCancelAuthentication:(FLLoginWizardPanel*) panel;
- (void) loginWizardPanelResetPassword:(FLLoginWizardPanel*) loginPanel;
@end


