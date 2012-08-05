// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLExportedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLExportedAsset.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLExportedAsset


@synthesize assetURL = __assetURL;
@synthesize exportedDate = __exportedDate;
@synthesize originalID = __originalID;

+ (NSString*) assetURLKey
{
    return @"assetURL";
}

+ (NSString*) exportedDateKey
{
    return @"exportedDate";
}

+ (NSString*) originalIDKey
{
    return @"originalID";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLExportedAsset*)object).assetURL = FLCopyOrRetainObject(__assetURL);
    ((FLExportedAsset*)object).exportedDate = FLCopyOrRetainObject(__exportedDate);
    ((FLExportedAsset*)object).originalID = FLCopyOrRetainObject(__originalID);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__originalID);
    FLRelease(__assetURL);
    FLRelease(__exportedDate);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__originalID) [aCoder encodeObject:__originalID forKey:@"__originalID"];
    if(__assetURL) [aCoder encodeObject:__assetURL forKey:@"__assetURL"];
    if(__exportedDate) [aCoder encodeObject:__exportedDate forKey:@"__exportedDate"];
}

+ (FLExportedAsset*) exportedAsset
{
    return FLReturnAutoreleased([[FLExportedAsset alloc] init]);
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
        __originalID = FLReturnRetained([aDecoder decodeObjectForKey:@"__originalID"]);
        __assetURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetURL"]);
        __exportedDate = FLReturnRetained([aDecoder decodeObjectForKey:@"__exportedDate"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"originalID" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"originalID"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"exportedDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"exportedDate"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"originalID" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"originalID" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"assetURL" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"exportedDate" columnType:FLSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
    });
    return s_table;
}

@end

@implementation FLExportedAsset (ValueProperties) 
@end

// [/Generated]
