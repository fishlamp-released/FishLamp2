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
#import "FLObjectInflator.h"
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
    release_(__userGuid);
    release_(__userName);
    release_(__password);
    release_(__isAuthenticated);
    release_(__authToken);
    release_(__email);
    release_(__authTokenLastUpdateTime);
    release_(__userValue);
    super_dealloc_();
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
        __userGuid = retain_([aDecoder decodeObjectForKey:@"__userGuid"]);
        __userName = retain_([aDecoder decodeObjectForKey:@"__userName"]);
        __password = retain_([aDecoder decodeObjectForKey:@"__password"]);
        __isAuthenticated = retain_([aDecoder decodeObjectForKey:@"__isAuthenticated"]);
        __authToken = retain_([aDecoder decodeObjectForKey:@"__authToken"]);
        __email = retain_([aDecoder decodeObjectForKey:@"__email"]);
        __authTokenLastUpdateTime = retain_([aDecoder decodeObjectForKey:@"__authTokenLastUpdateTime"]);
        __userValue = retain_([aDecoder decodeObjectForKey:@"__userValue"]);
    }
    return self;
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_describer = [[super sharedObjectDescriber] copy];
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] init];
        }
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"userGuid"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"userName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"userName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"password" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"password"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"isAuthenticated" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"isAuthenticated"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"authToken" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"authToken"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"email" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"email"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"authTokenLastUpdateTime" propertyClass:[NSNumber class] propertyType:FLDataTypeDouble] forPropertyName:@"authTokenLastUpdateTime"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"userValue" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"userValue"];
    });
    return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
    });
    return s_inflator;
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

+ (FLUserLogin*) userLogin
{
    return autorelease_([[FLUserLogin alloc] init]);
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
