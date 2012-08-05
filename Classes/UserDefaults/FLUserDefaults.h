//
//	FLUserDefaults.h
//	FishLamp
//
//	Created by Mike Fullerton on 10/13/09.
//	Copyright 2009 GreenTongue Software. All rights reserved.
//

#if 0
#import "FishLampCocoa.h"

#import "FLUserLogin.h"



extern NSString* FLUserLoginErrorDomain;

enum 
{
	FLUserLoginErrorUserNotFound		= -1000,
	FLUserLoginErrorGuidNotFound		= -1001,
	FLUserLoginErrorPasswordNotFound	= -1002
};

@interface FLUserDefaults : NSObject {
}

+ (BOOL) userExists:(FLUserLogin*) login;
+ (BOOL) loadUserLogin:(FLUserLogin*) login outError:(NSError**) errorOrNil;
+ (BOOL) saveToUserDefaults:(FLUserLogin*) login outError:(NSError**) errorOrNil;
+ (BOOL) removeDefaultData:(FLUserLogin*) login
		   outError:(NSError**) error;
+ (BOOL) loadDefaultData:(FLUserLogin*) login
		   outError:(NSError**) error;
		   
+ (void) removeKeysInArray:(NSArray*) keys;
+ (void) loadAllData:(NSArray**) outKeys outData:(NSDictionary**) outData;

@end
#endif