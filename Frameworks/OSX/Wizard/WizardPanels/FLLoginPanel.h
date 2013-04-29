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

#if OSX

@interface FLLoginPanelCredentials : NSObject<NSCopying> {
@private
    NSString* _userName;
    NSString* _password;
    BOOL _rememberPassword;
}
+ (id) loginPanelUser;

@property (readwrite, assign, nonatomic) BOOL rememberPassword;
@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;

@end

@protocol FLLoginPanelDelegate;

@interface FLLoginPanel : FLPanelViewController<NSControlTextEditingDelegate, FLProgressPanelDelegate>  {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    IBOutlet NSButton* _loginButton;
    FLLoginPanelCredentials* _user;
    __unsafe_unretained id _credentialDataSource;
}
+ (id) loginPanel;
@property (readwrite, assign, nonatomic) id credentialDataSource;
@end

@protocol FLLoginPanelDataSource <NSObject>
- (FLLoginPanelCredentials*) loginPanelGetCredentials:(FLLoginPanel*) panel;

- (void) loginPanel:(FLLoginPanel*) loginPanel 
didChangeCredentials:(FLLoginPanelCredentials*) user;

- (void) loginPanel:(FLLoginPanel*) panel 
beginAuthenticatingWithCredentials:(FLLoginPanelCredentials*) credentials
         completion:(fl_result_block_t) completion;

- (void) loginPanelDidCancelAuthentication:(FLLoginPanel*) panel;

- (void) loginPanel:(FLLoginPanel*) loginPanel 
   saveCredentials:(FLLoginPanelCredentials*) credentials;
   
@end

@protocol FLLoginPanelDelegate <NSObject>
- (void) loginPanelForgotPasswordButtonWasClicked:(FLLoginPanel*) panel;
- (void) loginPanel:(FLLoginPanel*) panel authenticationFailed:(NSError*) error;
- (void) loginPanelDidAuthenticate:(FLLoginPanel*) panel;
@end


#endif