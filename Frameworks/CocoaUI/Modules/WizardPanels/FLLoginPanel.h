//
//  FLLoginPanel.h
//  Zenfolio Downloader
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLPanelViewController.h"
#import "FLWizardViewController.h"
#import "FLStorableUserLogin.h"

#if OSX

@interface FLLoginPanel : FLPanelViewController<NSControlTextEditingDelegate>  {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    FLStorableUserLogin* _userLogin;
}

@property (readonly, strong, nonatomic) NSTextField* userNameTextField;
@property (readonly, strong, nonatomic) NSSecureTextField* passwordEntryField;
@property (readonly, strong, nonatomic) NSButton* savePasswordCheckBox;
@property (readonly, strong, nonatomic) NSButton* forgotPasswordButton;

@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL savePasswordInKeychain; 

@property (readwrite, strong, nonatomic) FLStorableUserLogin* userLogin;

+ (id) loginPanel;

// required overides
- (void) startAuthenticating;
- (void) resetPassword;
- (void) requestCancel;
- (BOOL) isAuthenticated;

- (void) logoutUser;

@end



#endif