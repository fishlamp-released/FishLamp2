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
#if OSX
@protocol FLLoginPanelDelegate;

@interface FLLoginPanel : FLPanelViewController<NSControlTextEditingDelegate> {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    __unsafe_unretained id<FLLoginPanelDelegate> _delegate;
}

@property (readonly, strong, nonatomic) NSTextField* userNameTextField;
@property (readonly, strong, nonatomic) NSSecureTextField* passwordEntryField;
@property (readonly, strong, nonatomic) NSButton* savePasswordCheckBox;
@property (readonly, strong, nonatomic) NSButton* forgotPasswordButton;

@property (readwrite, strong, nonatomic) NSString* userName;
@property (readwrite, strong, nonatomic) NSString* password;
@property (readwrite, assign, nonatomic) BOOL savePasswordInKeychain; // doesn't actually save it, that's up to the delegate.

@property (readwrite, assign, nonatomic) id<FLLoginPanelDelegate> delegate;

+ (id) loginPanel;
+ (id) loginPanel:(id<FLLoginPanelDelegate>) delegate;

@end

@protocol FLLoginPanelDelegate <NSObject>

- (NSString*) loginPanelPasswordDomain:(FLLoginPanel*) loginPanel;
- (void) loginPanelStartAuthenticating:(FLLoginPanel*) loginPanel;
- (BOOL) loginPanelIsAuthenticated:(FLLoginPanel*) loginPanel;
- (void) loginPanelCancelAuthentication:(FLLoginPanel*) panel;
- (void) loginPanelResetPassword:(FLLoginPanel*) loginPanel;

@optional
- (void) loginPanelWillAppear:(FLLoginPanel*) loginPanel;
- (void) loginPanelDidDisappear:(FLLoginPanel*) loginPanel;

@end


#endif