// [Generated]
//
// FLUserLogin.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//
// [/Generated]

#import "__FLUserLogin.h"
#import "FLCredentials.h"

@interface FLUserLogin (ObjC)

+ (id) userLogin:(NSString*) userName password:(NSString*) password;

- (void) setPropertiesWithUserLogin:(FLUserLogin*) login;

+ (id) userLoginWithCredentials:(id<FLCredentials>) credentials;

@end
