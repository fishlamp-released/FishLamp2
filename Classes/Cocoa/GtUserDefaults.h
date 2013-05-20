//
//	GtUserDefaults.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright (c) 2013 GreenTongue Software, LLC, Mike Fullerton.The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#if 0

#import "GtUserLogin.h"



extern NSString* GtUserLoginErrorDomain;

enum 
{
	GtUserLoginErrorUserNotFound		= -1000,
	GtUserLoginErrorGuidNotFound		= -1001,
	GtUserLoginErrorPasswordNotFound	= -1002
};

@interface GtUserDefaults : NSObject {
}

+ (BOOL) userExists:(GtUserLogin*) login;
+ (BOOL) loadUserLogin:(GtUserLogin*) login outError:(NSError**) errorOrNil;
+ (BOOL) saveToUserDefaults:(GtUserLogin*) login outError:(NSError**) errorOrNil;
+ (BOOL) removeDefaultData:(GtUserLogin*) login
		   outError:(NSError**) error;
+ (BOOL) loadDefaultData:(GtUserLogin*) login
		   outError:(NSError**) error;
		   
+ (void) removeKeysInArray:(NSArray*) keys;
+ (void) loadAllData:(NSArray**) outKeys outData:(NSDictionary**) outData;

@end
#endif