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
    return FLAutorelease([[FLAssetQueueState alloc] init]);
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
    FLRelease(__queueUID);
    FLRelease(__sortOrder);
    FLRelease(__totalAssetsAdded);
    FLRelease(__firstQueuePosition);
    FLRelease(__lastQueuePosition);
    FLSuperDealloc();
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
        __queueUID = FLRetain([aDecoder decodeObjectForKey:@"__queueUID"]);
        __sortOrder = FLRetain([aDecoder decodeObjectForKey:@"__sortOrder"]);
        __totalAssetsAdded = FLRetain([aDecoder decodeObjectForKey:@"__totalAssetsAdded"]);
        __firstQueuePosition = FLRetain([aDecoder decodeObjectForKey:@"__firstQueuePosition"]);
        __lastQueuePosition = FLRetain([aDecoder decodeObjectForKey:@"__lastQueuePosition"]);
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
        [s_describer addProperty:@"queueUID" withClass:[NSString class]];
        [s_describer addProperty:@"sortOrder" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"totalAssetsAdded" withClass:[FLLongNumber class] ];
        [s_describer addProperty:@"firstQueuePosition" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"lastQueuePosition" withClass:[FLIntegerNumber class] ];
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
