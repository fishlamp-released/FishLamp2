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
#import "FLUserService.h"

#if OSX

@protocol FLLoginPanelDelegate;

@interface FLLoginPanel : FLPanelViewController<NSControlTextEditingDelegate>  {
@private
    IBOutlet NSTextField* _userNameTextField;
    IBOutlet NSSecureTextField* _passwordEntryField;
    IBOutlet NSButton* _savePasswordCheckBox;
    IBOutlet NSButton* _forgotPasswordButton;
    FLUserService* _userService;
}
+ (id) loginPanel;
@end

@protocol FLLoginPanelDelegate <NSObject>
- (FLUserService*) loginPanelGetUserService:(FLLoginPanel*) panel;
- (void) loginPanelForgotPasswordButtonWasClicked:(FLLoginPanel*) panel;
@end


#endif