// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUploadedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLUploadedAsset.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLUploadedAsset


@synthesize assetName = __assetName;
@synthesize assetType = __assetType;
@synthesize assetUID = __assetUID;
@synthesize assetURL = __assetURL;
@synthesize queueUID = __queueUID;
@synthesize thumbnail = __thumbnail;
@synthesize uploadDestinationId = __uploadDestinationId;
@synthesize uploadDestinationName = __uploadDestinationName;
@synthesize uploadDestinationURL = __uploadDestinationURL;
@synthesize uploadedAssetId = __uploadedAssetId;
@synthesize uploadedAssetUID = __uploadedAssetUID;
@synthesize uploadedAssetURL = __uploadedAssetURL;
@synthesize uploadedDate = __uploadedDate;

+ (NSString*) assetNameKey
{
    return @"assetName";
}

+ (NSString*) assetTypeKey
{
    return @"assetType";
}

+ (NSString*) assetUIDKey
{
    return @"assetUID";
}

+ (NSString*) assetURLKey
{
    return @"assetURL";
}

+ (NSString*) queueUIDKey
{
    return @"queueUID";
}

+ (NSString*) thumbnailKey
{
    return @"thumbnail";
}

+ (NSString*) uploadDestinationIdKey
{
    return @"uploadDestinationId";
}

+ (NSString*) uploadDestinationNameKey
{
    return @"uploadDestinationName";
}

+ (NSString*) uploadDestinationURLKey
{
    return @"uploadDestinationURL";
}

+ (NSString*) uploadedAssetIdKey
{
    return @"uploadedAssetId";
}

+ (NSString*) uploadedAssetUIDKey
{
    return @"uploadedAssetUID";
}

+ (NSString*) uploadedAssetURLKey
{
    return @"uploadedAssetURL";
}

+ (NSString*) uploadedDateKey
{
    return @"uploadedDate";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLUploadedAsset*)object).uploadDestinationName = FLCopyOrRetainObject(__uploadDestinationName);
    ((FLUploadedAsset*)object).assetURL = FLCopyOrRetainObject(__assetURL);
    ((FLUploadedAsset*)object).uploadedAssetUID = FLCopyOrRetainObject(__uploadedAssetUID);
    ((FLUploadedAsset*)object).uploadDestinationURL = FLCopyOrRetainObject(__uploadDestinationURL);
    ((FLUploadedAsset*)object).queueUID = FLCopyOrRetainObject(__queueUID);
    ((FLUploadedAsset*)object).uploadedAssetURL = FLCopyOrRetainObject(__uploadedAssetURL);
    ((FLUploadedAsset*)object).uploadedAssetId = FLCopyOrRetainObject(__uploadedAssetId);
    ((FLUploadedAsset*)object).assetName = FLCopyOrRetainObject(__assetName);
    ((FLUploadedAsset*)object).uploadedDate = FLCopyOrRetainObject(__uploadedDate);
    ((FLUploadedAsset*)object).assetUID = FLCopyOrRetainObject(__assetUID);
    ((FLUploadedAsset*)object).uploadDestinationId = FLCopyOrRetainObject(__uploadDestinationId);
    ((FLUploadedAsset*)object).assetType = FLCopyOrRetainObject(__assetType);
    ((FLUploadedAsset*)object).thumbnail = FLCopyOrRetainObject(__thumbnail);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__queueUID);
    FLRelease(__uploadedAssetUID);
    FLRelease(__assetType);
    FLRelease(__assetURL);
    FLRelease(__assetUID);
    FLRelease(__uploadedAssetURL);
    FLRelease(__uploadedAssetId);
    FLRelease(__uploadDestinationId);
    FLRelease(__uploadDestinationName);
    FLRelease(__uploadDestinationURL);
    FLRelease(__assetName);
    FLRelease(__thumbnail);
    FLRelease(__uploadedDate);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__queueUID) [aCoder encodeObject:__queueUID forKey:@"__queueUID"];
    if(__uploadedAssetUID) [aCoder encodeObject:__uploadedAssetUID forKey:@"__uploadedAssetUID"];
    if(__assetType) [aCoder encodeObject:__assetType forKey:@"__assetType"];
    if(__assetURL) [aCoder encodeObject:__assetURL forKey:@"__assetURL"];
    if(__assetUID) [aCoder encodeObject:__assetUID forKey:@"__assetUID"];
    if(__uploadedAssetURL) [aCoder encodeObject:__uploadedAssetURL forKey:@"__uploadedAssetURL"];
    if(__uploadedAssetId) [aCoder encodeObject:__uploadedAssetId forKey:@"__uploadedAssetId"];
    if(__uploadDestinationId) [aCoder encodeObject:__uploadDestinationId forKey:@"__uploadDestinationId"];
    if(__uploadDestinationName) [aCoder encodeObject:__uploadDestinationName forKey:@"__uploadDestinationName"];
    if(__uploadDestinationURL) [aCoder encodeObject:__uploadDestinationURL forKey:@"__uploadDestinationURL"];
    if(__assetName) [aCoder encodeObject:__assetName forKey:@"__assetName"];
    if(__thumbnail) [aCoder encodeObject:__thumbnail forKey:@"__thumbnail"];
    if(__uploadedDate) [aCoder encodeObject:__uploadedDate forKey:@"__uploadedDate"];
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
        __queueUID = FLReturnRetained([aDecoder decodeObjectForKey:@"__queueUID"]);
        __uploadedAssetUID = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedAssetUID"]);
        __assetType = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetType"]);
        __assetURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetURL"]);
        __assetUID = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetUID"]);
        __uploadedAssetURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedAssetURL"]);
        __uploadedAssetId = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedAssetId"]);
        __uploadDestinationId = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationId"]);
        __uploadDestinationName = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationName"]);
        __uploadDestinationURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationURL"]);
        __assetName = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetName"]);
        __thumbnail = FLReturnRetained([aDecoder decodeObjectForKey:@"__thumbnail"]);
        __uploadedDate = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedDate"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"queueUID" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"queueUID"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedAssetUID" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"uploadedAssetUID"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetType" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"assetType"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetUID" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetUID"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedAssetURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadedAssetURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedAssetId" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"uploadedAssetId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationId" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"uploadDestinationId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadDestinationName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadDestinationURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"thumbnail" propertyClass:[UIImage class] propertyType:FLDataTypeObject] forPropertyName:@"thumbnail"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"uploadedDate"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"queueUID" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"queueUID" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetUID" columnType:FLSqliteTypeInteger columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetType" columnType:FLSqliteTypeInteger columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"assetType" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"assetURL" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetUID" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetURL" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetId" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationId" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationName" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationURL" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetName" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"thumbnail" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedDate" columnType:FLSqliteTypeDate columnConstraints:nil]];
    });
    return s_table;
}

+ (FLUploadedAsset*) uploadedAsset
{
    return FLReturnAutoreleased([[FLUploadedAsset alloc] init]);
}

@end

@implementation FLUploadedAsset (ValueProperties) 

- (int) uploadedAssetUIDValue
{
    return [self.uploadedAssetUID intValue];
}

- (void) setUploadedAssetUIDValue:(int) value
{
    self.uploadedAssetUID = [NSNumber numberWithInt:value];
}

- (int) assetTypeValue
{
    return [self.assetType intValue];
}

- (void) setAssetTypeValue:(int) value
{
    self.assetType = [NSNumber numberWithInt:value];
}

- (long) uploadedAssetIdValue
{
    return [self.uploadedAssetId longValue];
}

- (void) setUploadedAssetIdValue:(long) value
{
    self.uploadedAssetId = [NSNumber numberWithLong:value];
}

- (long) uploadDestinationIdValue
{
    return [self.uploadDestinationId longValue];
}

- (void) setUploadDestinationIdValue:(long) value
{
    self.uploadDestinationId = [NSNumber numberWithLong:value];
}
@end

// [/Generated]
