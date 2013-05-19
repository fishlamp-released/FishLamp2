//
//  FLApplicationDataModel.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright (c) 2013 GreenTongue Software LLC, Mike Fullerton.
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
#if REFACTOR

#import "FishLampCore.h"
#import "FLSynchronousOperation.h"
#import "FLDatabase.h"
#import "FLUserLogin.h"

#define FLUserLoginErrorDomain @"FLUserLoginErrorDomain"

typedef enum {
	FLUserLoginErrorCodeNone,
	FLUserLoginErrorCodeInvalidUserGuid
} FLUserLoginErrorCode;

@interface FLApplicationDataModel : NSObject {
@private
	FLDatabase* _database;
}

@property (readonly, strong) FLDatabase* database;

FLSingletonProperty(FLApplicationDataModel);

@property (readonly, assign) BOOL isOpen;

- (FLSynchronousOperation*) createOpenOperation;

- (FLUserLogin*) loadLastUserLogin;// doesn't load password

- (FLUserLogin*) loadUserLoginWithUserName:(NSString*) name;// doesn't load password

- (FLUserLogin*) loadUserLoginWithGuid:(NSString*) guid; // doesn't load password
 
- (void) saveUserLogin:(FLUserLogin*) userLogin; // doesn't save password

- (void) deleteUserLogin:(FLUserLogin*) userLogin; // deletes password too

- (void) setCurrentUser:(FLUserLogin*) userLogin;

- (void) savePasswordForUserLogin:(FLUserLogin*) userLogin;

- (void) loadPasswordForUserLogin:(FLUserLogin*) userLogin;

@end

#endif