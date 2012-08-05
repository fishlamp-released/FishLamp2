// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookGroup.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookGroup.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLFacebookGroup


@synthesize description = __description;
@synthesize icon = __icon;
@synthesize link = __link;
@synthesize owner = __owner;
@synthesize privacy = __privacy;
@synthesize updated_time = __updated_time;

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) iconKey
{
    return @"icon";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) ownerKey
{
    return @"owner";
}

+ (NSString*) privacyKey
{
    return @"privacy";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookGroup*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookGroup*)object).owner = FLCopyOrRetainObject(__owner);
    ((FLFacebookGroup*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookGroup*)object).description = FLCopyOrRetainObject(__description);
    ((FLFacebookGroup*)object).privacy = FLCopyOrRetainObject(__privacy);
    ((FLFacebookGroup*)object).link = FLCopyOrRetainObject(__link);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__owner);
    FLRelease(__icon);
    FLRelease(__description);
    FLRelease(__link);
    FLRelease(__privacy);
    FLRelease(__updated_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__owner) [aCoder encodeObject:__owner forKey:@"__owner"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__privacy) [aCoder encodeObject:__privacy forKey:@"__privacy"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookGroup*) facebookGroup
{
    return FLReturnAutoreleased([[FLFacebookGroup alloc] init]);
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
    if((self = [super initWithCoder:aDecoder]))
    {
        __owner = FLReturnRetained([aDecoder decodeObjectForKey:@"__owner"]);
        __icon = FLReturnRetained([aDecoder decodeObjectForKey:@"__icon"]);
        __description = FLReturnRetained([aDecoder decodeObjectForKey:@"__description"]);
        __link = FLReturnRetained([aDecoder decodeObjectForKey:@"__link"]);
        __privacy = FLReturnRetained([aDecoder decodeObjectForKey:@"__privacy"]);
        __updated_time = FLReturnRetained([aDecoder decodeObjectForKey:@"__updated_time"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"owner" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"owner"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"icon"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"description"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"link"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"privacy" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"privacy"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"updated_time"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"owner" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"description" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"link" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"privacy" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:FLSqliteTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookGroup (ValueProperties) 
@end

// [/Generated]
