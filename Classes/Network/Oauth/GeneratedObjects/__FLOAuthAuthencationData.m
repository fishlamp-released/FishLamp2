// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLOAuthAuthencationData.m
// Project: FishLamp
// Schema: FLOauth
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLOAuthAuthencationData.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLOAuthAuthencationData


@synthesize oauth_callback_confirmed = __oauth_callback_confirmed;
@synthesize oauth_token = __oauth_token;
@synthesize oauth_token_secret = __oauth_token_secret;
@synthesize oauth_verifier = __oauth_verifier;

+ (NSString*) oauth_callback_confirmedKey
{
    return @"oauth_callback_confirmed";
}

+ (NSString*) oauth_tokenKey
{
    return @"oauth_token";
}

+ (NSString*) oauth_token_secretKey
{
    return @"oauth_token_secret";
}

+ (NSString*) oauth_verifierKey
{
    return @"oauth_verifier";
}

- (void) dealloc
{
    FLRelease(__oauth_token_secret);
    FLRelease(__oauth_callback_confirmed);
    FLRelease(__oauth_token);
    FLRelease(__oauth_verifier);
    FLSuperDealloc();
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

+ (FLOAuthAuthencationData*) oAuthAuthencationData
{
    return FLReturnAutoreleased([[FLOAuthAuthencationData alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_token_secret" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_token_secret"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_callback_confirmed" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_callback_confirmed"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_token" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_token"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"oauth_verifier" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"oauth_verifier"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_token_secret" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_callback_confirmed" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_token" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"oauth_verifier" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLOAuthAuthencationData (ValueProperties) 
@end

// [/Generated]
