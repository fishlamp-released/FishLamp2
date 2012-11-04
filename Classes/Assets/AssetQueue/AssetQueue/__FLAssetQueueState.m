// [Generated]
//
// This file was generated at 6/18/12 2:02 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLAssetQueueState.m
// Project: FishLamp Mobile
// Schema: AssetQueueObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLAssetQueueState.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLAssetQueueState


@synthesize firstQueuePosition = __firstQueuePosition;
@synthesize lastQueuePosition = __lastQueuePosition;
@synthesize queueUID = __queueUID;
@synthesize sortOrder = __sortOrder;
@synthesize totalAssetsAdded = __totalAssetsAdded;

+ (NSString*) firstQueuePositionKey
{
    return @"firstQueuePosition";
}

+ (NSString*) lastQueuePositionKey
{
    return @"lastQueuePosition";
}

+ (NSString*) queueUIDKey
{
    return @"queueUID";
}

+ (NSString*) sortOrderKey
{
    return @"sortOrder";
}

+ (NSString*) totalAssetsAddedKey
{
    return @"totalAssetsAdded";
}

+ (FLAssetQueueState*) assetQueueState
{
    return autorelease_([[FLAssetQueueState alloc] init]);
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLAssetQueueState*)object).firstQueuePosition = FLCopyOrRetainObject(__firstQueuePosition);
    ((FLAssetQueueState*)object).totalAssetsAdded = FLCopyOrRetainObject(__totalAssetsAdded);
    ((FLAssetQueueState*)object).queueUID = FLCopyOrRetainObject(__queueUID);
    ((FLAssetQueueState*)object).sortOrder = FLCopyOrRetainObject(__sortOrder);
    ((FLAssetQueueState*)object).lastQueuePosition = FLCopyOrRetainObject(__lastQueuePosition);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    release_(__queueUID);
    release_(__sortOrder);
    release_(__totalAssetsAdded);
    release_(__firstQueuePosition);
    release_(__lastQueuePosition);
    super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__queueUID) [aCoder encodeObject:__queueUID forKey:@"__queueUID"];
    if(__sortOrder) [aCoder encodeObject:__sortOrder forKey:@"__sortOrder"];
    if(__totalAssetsAdded) [aCoder encodeObject:__totalAssetsAdded forKey:@"__totalAssetsAdded"];
    if(__firstQueuePosition) [aCoder encodeObject:__firstQueuePosition forKey:@"__firstQueuePosition"];
    if(__lastQueuePosition) [aCoder encodeObject:__lastQueuePosition forKey:@"__lastQueuePosition"];
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
        __queueUID = retain_([aDecoder decodeObjectForKey:@"__queueUID"]);
        __sortOrder = retain_([aDecoder decodeObjectForKey:@"__sortOrder"]);
        __totalAssetsAdded = retain_([aDecoder decodeObjectForKey:@"__totalAssetsAdded"]);
        __firstQueuePosition = retain_([aDecoder decodeObjectForKey:@"__firstQueuePosition"]);
        __lastQueuePosition = retain_([aDecoder decodeObjectForKey:@"__lastQueuePosition"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"sortOrder" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"sortOrder"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"totalAssetsAdded" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"totalAssetsAdded"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"firstQueuePosition" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"firstQueuePosition"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"lastQueuePosition" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"lastQueuePosition"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"queueUID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sortOrder" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"totalAssetsAdded" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"firstQueuePosition" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastQueuePosition" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLAssetQueueState (ValueProperties) 

- (int) sortOrderValue
{
    return [self.sortOrder intValue];
}

- (void) setSortOrderValue:(int) value
{
    self.sortOrder = [NSNumber numberWithInt:value];
}

- (long) totalAssetsAddedValue
{
    return [self.totalAssetsAdded longValue];
}

- (void) setTotalAssetsAddedValue:(long) value
{
    self.totalAssetsAdded = [NSNumber numberWithLong:value];
}

- (int) firstQueuePositionValue
{
    return [self.firstQueuePosition intValue];
}

- (void) setFirstQueuePositionValue:(int) value
{
    self.firstQueuePosition = [NSNumber numberWithInt:value];
}

- (int) lastQueuePositionValue
{
    return [self.lastQueuePosition intValue];
}

- (void) setLastQueuePositionValue:(int) value
{
    self.lastQueuePosition = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
