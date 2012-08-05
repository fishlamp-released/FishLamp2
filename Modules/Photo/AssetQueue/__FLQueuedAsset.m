// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLQueuedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLQueuedAsset.h"
#import "FLAsset.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLQueuedAsset


@synthesize assetDescription = __assetDescription;
@synthesize assetFileName = __assetFileName;
@synthesize assetName = __assetName;
@synthesize assetObject = __assetObject;
@synthesize assetSize = __assetSize;
@synthesize assetState = __assetState;
@synthesize assetType = __assetType;
@synthesize assetUID = __assetUID;
@synthesize assetURL = __assetURL;
@synthesize copyright = __copyright;
@synthesize createdDate = __createdDate;
@synthesize keywords = __keywords;
@synthesize modifiedDate = __modifiedDate;
@synthesize positionInQueue = __positionInQueue;
@synthesize queueUID = __queueUID;
@synthesize queuedDate = __queuedDate;
@synthesize uploadDestinationId = __uploadDestinationId;
@synthesize uploadDestinationName = __uploadDestinationName;
@synthesize uploadDestinationURL = __uploadDestinationURL;
@synthesize uploadedAssetId = __uploadedAssetId;
@synthesize uploadedAssetURL = __uploadedAssetURL;

+ (NSString*) assetDescriptionKey
{
    return @"assetDescription";
}

+ (NSString*) assetFileNameKey
{
    return @"assetFileName";
}

+ (NSString*) assetNameKey
{
    return @"assetName";
}

+ (NSString*) assetObjectKey
{
    return @"assetObject";
}

+ (NSString*) assetSizeKey
{
    return @"assetSize";
}

+ (NSString*) assetStateKey
{
    return @"assetState";
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

+ (NSString*) copyrightKey
{
    return @"copyright";
}

+ (NSString*) createdDateKey
{
    return @"createdDate";
}

+ (NSString*) keywordsKey
{
    return @"keywords";
}

+ (NSString*) modifiedDateKey
{
    return @"modifiedDate";
}

+ (NSString*) positionInQueueKey
{
    return @"positionInQueue";
}

+ (NSString*) queueUIDKey
{
    return @"queueUID";
}

+ (NSString*) queuedDateKey
{
    return @"queuedDate";
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

+ (NSString*) uploadedAssetURLKey
{
    return @"uploadedAssetURL";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLQueuedAsset*)object).assetObject = FLCopyOrRetainObject(__assetObject);
    ((FLQueuedAsset*)object).queueUID = FLCopyOrRetainObject(__queueUID);
    ((FLQueuedAsset*)object).assetState = FLCopyOrRetainObject(__assetState);
    ((FLQueuedAsset*)object).assetFileName = FLCopyOrRetainObject(__assetFileName);
    ((FLQueuedAsset*)object).positionInQueue = FLCopyOrRetainObject(__positionInQueue);
    ((FLQueuedAsset*)object).uploadDestinationId = FLCopyOrRetainObject(__uploadDestinationId);
    ((FLQueuedAsset*)object).uploadDestinationName = FLCopyOrRetainObject(__uploadDestinationName);
    ((FLQueuedAsset*)object).keywords = FLCopyOrRetainObject(__keywords);
    ((FLQueuedAsset*)object).assetType = FLCopyOrRetainObject(__assetType);
    ((FLQueuedAsset*)object).uploadedAssetId = FLCopyOrRetainObject(__uploadedAssetId);
    ((FLQueuedAsset*)object).assetSize = FLCopyOrRetainObject(__assetSize);
    ((FLQueuedAsset*)object).modifiedDate = FLCopyOrRetainObject(__modifiedDate);
    ((FLQueuedAsset*)object).queuedDate = FLCopyOrRetainObject(__queuedDate);
    ((FLQueuedAsset*)object).assetDescription = FLCopyOrRetainObject(__assetDescription);
    ((FLQueuedAsset*)object).assetURL = FLCopyOrRetainObject(__assetURL);
    ((FLQueuedAsset*)object).createdDate = FLCopyOrRetainObject(__createdDate);
    ((FLQueuedAsset*)object).uploadedAssetURL = FLCopyOrRetainObject(__uploadedAssetURL);
    ((FLQueuedAsset*)object).assetName = FLCopyOrRetainObject(__assetName);
    ((FLQueuedAsset*)object).uploadDestinationURL = FLCopyOrRetainObject(__uploadDestinationURL);
    ((FLQueuedAsset*)object).copyright = FLCopyOrRetainObject(__copyright);
    ((FLQueuedAsset*)object).assetUID = FLCopyOrRetainObject(__assetUID);
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
    FLRelease(__assetUID);
    FLRelease(__assetURL);
    FLRelease(__assetType);
    FLRelease(__positionInQueue);
    FLRelease(__assetState);
    FLRelease(__queuedDate);
    FLRelease(__createdDate);
    FLRelease(__modifiedDate);
    FLRelease(__uploadedAssetURL);
    FLRelease(__uploadedAssetId);
    FLRelease(__uploadDestinationId);
    FLRelease(__uploadDestinationName);
    FLRelease(__uploadDestinationURL);
    FLRelease(__assetSize);
    FLRelease(__assetName);
    FLRelease(__assetDescription);
    FLRelease(__assetFileName);
    FLRelease(__copyright);
    FLRelease(__keywords);
    FLRelease(__assetObject);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__queueUID) [aCoder encodeObject:__queueUID forKey:@"__queueUID"];
    if(__assetUID) [aCoder encodeObject:__assetUID forKey:@"__assetUID"];
    if(__assetURL) [aCoder encodeObject:__assetURL forKey:@"__assetURL"];
    if(__assetType) [aCoder encodeObject:__assetType forKey:@"__assetType"];
    if(__positionInQueue) [aCoder encodeObject:__positionInQueue forKey:@"__positionInQueue"];
    if(__assetState) [aCoder encodeObject:__assetState forKey:@"__assetState"];
    if(__queuedDate) [aCoder encodeObject:__queuedDate forKey:@"__queuedDate"];
    if(__createdDate) [aCoder encodeObject:__createdDate forKey:@"__createdDate"];
    if(__modifiedDate) [aCoder encodeObject:__modifiedDate forKey:@"__modifiedDate"];
    if(__uploadedAssetURL) [aCoder encodeObject:__uploadedAssetURL forKey:@"__uploadedAssetURL"];
    if(__uploadedAssetId) [aCoder encodeObject:__uploadedAssetId forKey:@"__uploadedAssetId"];
    if(__uploadDestinationId) [aCoder encodeObject:__uploadDestinationId forKey:@"__uploadDestinationId"];
    if(__uploadDestinationName) [aCoder encodeObject:__uploadDestinationName forKey:@"__uploadDestinationName"];
    if(__uploadDestinationURL) [aCoder encodeObject:__uploadDestinationURL forKey:@"__uploadDestinationURL"];
    if(__assetSize) [aCoder encodeObject:__assetSize forKey:@"__assetSize"];
    if(__assetName) [aCoder encodeObject:__assetName forKey:@"__assetName"];
    if(__assetDescription) [aCoder encodeObject:__assetDescription forKey:@"__assetDescription"];
    if(__assetFileName) [aCoder encodeObject:__assetFileName forKey:@"__assetFileName"];
    if(__copyright) [aCoder encodeObject:__copyright forKey:@"__copyright"];
    if(__keywords) [aCoder encodeObject:__keywords forKey:@"__keywords"];
    if(__assetObject) [aCoder encodeObject:__assetObject forKey:@"__assetObject"];
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
        __assetUID = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetUID"]);
        __assetURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetURL"]);
        __assetType = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetType"]);
        __positionInQueue = FLReturnRetained([aDecoder decodeObjectForKey:@"__positionInQueue"]);
        __assetState = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetState"]);
        __queuedDate = FLReturnRetained([aDecoder decodeObjectForKey:@"__queuedDate"]);
        __createdDate = FLReturnRetained([aDecoder decodeObjectForKey:@"__createdDate"]);
        __modifiedDate = FLReturnRetained([aDecoder decodeObjectForKey:@"__modifiedDate"]);
        __uploadedAssetURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedAssetURL"]);
        __uploadedAssetId = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadedAssetId"]);
        __uploadDestinationId = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationId"]);
        __uploadDestinationName = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationName"]);
        __uploadDestinationURL = FLReturnRetained([aDecoder decodeObjectForKey:@"__uploadDestinationURL"]);
        __assetSize = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetSize"]);
        __assetName = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetName"]);
        __assetDescription = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetDescription"]);
        __assetFileName = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetFileName"]);
        __copyright = FLReturnRetained([aDecoder decodeObjectForKey:@"__copyright"]);
        __keywords = [[aDecoder decodeObjectForKey:@"__keywords"] mutableCopy];
        __assetObject = FLReturnRetained([aDecoder decodeObjectForKey:@"__assetObject"]);
    }
    return self;
}

+ (FLQueuedAsset*) queuedAsset
{
    return FLReturnAutoreleased([[FLQueuedAsset alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetUID" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetUID"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetType" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"assetType"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"positionInQueue" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"positionInQueue"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetState" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"assetState"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"queuedDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"queuedDate"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"createdDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"createdDate"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"modifiedDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"modifiedDate"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedAssetURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadedAssetURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadedAssetId" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"uploadedAssetId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationId" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"uploadDestinationId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadDestinationName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"uploadDestinationURL" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"uploadDestinationURL"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetSize" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"assetSize"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetDescription" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetDescription"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetFileName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"assetFileName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"copyright" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"copyright"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"keywords" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject] forPropertyName:@"keywords"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"assetObject" propertyClass:[FLAsset class] propertyType:FLDataTypeObject] forPropertyName:@"assetObject"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetUID" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetURL" columnType:FLSqliteTypeText columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"assetURL" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetType" columnType:FLSqliteTypeInteger columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"assetType" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"positionInQueue" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"positionInQueue" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetState" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"queuedDate" columnType:FLSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"queuedDate" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"createdDate" columnType:FLSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"createdDate" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"modifiedDate" columnType:FLSqliteTypeDate columnConstraints:[NSArray arrayWithObjects:[FLSqliteColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLSqliteIndex sqliteIndex:@"modifiedDate" indexProperties:FLSqliteColumnIndexPropertyNone]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetURL" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadedAssetId" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationId" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationName" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"uploadDestinationURL" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetSize" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetName" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetDescription" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"assetFileName" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"copyright" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"keywords" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLQueuedAsset (ValueProperties) 

- (int) assetTypeValue
{
    return [self.assetType intValue];
}

- (void) setAssetTypeValue:(int) value
{
    self.assetType = [NSNumber numberWithInt:value];
}

- (int) positionInQueueValue
{
    return [self.positionInQueue intValue];
}

- (void) setPositionInQueueValue:(int) value
{
    self.positionInQueue = [NSNumber numberWithInt:value];
}

- (int) assetStateValue
{
    return [self.assetState intValue];
}

- (void) setAssetStateValue:(int) value
{
    self.assetState = [NSNumber numberWithInt:value];
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

- (long) assetSizeValue
{
    return [self.assetSize longValue];
}

- (void) setAssetSizeValue:(long) value
{
    self.assetSize = [NSNumber numberWithLong:value];
}
@end

// [/Generated]
