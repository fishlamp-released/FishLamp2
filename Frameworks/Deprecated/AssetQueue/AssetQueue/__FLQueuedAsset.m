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

#import "FLDatabaseTable.h"

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
        __queueUID = FLRetain([aDecoder decodeObjectForKey:@"__queueUID"]);
        __assetUID = FLRetain([aDecoder decodeObjectForKey:@"__assetUID"]);
        __assetURL = FLRetain([aDecoder decodeObjectForKey:@"__assetURL"]);
        __assetType = FLRetain([aDecoder decodeObjectForKey:@"__assetType"]);
        __positionInQueue = FLRetain([aDecoder decodeObjectForKey:@"__positionInQueue"]);
        __assetState = FLRetain([aDecoder decodeObjectForKey:@"__assetState"]);
        __queuedDate = FLRetain([aDecoder decodeObjectForKey:@"__queuedDate"]);
        __createdDate = FLRetain([aDecoder decodeObjectForKey:@"__createdDate"]);
        __modifiedDate = FLRetain([aDecoder decodeObjectForKey:@"__modifiedDate"]);
        __uploadedAssetURL = FLRetain([aDecoder decodeObjectForKey:@"__uploadedAssetURL"]);
        __uploadedAssetId = FLRetain([aDecoder decodeObjectForKey:@"__uploadedAssetId"]);
        __uploadDestinationId = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationId"]);
        __uploadDestinationName = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationName"]);
        __uploadDestinationURL = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationURL"]);
        __assetSize = FLRetain([aDecoder decodeObjectForKey:@"__assetSize"]);
        __assetName = FLRetain([aDecoder decodeObjectForKey:@"__assetName"]);
        __assetDescription = FLRetain([aDecoder decodeObjectForKey:@"__assetDescription"]);
        __assetFileName = FLRetain([aDecoder decodeObjectForKey:@"__assetFileName"]);
        __copyright = FLRetain([aDecoder decodeObjectForKey:@"__copyright"]);
        __keywords = [[aDecoder decodeObjectForKey:@"__keywords"] mutableCopy];
        __assetObject = FLRetain([aDecoder decodeObjectForKey:@"__assetObject"]);
    }
    return self;
}

+ (FLQueuedAsset*) queuedAsset
{
    return FLAutorelease([[FLQueuedAsset alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addChildDescriberWithName:@"queueUID" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetUID" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetURL" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetType" withClass:[FLIntegerNumber class] ];
        [s_describer addChildDescriberWithName:@"positionInQueue" withClass:[FLIntegerNumber class] ];
        [s_describer addChildDescriberWithName:@"assetState" withClass:[FLIntegerNumber class] ];
        [s_describer addChildDescriberWithName:@"queuedDate" withClass:[NSDate class]];
        [s_describer addChildDescriberWithName:@"createdDate" withClass:[NSDate class]];
        [s_describer addChildDescriberWithName:@"modifiedDate" withClass:[NSDate class]];
        [s_describer addChildDescriberWithName:@"uploadedAssetURL" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"uploadedAssetId" withClass:[FLLongNumber class] ];
        [s_describer addChildDescriberWithName:@"uploadDestinationId" withClass:[FLLongNumber class] ];
        [s_describer addChildDescriberWithName:@"uploadDestinationName" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"uploadDestinationURL" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetSize" withClass:[FLLongNumber class] ];
        [s_describer addChildDescriberWithName:@"assetName" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetDescription" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"assetFileName" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"copyright" withClass:[NSString class]];
        [s_describer addChildDescriberWithName:@"keywords" withClass:[NSMutableArray class]];
        [s_describer addChildDescriberWithName:@"assetObject" withClass:[FLAsset class]];
    });
    return s_describer;
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"queueUID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"queueUID" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetUID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetURL" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"assetURL" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetType" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"assetType" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"positionInQueue" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"positionInQueue" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetState" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"queuedDate" columnType:FLDatabaseTypeDate columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"queuedDate" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"createdDate" columnType:FLDatabaseTypeDate columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"createdDate" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"modifiedDate" columnType:FLDatabaseTypeDate columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"modifiedDate" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedAssetURL" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedAssetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationURL" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetDescription" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetFileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"copyright" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"keywords" columnType:FLDatabaseTypeObject columnConstraints:nil]];
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
