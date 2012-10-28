// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLLastUpdateTime.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLLastUpdateTime.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLLastUpdateTime


@synthesize lastUpdate = __lastUpdate;
@synthesize lastUpdateId = __lastUpdateId;

+ (NSString*) lastUpdateIdKey
{
    return @"lastUpdateId";
}

+ (NSString*) lastUpdateKey
{
    return @"lastUpdate";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLLastUpdateTime*)object).lastUpdateId = FLCopyOrRetainObject(__lastUpdateId);
    ((FLLastUpdateTime*)object).lastUpdate = FLCopyOrRetainObject(__lastUpdate);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__lastUpdateId);
    FLRelease(__lastUpdate);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__lastUpdateId) [aCoder encodeObject:__lastUpdateId forKey:@"__lastUpdateId"];
    if(__lastUpdate) [aCoder encodeObject:__lastUpdate forKey:@"__lastUpdate"];
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
        __lastUpdateId = FLReturnRetained([aDecoder decodeObjectForKey:@"__lastUpdateId"]);
        __lastUpdate = FLReturnRetained([aDecoder decodeObjectForKey:@"__lastUpdate"]);
    }
    return self;
}

+ (FLLastUpdateTime*) lastUpdateTime
{
    return FLReturnAutoreleased([[FLLastUpdateTime alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"lastUpdateId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"lastUpdateId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"lastUpdate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"lastUpdate"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastUpdateId" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastUpdate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLLastUpdateTime (ValueProperties) 
@end

// [/Generated]
