//
//  FLStorableUserLogin.m
//  FishLampCocoa
//
//  Created by Mike Fullerton on 3/10/13.
//  Copyright (c) 2013 Mike Fullerton. All rights reserved.
//

#import "FLStorableUserLogin.h"
#import "FLKeychain.h"

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"com.fishlamp.wizard.username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"com.fishlamp.wizard.savepassword";

@interface FLStorableUserLogin ()
@property (readwrite, assign, nonatomic, getter=isLoaded) BOOL loaded;
@end

@implementation FLStorableUserLogin 
@synthesize authenticationDomain = _authenticationDomain;
@synthesize loaded = _loaded;
@synthesize rememberPassword = _rememberPassword;

- (void) loadFromStorage {
    FLAssertStringIsNotEmpty_v(self.authenticationDomain, @"domain for password in keychain not set");
    
    self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardLastUserNameKey];
    if(FLStringIsNotEmpty(self.userName)) {
     
        NSNumber* rememberPW = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardSavePasswordKey];
        self.rememberPassword = rememberPW && [rememberPW boolValue];
        
        if(self.rememberPassword) {
            NSString* pw = [FLKeychain httpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
            if(FLStringIsNotEmpty(pw)) {
                self.password = pw;
            }
        }
    }
    
    self.loaded = YES;
}

- (void) saveToStorage {
    FLAssertStringIsNotEmpty_v(self.authenticationDomain, @"domain for password in keychain not set");
    
    if(FLStringIsNotEmpty(self.userName)) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
        if(self.rememberPassword && !FLStringIsEmpty(self.password)) {
            [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:self.authenticationDomain];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
        }
    }
    else {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLDefaultsKeyWizardLastUserNameKey];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:self.rememberPassword] forKey:FLDefaultsKeyWizardSavePasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end

