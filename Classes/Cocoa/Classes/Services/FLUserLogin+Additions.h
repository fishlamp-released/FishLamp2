//
// FLUserLogin.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2013 GreenTongue Software, LLC., Mike Fullerton
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUserLogin.h"
#import "FLCredentials.h"

@interface FLUserLogin (Additions)

+ (id) userLogin:(NSString*) userName password:(NSString*) password;

- (void) setPropertiesWithUserLogin:(FLUserLogin*) login;

+ (id) userLoginWithCredentials:(id<FLCredentials>) credentials;

@end
