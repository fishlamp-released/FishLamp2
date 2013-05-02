//
//	FLUserService.m
//	FishLamp
//
//	Created by Mike Fullerton on 12/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "FLUserService.h"
#import "FLLowMemoryHandler.h"
#import "FLApplicationDataVersion.h"
#import "NSFileManager+FLExtras.h"
#import "NSString+Guid.h"
#import "FLService.h"
#import "FLKeychain.h"
#import "FLAppInfo.h"

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"save-password";

@interface FLUserService ()
@end

@implementation FLUserService
@synthesize userName = _userName;
@synthesize password = _password;
@synthesize rememberPassword = _rememberPassword;

- (id) init {
    self = [super initWithRootNameForDelegateMethods:@"userService"];
    if(self) {
    }
    return self;
}

+ (id) userService {
    return FLAutorelease([[[self class] alloc] init]);
}

#if FL_MRC
- (void) dealloc {
    [_userName release];
    [_password release];
    [super dealloc];
}
#endif

- (void) savePassword {
    if(FLStringIsNotEmpty(self.userName)) {
        if(_rememberPassword && FLStringIsNotEmpty(self.password)) {
            
            NSString* existingPassword = [FLKeychain httpPasswordForUserName:self.userName withDomain:[FLAppInfo bundleIdentifier]];
            
            if(FLStringsAreNotEqual(existingPassword, self.password)) {
                [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:[FLAppInfo bundleIdentifier]];
            }
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:[FLAppInfo bundleIdentifier]];
        }
    }
}

- (void) loadPassword {
    if(FLStringIsEmpty(self.password) && FLStringIsNotEmpty(self.userName)) {
        if(_rememberPassword) {
            self.password = [FLKeychain httpPasswordForUserName:self.userName withDomain:[FLAppInfo bundleIdentifier]];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:[FLAppInfo bundleIdentifier]];
            self.password = @"";
        }
    }
}

- (void) loadCredentials {

    if(!_loaded) {
        self.rememberPassword = NO;
        self.userName = @"";
        self.password = @"";
        
        FLAssertStringIsNotEmptyWithComment([FLAppInfo bundleIdentifier], @"bundle identifier must be set to use keychain for password");
        
        self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:FLUserDefaultPathForKey(FLDefaultsKeyWizardLastUserNameKey)];
        
        NSNumber* rememberPW = [[NSUserDefaults standardUserDefaults] objectForKey:FLUserDefaultPathForKey(FLDefaultsKeyWizardSavePasswordKey)];
        _rememberPassword = rememberPW && [rememberPW boolValue];

        [self loadPassword];
        
        _loaded = YES;
    }
}

- (void) saveCredentials {
    if(FLStringIsEmpty(self.userName)) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLUserDefaultPathForKey(FLDefaultsKeyWizardLastUserNameKey)];
    }
    else {
        [[NSUserDefaults standardUserDefaults] setObject:self.userName 
                                                  forKey:FLUserDefaultPathForKey(FLDefaultsKeyWizardLastUserNameKey)];
    }

    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_rememberPassword] 
                                              forKey:FLUserDefaultPathForKey(FLDefaultsKeyWizardSavePasswordKey)];

    [[NSUserDefaults standardUserDefaults] synchronize];

    [self savePassword];
    
    _loaded = YES;
}

- (BOOL) canAuthenticate {
    return FLStringIsNotEmpty(self.userName) && FLStringIsNotEmpty(self.password);
}

- (void) clearCredentials {
    self.userName = nil;
    self.password = nil;
}

- (void) closeService {
    [self clearCredentials];
}

@end



