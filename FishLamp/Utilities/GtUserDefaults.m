//
//  GtUserDefaults.m
//  FishLamp
//
//  Created by Mike Fullerton on 10/13/09.
//  Copyright 2009 GreenTongue Software. All rights reserved.
//

#import "GtUserDefaults.h"
#import "GtKeychain.h"
#import "GtFileUtilities.h"
#import "GtStringUtilities.h"

NSString* GtUserLoginErrorDomain = @"GtUserLoginErrorDomain";

@implementation GtUserDefaults


+ (NSString*) userGuidKey:(GtUserLogin*) login
{
    return [NSString stringWithFormat:@"%@.%@", [GtUserLogin userGuidKey], login.userName];
}

+ (BOOL) userExists:(GtUserLogin*) login
{
    return GtStringHasValue([[NSUserDefaults standardUserDefaults] stringForKey:[self userGuidKey:login]]);
}

+ (BOOL) loadUserNameAndGuid:(GtUserLogin*) login
           outError:(NSError**) error
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    if(![login userNameHasValue])
    {
        login.userName = [defaults stringForKey:[GtUserLogin userNameKey]];
        if(!login.userNameHasValue)
        {
            if(error) 
            {
                *error = [GtAlloc(NSError) initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorUserNotFound userInfo:nil];
            }
            return NO;
        }
    }
    
    login.userGuid = [defaults stringForKey:[self userGuidKey:login]];
    if(!login.userGuidHasValue)
    {
        if(error) 
        {
            *error = [GtAlloc(NSError) initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorGuidNotFound userInfo:nil];
        }
        return NO;
    }
    
    return YES;
}



+ (BOOL) loadUserLogin:(GtUserLogin*) login
                outError:(NSError**) error
{
    GtAssertNotNil(login);
    
    BOOL doSave = NO;
    
    NSError* err = nil;
    if(![GtUserDefaults loadUserNameAndGuid:login outError:&err])
    {
        if(err.code == GtUserLoginErrorGuidNotFound)
        {
            login.userGuid = [NSString stringWithGuid];
            doSave = YES;
        }
        else
        {
            if(error)
            {
                *error = err;
            }
            
            return NO;
        }
    
        GtRelease(err);
    }
    
    GtAssertIsValidString(login.userName);
    GtAssertIsValidString(login.userGuid);

    NSError* keychainError = nil;
    NSString* password = nil;
    if([GtKeychain getPasswordForUsername:login.userName
                                    andServiceName:[GtFileUtilities appName]
                                    outPassword:&password
                                    error:&keychainError])
    {
        login.password = password;
        GtRelease(password);
        
        if(doSave)
        {
            return ([GtUserDefaults saveUserLogin:login outError:error]);
        }
        
        return YES;
    }

#if DEBUG
    GtLog(@"Warning: Loading user login failed: %@", [keychainError description]);
#endif
     
    if(error)
    {
        if(keychainError.code == GtKeychainErrorItemPasswordNotFound)
        {
            *error = [GtAlloc(NSError) initWithDomain:GtUserLoginErrorDomain code:GtUserLoginErrorPasswordNotFound userInfo:nil];
        }
        else
        {
            *error = keychainError;
            keychainError = nil; // so it's not released below
        }
    }
    
    GtRelease(keychainError);
                                                                                           
    return NO;
}

+ (BOOL) checkUidForLogin:(GtUserLogin*) login
                 outError:(NSError**) error
{
    if(!login.userGuidHasValue)
    {
        GtUserLogin* loadUidLogin = [GtAlloc(GtUserLogin) init];
        loadUidLogin.userName = login.userName;
        NSError* err = nil;
        BOOL loaded = [GtUserDefaults loadUserNameAndGuid:loadUidLogin outError:&err];
        if(loaded)
        {
            login.userGuid = loadUidLogin.userGuid;
        }
        GtRelease(loadUidLogin);

        if(!loaded)
        {   
            [err autorelease];
            
            if(err.code != GtUserLoginErrorGuidNotFound)
            {
                if(error)
                {
                    *error = [err retain];
                }
                return NO;
            }
        }
    }
    
    if(!login.userGuidHasValue)
    {
        login.userGuid = [NSString stringWithGuid];
    }

    return YES;
}


+ (BOOL) saveUserLogin:(GtUserLogin*) login
              outError:(NSError**) error
{
    GtAssertNotNil(login);
    GtAssertIsValidString(login.userName);

    NSError* internalError = nil;

    if(![GtUserDefaults checkUidForLogin:login outError:&internalError])
    {
#if DEBUG
        GtLog(@"Warning: Saving user login failed: %@",  [internalError description]);
#endif
        if(error)
        {
            *error = [internalError retain];
        }

        GtRelease(internalError);
        return NO;
    }

    GtAssertIsValidString(login.userGuid);

   	NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
	[defaults setObject:login.userName forKey:[GtUserLogin userNameKey]];
	[defaults setObject:login.userGuid forKey:[self userGuidKey:login]];
	[defaults synchronize];
    
    if([GtKeychain storeUsername: login.userName
        andPassword:login.password
        forServiceName:[GtFileUtilities appName]
        updateExisting:YES
        error:&internalError])
    {
        return YES;
    }

#if DEBUG
    GtLog(@"Warning: Saving user login failed: %@",  [internalError description]);
#endif
    
    if(error)
    {
        *error = [internalError retain];
    }
    
    GtRelease(internalError);
                            
    return NO;
}

@end

@implementation GtUserLogin (More)

- (void) addGuid
{
    self.userGuid = [NSString stringWithGuid];
}
@end