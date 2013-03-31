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
    }
    return self;
}

#if FL_MRC
- (void) dealloc {
    [_userName release];
    [_password release];
    [super dealloc];
}
#endif

//- (void) openService {
//    [super openService];
//    [self loadFromUserDefaults];
//}

- (void) closeService {
    self.userName = nil;
    self.password = nil;
    _rememberPassword = NO;
    
//    self.userLogin.isAuthenticated = NO;
//    self.userLogin.authTokenLastUpdateTime = nil;
//    self.userLogin.authToken = nil;

}

+ (SEL) serviceOpenedSelector {
    return @selector(userServiceDidOpen:);
}

+ (SEL) serviceClosedSelector {
    return @selector(userServiceDidClose:);
}


//- (void) setUserName:(NSString*) userName {
//    [_userLogin setUserName:userName];
//}
//
//- (NSString*) userName {
//    return [_userLogin userName];
//}
//
//- (void) setPassword:(NSString*) password {
//    [_userLogin setPassword:password];
//}
//
//- (NSString*) password {
//    return [_userLogin password];
//}

//- (void) saveUserLogin {
////    [[FLApplicationDataModel instance] saveUserLogin:[self.context userLogin]];
//}

//- (BOOL) isAuthenticated {
//	return [self userLogin].isAuthenticatedValue;
//}
//
//- (void) setAuthenticated:(BOOL) authenticated {
//    [self userLogin].isAuthenticatedValue = authenticated;
////    [[FLApplicationDataModel instance] saveUserLogin:[self.context userLogin]];
//}

//+ (FLUserLogin*) loadLastUserLogin;
//+ (FLUserLogin*) loadDefaultUser;
//
//+ (FLUserLogin*) loadLastUserLogin {
//
////     [self.userLogin loadFromStorage];
//
//
//return nil;
////	return [[FLApplicationDataModel instance] loadLastUserLogin];
//}
//
//+ (FLUserLogin*) loadDefaultUser {
////	FLUserLogin* login = [[FLApplicationDataModel instance] loadUserLoginWithGuid:[NSString zeroGuidString]];
////    if(!login) {
////        login = [FLUserLogin userLogin];
////        login.userName = NSLocalizedString(@"Guest", nil);
////        login.isAuthenticatedValue = YES;
////        login.userGuid = [NSString zeroGuidString];
////        [[FLApplicationDataModel instance] saveUserLogin:login];
////        [[FLApplicationDataModel instance] setCurrentUser:login];
////    }
////	return login;
//
//    return nil;
//}

- (void) removeFromUserDefaults {

    if(FLStringIsNotEmpty(self.userName)) {
        [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
    }
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLDefaultsKeyWizardLastUserNameKey];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:FLDefaultsKeyWizardSavePasswordKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void) loadFromUserDefaults {
   
    self.rememberPassword = NO;
    self.userName = nil;
    self.password = nil;
    
    FLAssertStringIsNotEmptyWithComment(self.authenticationDomain, @"domain for password in keychain not set");
    
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
}

- (void) saveToUserDefaults {
    FLAssertStringIsNotEmptyWithComment(self.authenticationDomain, @"domain for password in keychain not set");
    
    if(FLStringIsNotEmpty(self.userName) && self.rememberPassword) {
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:FLDefaultsKeyWizardLastUserNameKey];
        [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithBool:YES] forKey:FLDefaultsKeyWizardSavePasswordKey];
        [[NSUserDefaults standardUserDefaults] synchronize];

        if(FLStringIsNotEmpty(self.password)) {
            [FLKeychain setHttpPassword:self.password forUserName:self.userName withDomain:self.authenticationDomain];
        }
        else {
            [FLKeychain removeHttpPasswordForUserName:self.userName withDomain:self.authenticationDomain];
        }
    }
    else {
        [self removeFromUserDefaults];
    }
    
}

- (void) loadCredentials {
    [self loadFromUserDefaults];
}

- (void) saveCredentials {
    [self saveToUserDefaults];
}

- (BOOL) canAuthenticate {
    
    return FLStringIsNotEmpty(self.userName) && FLStringIsNotEmpty(self.password);


//    return [self.delegate userServiceCanAuthenticate:self];
}


@end



