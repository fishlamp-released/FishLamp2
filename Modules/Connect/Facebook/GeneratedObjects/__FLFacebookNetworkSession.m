// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNetworkSession.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookNetworkSession.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLFacebookNetworkSession


@synthesize access_token = __access_token;
@synthesize appId = __appId;
@synthesize expiration_date = __expiration_date;
@synthesize permissions = __permissions;
@synthesize userId = __userId;

+ (NSString*) access_tokenKey
{
    return @"access_token";
}

+ (NSString*) appIdKey
{
    return @"appId";
}

+ (NSString*) expiration_dateKey
{
    return @"expiration_date";
}

+ (NSString*) permissionsKey
{
    return @"permissions";
}

+ (NSString*) userIdKey
{
    return @"userId";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookNetworkSession*)object).appId = FLCopyOrRetainObject(__appId);
    ((FLFacebookNetworkSession*)object).expiration_date = FLCopyOrRetainObject(__expiration_date);
    ((FLFacebookNetworkSession*)object).permissions = FLCopyOrRetainObject(__permissions);
    ((FLFacebookNetworkSession*)object).userId = FLCopyOrRetainObject(__userId);
    ((FLFacebookNetworkSession*)object).access_token = FLCopyOrRetainObject(__access_token);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__userId);
    FLRelease(__appId);
    FLRelease(__access_token);
    FLRelease(__expiration_date);
    FLRelease(__permissions);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__userId) [aCoder encodeObject:__userId forKey:@"__userId"];
    if(__appId) [aCoder encodeObject:__appId forKey:@"__appId"];
    if(__access_token) [aCoder encodeObject:__access_token forKey:@"__access_token"];
    if(__expiration_date) [aCoder encodeObject:__expiration_date forKey:@"__expiration_date"];
    if(__permissions) [aCoder encodeObject:__permissions forKey:@"__permissions"];
}

+ (FLFacebookNetworkSession*) facebookNetworkSession
{
    return FLReturnAutoreleased([[FLFacebookNetworkSession alloc] init]);
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
        __userId = FLReturnRetained([aDecoder decodeObjectForKey:@"__userId"]);
        __appId = FLReturnRetained([aDecoder decodeObjectForKey:@"__appId"]);
        __access_token = FLReturnRetained([aDecoder decodeObjectForKey:@"__access_token"]);
        __expiration_date = FLReturnRetained([aDecoder decodeObjectForKey:@"__expiration_date"]);
        __permissions = [[aDecoder decodeObjectForKey:@"__permissions"] mutableCopy];
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"userId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"userId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"appId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"appId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"access_token" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"access_token"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"expiration_date" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"expiration_date"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"permissions" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"permission" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"permissions"];
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

+ (FLSqliteTable*) sharedSqliteTable
{
    static FLSqliteTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        FLSqliteTable* superTable = [super sharedSqliteTable];
        if(superTable)
        {
            s_table = [superTable copy];
            s_table.tableName = [self sqliteTableName];
        }
        else
        {
            s_table = [[FLSqliteTable alloc] initWithTableName:[self sqliteTableName]];
        }
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"userId" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"userId" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"appId" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"access_token" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"expiration_date" columnType:FLSqliteTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"permissions" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookNetworkSession (ValueProperties) 
@end

// [/Generated]
