// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLUploadedAsset.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLUploadedAsset.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

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
        __queueUID = FLRetain([aDecoder decodeObjectForKey:@"__queueUID"]);
        __uploadedAssetUID = FLRetain([aDecoder decodeObjectForKey:@"__uploadedAssetUID"]);
        __assetType = FLRetain([aDecoder decodeObjectForKey:@"__assetType"]);
        __assetURL = FLRetain([aDecoder decodeObjectForKey:@"__assetURL"]);
        __assetUID = FLRetain([aDecoder decodeObjectForKey:@"__assetUID"]);
        __uploadedAssetURL = FLRetain([aDecoder decodeObjectForKey:@"__uploadedAssetURL"]);
        __uploadedAssetId = FLRetain([aDecoder decodeObjectForKey:@"__uploadedAssetId"]);
        __uploadDestinationId = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationId"]);
        __uploadDestinationName = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationName"]);
        __uploadDestinationURL = FLRetain([aDecoder decodeObjectForKey:@"__uploadDestinationURL"]);
        __assetName = FLRetain([aDecoder decodeObjectForKey:@"__assetName"]);
        __thumbnail = FLRetain([aDecoder decodeObjectForKey:@"__thumbnail"]);
        __uploadedDate = FLRetain([aDecoder decodeObjectForKey:@"__uploadedDate"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLLegacyObjectDescriber* describer = [FLLegacyObjectDescriber registerClass:[self class]];
        
        

        [describer addPropertyWithName:@"queueUID" withClass:[NSString class]];
        [describer addPropertyWithName:@"uploadedAssetUID" withClass:[NSString class]];
        [describer addPropertyWithName:@"assetType" withClass:[FLIntegerNumber class] ];
        [describer addPropertyWithName:@"assetURL" withClass:[NSString class]];
        [describer addPropertyWithName:@"assetUID" withClass:[NSString class]];
        [describer addPropertyWithName:@"uploadedAssetURL" withClass:[NSString class]];
        [describer addPropertyWithName:@"uploadedAssetId" withClass:[FLLongNumber class] ];
        [describer addPropertyWithName:@"uploadDestinationId" withClass:[FLLongNumber class] ];
        [describer addPropertyWithName:@"uploadDestinationName" withClass:[NSString class]];
        [describer addPropertyWithName:@"uploadDestinationURL" withClass:[NSString class]];
        [describer addPropertyWithName:@"assetName" withClass:[NSString class]];
        [describer addPropertyWithName:@"thumbnail" withClass:[SDKImage class]];
        [describer addPropertyWithName:@"uploadedDate" withClass:[NSDate class]];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"queueUID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"queueUID" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedAssetUID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetType" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"assetType" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetURL" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"assetURL" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetUID" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedAssetURL" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedAssetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadDestinationURL" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"thumbnail" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uploadedDate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

+ (FLUploadedAsset*) uploadedAsset
{
    return FLAutorelease([[FLUploadedAsset alloc] init]);
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