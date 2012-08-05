// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLOAuthApp.m
// Project: FishLamp
// Schema: FLOauth
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLOAuthApp.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLOAuthApp


@synthesize accessTokenUrl = __accessTokenUrl;
@synthesize apiKey = __apiKey;
@synthesize appId = __appId;
@synthesize authorizeUrl = __authorizeUrl;
@synthesize callback = __callback;
@synthesize consumerKey = __consumerKey;
@synthesize consumerSecret = __consumerSecret;
@synthesize requestTokenUrl = __requestTokenUrl;

+ (NSString*) accessTokenUrlKey
{
    return @"accessTokenUrl";
}

+ (NSString*) apiKeyKey
{
    return @"apiKey";
}

+ (NSString*) appIdKey
{
    return @"appId";
}

+ (NSString*) authorizeUrlKey
{
    return @"authorizeUrl";
}

+ (NSString*) callbackKey
{
    return @"callback";
}

+ (NSString*) consumerKeyKey
{
    return @"consumerKey";
}

+ (NSString*) consumerSecretKey
{
    return @"consumerSecret";
}

+ (NSString*) requestTokenUrlKey
{
    return @"requestTokenUrl";
}

- (void) dealloc
{
    FLRelease(__appId);
    FLRelease(__apiKey);
    FLRelease(__consumerKey);
    FLRelease(__consumerSecret);
    FLRelease(__requestTokenUrl);
    FLRelease(__accessTokenUrl);
    FLRelease(__authorizeUrl);
    FLRelease(__callback);
    FLSuperDealloc();
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

+ (FLOAuthApp*) oAuthApp
{
    return FLReturnAutoreleased([[FLOAuthApp alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"appId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"appId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"apiKey" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"apiKey"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"consumerKey" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"consumerKey"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"consumerSecret" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"consumerSecret"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"requestTokenUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"requestTokenUrl"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"accessTokenUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"accessTokenUrl"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"authorizeUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"authorizeUrl"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"callback" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"callback"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"appId" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"apiKey" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"consumerKey" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"consumerSecret" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"requestTokenUrl" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"accessTokenUrl" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"authorizeUrl" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"callback" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLOAuthApp (ValueProperties) 
@end

// [/Generated]
