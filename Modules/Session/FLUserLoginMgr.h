//
//  FLUserLoginMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright 2011 GreenTongue Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishLampCore.h"

#import "FLUserLogin.h"

#define FLUserLoginErrorDomain @"FLUserLoginErrorDomain"

typedef enum {
	FLUserLoginErrorCodeNone,
	FLUserLoginErrorCodeInvalidUserGuid
} FLUserLoginErrorCode;

// this is a wrapper for storing and managing userLogin options in the applicationData database.

@interface FLUserLoginMgr : NSObject {

}

FLSingletonProperty(FLUserLoginMgr);

- (FLUserLogin*) loadLastUserLogin;// doesn't load password

- (FLUserLogin*) loadUserLoginWithUserName:(NSString*) name;// doesn't load password

- (FLUserLogin*) loadUserLoginWithGuid:(NSString*) guid; // doesn't load password
 
- (void) saveUserLogin:(FLUserLogin*) userLogin; // doesn't save password

- (void) deleteUserLogin:(FLUserLogin*) userLogin; // deletes password too

- (void) setCurrentUser:(FLUserLogin*) userLogin;

- (void) savePasswordForUserLogin:(FLUserLogin*) userLogin;

- (void) loadPasswordForUserLogin:(FLUserLogin*) userLogin;


@end
