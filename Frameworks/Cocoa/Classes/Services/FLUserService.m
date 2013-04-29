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

NSString* const FLDefaultsKeyWizardLastUserNameKey = @"com.fishlamp.username";
NSString* const FLDefaultsKeyWizardSavePasswordKey = @"com.fishlamp.savepassword";

@interface FLUserService ()
@end

@implementation FLUserService
@synthesize userName = _userName;
@synthesize password = _password;

@synthesize authenticationDomain = _authenticationDomain;
@synthesize rememberPassword = _rememberPassword;

+ (id) userServiceWithAuthenticationDomain:(NSString*) authenticationDomain {
    FLUserService* service = FLAutorelease([[[self class] alloc] init]);
    service.authenticationDomain = authenticationDomain;
    return service;
}

- (id) init {
    self = [super initWithRootNameForDelegateMethods:@"userService"];
    if(self) {
        self.authenticationDomain = [FLAppInfo bundleIdentifier];
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

//- (void) setUserName:(NSString*) userName {
//    if(FLStringsAreNotEqual(userName, _userName)) {
//        FLSetObjectWithRetain(_userName, userName);
//        self.password = @"";
//    }
//}
//
//- (void) setRememberPassword:(BOOL)rememberPassword {
//    if(_rememberPassword != rememberPassword) {
//        _rememberPassword = rememberPassword;
//        _passwordChanged = YES;
//    }
//}
//
//- (void) setPassword:(NSString *)password {
//    if(FLStringsAreNotEqual(_password, password)) {
//        FLSetObjectWithRetain(_password, password);
//        _passwordChanged = YES;
//    }
//}

- (void) savePassword {
    if(FLStringIsNotEmpty(self.userName)) {
        if(_rememberPassword && FLStringIsNotEmpty(self.password)) {
            
            NSString* existingPassword = [FLKeychain httpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
            if(FLStringsAreNotEqual(existingPassword, self.password)) {
                [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:self.authenticationDomain];
            }
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
        }
    }
}

- (void) loadPassword {
    if(FLStringIsEmpty(self.password) && FLStringIsNotEmpty(self.userName)) {
        if(_rememberPassword) {
            self.password = [FLKeychain httpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
            self.password = @"";
        }
    }
}

- (void) loadCredentials {
    if(!_loaded) {
        self.rememberPassword = NO;
        self.userName = @"";
        self.password = @"";
        
        FLAssertStringIsNotEmptyWithComment(self.authenticationDomain, @"domain for password in keychain not set");
        
        self.userName = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardLastUserNameKey];
        
        NSNumber* rememberPW = [[NSUserDefaults standardUserDefaults] objectForKey:FLDefaultsKeyWizardSavePasswordKey];
        _rememberPassword = rememberPW && [rememberPW boolValue];

        [self loadPassword];
        
        _loaded = YES;
    }
}

- (void) saveCredentials {
    [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:_rememberPassword] forKey:FLDefaultsKeyWizardSavePasswordKey];
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



