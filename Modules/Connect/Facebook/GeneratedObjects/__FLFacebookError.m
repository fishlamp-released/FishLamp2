// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookError.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookError.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLFacebookError


@synthesize error = __error;
@synthesize error_description = __error_description;
@synthesize error_reason = __error_reason;
@synthesize externalUrl = __externalUrl;

+ (NSString*) errorKey
{
    return @"error";
}

+ (NSString*) error_descriptionKey
{
    return @"error_description";
}

+ (NSString*) error_reasonKey
{
    return @"error_reason";
}

+ (NSString*) externalUrlKey
{
    return @"externalUrl";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookError*)object).error_reason = FLCopyOrRetainObject(__error_reason);
    ((FLFacebookError*)object).error_description = FLCopyOrRetainObject(__error_description);
    ((FLFacebookError*)object).externalUrl = FLCopyOrRetainObject(__externalUrl);
    ((FLFacebookError*)object).error = FLCopyOrRetainObject(__error);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__error_reason);
    FLRelease(__error);
    FLRelease(__error_description);
    FLRelease(__externalUrl);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__error_reason) [aCoder encodeObject:__error_reason forKey:@"__error_reason"];
    if(__error) [aCoder encodeObject:__error forKey:@"__error"];
    if(__error_description) [aCoder encodeObject:__error_description forKey:@"__error_description"];
    if(__externalUrl) [aCoder encodeObject:__externalUrl forKey:@"__externalUrl"];
}

+ (FLFacebookError*) facebookError
{
    return FLReturnAutoreleased([[FLFacebookError alloc] init]);
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
        __error_reason = FLReturnRetained([aDecoder decodeObjectForKey:@"__error_reason"]);
        __error = FLReturnRetained([aDecoder decodeObjectForKey:@"__error"]);
        __error_description = FLReturnRetained([aDecoder decodeObjectForKey:@"__error_description"]);
        __externalUrl = FLReturnRetained([aDecoder decodeObjectForKey:@"__externalUrl"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"error_reason" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"error_reason"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"error" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"error"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"error_description" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"error_description"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"externalUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"externalUrl"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"error_reason" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"error" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"error_description" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"externalUrl" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookError (ValueProperties) 
@end

// [/Generated]
