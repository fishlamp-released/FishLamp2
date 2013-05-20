// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUserLogin.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUserLogin.h"

@implementation FLUserLogin

@synthesize authToken = __authToken;
@synthesize authTokenLastUpdateTime = __authTokenLastUpdateTime;
@synthesize email = __email;
@synthesize isAuthenticated = __isAuthenticated;
@synthesize password = __password;
@synthesize userGuid = __userGuid;
@synthesize userName = __userName;

- (void) dealloc
{
    FLRelease(__userGuid);
    FLRelease(__userName);
    FLRelease(__password);
    FLRelease(__authToken);
    FLRelease(__email);
    FLSuperDealloc();
}

+(SEL) databasePrimaryKeyColumn {
    return @selector(userGuid);
}

//        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userName" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLUniqueConstraint uniqueConstraint], nil]]];

//        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"email" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLUniqueConstraint uniqueConstraint], nil]]];

+ (id) userLogin {
    return FLAutorelease([[[self class] alloc] init]);
}

@end
