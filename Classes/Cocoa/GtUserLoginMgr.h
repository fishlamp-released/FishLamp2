//
//  GtUserLoginMgr.h
//  FishLamp
//
//  Created by Mike Fullerton on 5/22/11.
//  Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import <Foundation/Foundation.h>

#import "GtUserLogin.h"

#define GtUserLoginErrorDomain @"GtUserLoginErrorDomain"

typedef enum {
	GtUserLoginErrorCodeNone,
	GtUserLoginErrorCodeInvalidUserGuid
} GtUserLoginErrorCode;

// this is a wrapper for storing and managing userLogin options in the applicationData database.

@interface GtUserLoginMgr : NSObject {

}

GtSingletonProperty(GtUserLoginMgr);

- (GtUserLogin*) loadLastUserLogin;// doesn't load password

- (GtUserLogin*) loadUserLoginWithUserName:(NSString*) name;// doesn't load password

- (GtUserLogin*) loadUserLoginWithGuid:(NSString*) guid; // doesn't load password
 
- (void) saveUserLogin:(GtUserLogin*) userLogin; // doesn't save password

- (void) deleteUserLogin:(GtUserLogin*) userLogin; // deletes password too

- (void) setCurrentUser:(GtUserLogin*) userLogin;

- (void) savePasswordForUserLogin:(GtUserLogin*) userLogin;

- (void) loadPasswordForUserLogin:(GtUserLogin*) userLogin;


@end
