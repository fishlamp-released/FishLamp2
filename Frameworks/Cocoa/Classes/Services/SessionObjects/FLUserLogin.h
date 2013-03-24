// [Generated]
//
// FLUserLogin.h
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//
// [/Generated]

#import "__FLUserLogin.h"

@interface FLUserLogin (ObjC)

// Your methods here. Declare properties and data in your whittle object file.

@property (readwrite, strong, nonatomic) NSDictionary* userInfo;

+ (id) userLogin:(NSString*) userName password:(NSString*) password;

- (void) setPropertiesWithUserLogin:(FLUserLogin*) login;

@end
