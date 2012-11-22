// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLOAuthSession.m
// Project: FishLamp
// Schema: FLOauth
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLOAuthSession.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLOAuthSession


@synthesize appName = __appName;
@synthesize oauth_token = __oauth_token;
@synthesize oauth_token_secret = __oauth_token_secret;
@synthesize screen_name = __screen_name;
@synthesize userGuid = __userGuid;
@synthesize user_id = __user_id;

+ (NSString*) appNameKey
{
    return @"appName";
}

+ (NSString*) oauth_tokenKey
{
    return @"oauth_token";
}

+ (NSString*) oauth_token_secretKey
{
    return @"oauth_token_secret";
}

+ (NSString*) screen_nameKey
{
    return @"screen_name";
}

+ (NSString*) userGuidKey
{
    return @"userGuid";
}

+ (NSString*) user_idKey
{
    return @"user_id";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLOAuthSession*)object).userGuid = FLCopyOrRetainObject(__userGuid);
    ((FLOAuthSession*)object).appName = FLCopyOrRetainObject(__appName);
    ((FLOAuthSession*)object).oauth_token_secret = FLCopyOrRetainObject(__oauth_token_secret);
    ((FLOAuthSession*)object).user_id = FLCopyOrRetainObject(__user_id);
    ((FLOAuthSession*)object).screen_name = FLCopyOrRetainObject(__screen_name);
    ((FLOAuthSession*)object).oauth_token = FLCopyOrRetainObject(__oauth_token);
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
    release_(__appName);
    release_(__oauth_token);
    release_(__oauth_token_secret);
    release_(__user_id);
    release_(__screen_name);
    super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__userGuid) [aCoder encodeObject:__userGuid forKey:@"__userGuid"];
    if(__appName) [aCoder encodeObject:__appName forKey:@"__appName"];
    if(__oauth_token) [aCoder encodeObject:__oauth_token forKey:@"__oauth_token"];
    if(__oauth_token_secret) [aCoder encodeObject:__oauth_token_secret forKey:@"__oauth_token_secret"];
    if(__user_id) [aCoder encodeObject:__user_id forKey:@"__user_id"];
    if(__screen_name) [aCoder encodeObject:__screen_name forKey:@"__screen_name"];
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
        __appName = retain_([aDecoder decodeObjectForKey:@"__appName"]);
        __oauth_token = retain_([aDecoder decodeObjectForKey:@"__oauth_token"]);
        __oauth_token_secret = retain_([aDecoder decodeObjectForKey:@"__oauth_token_secret"]);
        __user_id = retain_([aDecoder decodeObjectForKey:@"__user_id"]);
        __screen_name = retain_([aDecoder decodeObjectForKey:@"__screen_name"]);
    }
    return self;
}

+ (FLOAuthSession*) oAuthSession
{
    return autorelease_([[FLOAuthSession alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"appName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"appName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_token" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_token"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_token_secret" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_token_secret"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"user_id" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"user_id"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"screen_name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"screen_name"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"appName" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"appName" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_token" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_token_secret" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"user_id" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"user_id" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"screen_name" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLOAuthSession (ValueProperties) 
@end

// [/Generated]
