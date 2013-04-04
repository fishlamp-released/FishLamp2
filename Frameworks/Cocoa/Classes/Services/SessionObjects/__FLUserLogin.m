// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUserLogin.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLUserLogin.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLUserLogin


@synthesize authToken = __authToken;
@synthesize authTokenLastUpdateTime = __authTokenLastUpdateTime;
@synthesize email = __email;
@synthesize isAuthenticated = __isAuthenticated;
@synthesize password = __password;
@synthesize userGuid = __userGuid;
@synthesize userName = __userName;
@synthesize userValue = __userValue;

+ (NSString*) authTokenKey
{
    return @"authToken";
}

+ (NSString*) authTokenLastUpdateTimeKey
{
    return @"authTokenLastUpdateTime";
}

+ (NSString*) emailKey
{
    return @"email";
}

+ (NSString*) isAuthenticatedKey
{
    return @"isAuthenticated";
}

+ (NSString*) passwordKey
{
    return @"password";
}

+ (NSString*) userGuidKey
{
    return @"userGuid";
}

+ (NSString*) userNameKey
{
    return @"userName";
}

+ (NSString*) userValueKey
{
    return @"userValue";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLUserLogin*)object).password = FLCopyOrRetainObject(__password);
    ((FLUserLogin*)object).isAuthenticated = FLCopyOrRetainObject(__isAuthenticated);
    ((FLUserLogin*)object).authToken = FLCopyOrRetainObject(__authToken);
    ((FLUserLogin*)object).userName = FLCopyOrRetainObject(__userName);
    ((FLUserLogin*)object).authTokenLastUpdateTime = FLCopyOrRetainObject(__authTokenLastUpdateTime);
    ((FLUserLogin*)object).userGuid = FLCopyOrRetainObject(__userGuid);
    ((FLUserLogin*)object).email = FLCopyOrRetainObject(__email);
    ((FLUserLogin*)object).userValue = FLCopyOrRetainObject(__userValue);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__userGuid);
    FLRelease(__userName);
    FLRelease(__password);
    FLRelease(__isAuthenticated);
    FLRelease(__authToken);
    FLRelease(__email);
    FLRelease(__authTokenLastUpdateTime);
    FLRelease(__userValue);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__userGuid) [aCoder encodeObject:__userGuid forKey:@"__userGuid"];
    if(__userName) [aCoder encodeObject:__userName forKey:@"__userName"];
    if(__password) [aCoder encodeObject:__password forKey:@"__password"];
    if(__isAuthenticated) [aCoder encodeObject:__isAuthenticated forKey:@"__isAuthenticated"];
    if(__authToken) [aCoder encodeObject:__authToken forKey:@"__authToken"];
    if(__email) [aCoder encodeObject:__email forKey:@"__email"];
    if(__authTokenLastUpdateTime) [aCoder encodeObject:__authTokenLastUpdateTime forKey:@"__authTokenLastUpdateTime"];
    if(__userValue) [aCoder encodeObject:__userValue forKey:@"__userValue"];
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
    if((self = [super init]))
    {
        __userGuid = FLRetain([aDecoder decodeObjectForKey:@"__userGuid"]);
        __userName = FLRetain([aDecoder decodeObjectForKey:@"__userName"]);
        __password = FLRetain([aDecoder decodeObjectForKey:@"__password"]);
        __isAuthenticated = FLRetain([aDecoder decodeObjectForKey:@"__isAuthenticated"]);
        __authToken = FLRetain([aDecoder decodeObjectForKey:@"__authToken"]);
        __email = FLRetain([aDecoder decodeObjectForKey:@"__email"]);
        __authTokenLastUpdateTime = FLRetain([aDecoder decodeObjectForKey:@"__authTokenLastUpdateTime"]);
        __userValue = FLRetain([aDecoder decodeObjectForKey:@"__userValue"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addChildDescriberWithName:@"userGuid" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"userName" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"password" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"isAuthenticated" withClass:[FLBoolNumber class] ];
        [s_describer addChildDescriberWithName:@"authToken" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"email" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"authTokenLastUpdateTime" withClass:[FLDoubleNumber class] ];
        [s_describer addChildDescriberWithName:@"userValue" withClass:[FLLongNumber class] ];
    });
    return s_describer;
}



+ (FLDatabaseTable*) sharedDatabaseTable
{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        FLDatabaseTable* superTable = [super sharedDatabaseTable];
        if(superTable)
        {
            s_table = [superTable copy];
            s_table.tableName = [self databaseTableName];
        }
        else
        {
            s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
        }
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userGuid" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userName" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn uniqueConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"userName" indexProperties:FLDatabaseColumnIndexPropertyUnique]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"isAuthenticated" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"authToken" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"email" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn uniqueConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"email" indexProperties:FLDatabaseColumnIndexPropertyUnique]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"authTokenLastUpdateTime" columnType:FLDatabaseTypeFloat columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userValue" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

+ (id) userLogin
{
    return FLAutorelease([[[self class] alloc] init]);
}

@end

@implementation FLUserLogin (ValueProperties) 

- (BOOL) isAuthenticatedValue
{
    return [self.isAuthenticated boolValue];
}

- (void) setIsAuthenticatedValue:(BOOL) value
{
    self.isAuthenticated = [NSNumber numberWithBool:value];
}

- (double) authTokenLastUpdateTimeValue
{
    return [self.authTokenLastUpdateTime doubleValue];
}

- (void) setAuthTokenLastUpdateTimeValue:(double) value
{
    self.authTokenLastUpdateTime = [NSNumber numberWithDouble:value];
}

- (long) userValueValue
{
    return [self.userValue longValue];
}

- (void) setUserValueValue:(long) value
{
    self.userValue = [NSNumber numberWithLong:value];
}
@end

// [/Generated]
