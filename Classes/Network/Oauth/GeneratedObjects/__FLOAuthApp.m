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
#import "FLDatabaseTable.h"

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
    mrc_release_(__appId);
    mrc_release_(__apiKey);
    mrc_release_(__consumerKey);
    mrc_release_(__consumerSecret);
    mrc_release_(__requestTokenUrl);
    mrc_release_(__accessTokenUrl);
    mrc_release_(__authorizeUrl);
    mrc_release_(__callback);
    super_dealloc_();
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
    return autorelease_([[FLOAuthApp alloc] init]);
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"appId" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"apiKey" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"consumerKey" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"consumerSecret" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"requestTokenUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"accessTokenUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"authorizeUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"callback" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLOAuthApp (ValueProperties) 
@end

// [/Generated]
