//
//  FLLoginPanel.h
//  FishLamp
//
//  Created by Mike Fullerton on 12/2/12.
//  Copyright (c) 2012 Mike Fullerton. All rights reserved.
//

#import "FishLampCocoa.h"
#import "FLPanelViewController.h"
#import "FLWizardViewController.h"
#import "FLProgressPanel.h"
#import "FLCredentials.h"
#import "FLCredentialsEditor.h"

#if OSX


@protocol FLLoginPanelDelegate;

@interface FLLoginPanel : FLPanelViewController<NSControlTextEditingDelegate, FLProgressPanelDelegate>  {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    IBOutlet NSButton* _loginButton;
    FLCredentialsEditor* _credentialsEditor;
    __unsafe_unretained id _credentialDataSource;
}
+ (id) loginPanel;
@property (readwrite, assign, nonatomic) id credentialDataSource;
@end

@protocol FLLoginPanelDataSource <NSObject>
- (FLCredentialsEditor*) loginPanelGetCredentials:(FLLoginPanel*) panel;

//- (void) loginPanel:(FLLoginPanel*) loginPanel 
//didChangeCredentials:(FLCredentialsEditor*) user;

- (void) loginPanel:(FLLoginPanel*) panel 
beginAuthenticatingWithCredentials:(FLCredentialsEditor*) credentials
         completion:(fl_result_block_t) completion;

- (void) loginPanelDidCancelAuthentication:(FLLoginPanel*) panel;

//- (void) loginPanel:(FLLoginPanel*) loginPanel 
//   saveCredentials:(FLCredentialsEditor*) credentials;

- (BOOL) loginPanel:(FLLoginPanel*) panel 
credentialsAreAuthenticated:(FLCredentialsEditor*) credentials;
   
@end

@protocol FLLoginPanelDelegate <NSObject>
- (void) loginPanelForgotPasswordButtonWasClicked:(FLLoginPanel*) panel;
- (void) loginPanel:(FLLoginPanel*) panel authenticationFailed:(NSError*) error;
- (void) loginPanelDidAuthenticate:(FLLoginPanel*) panel;
@end


#endif