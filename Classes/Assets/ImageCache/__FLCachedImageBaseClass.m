// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLCachedImageBaseClass.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLCachedImageBaseClass.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLCachedImageBaseClass


@synthesize canCacheInMemory = __canCacheInMemory;
@synthesize fileName = __fileName;
@synthesize host = __host;
@synthesize imageId = __imageId;
@synthesize imageVersion = __imageVersion;
@synthesize photoUrl = __photoUrl;
@synthesize url = __url;

+ (NSString*) canCacheInMemoryKey
{
    return @"canCacheInMemory";
}

+ (NSString*) fileNameKey
{
    return @"fileName";
}

+ (NSString*) hostKey
{
    return @"host";
}

+ (NSString*) imageIdKey
{
    return @"imageId";
}

+ (NSString*) imageVersionKey
{
    return @"imageVersion";
}

+ (NSString*) photoUrlKey
{
    return @"photoUrl";
}

+ (NSString*) urlKey
{
    return @"url";
}

+ (FLCachedImageBaseClass*) cachedImageBaseClass
{
    return FLReturnAutoreleased([[FLCachedImageBaseClass alloc] init]);
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLCachedImageBaseClass*)object).imageId = FLCopyOrRetainObject(__imageId);
    ((FLCachedImageBaseClass*)object).imageVersion = FLCopyOrRetainObject(__imageVersion);
    ((FLCachedImageBaseClass*)object).fileName = FLCopyOrRetainObject(__fileName);
    ((FLCachedImageBaseClass*)object).host = FLCopyOrRetainObject(__host);
    ((FLCachedImageBaseClass*)object).photoUrl = FLCopyOrRetainObject(__photoUrl);
    ((FLCachedImageBaseClass*)object).canCacheInMemory = FLCopyOrRetainObject(__canCacheInMemory);
    ((FLCachedImageBaseClass*)object).url = FLCopyOrRetainObject(__url);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__fileName);
    FLRelease(__url);
    FLRelease(__imageId);
    FLRelease(__photoUrl);
    FLRelease(__host);
    FLRelease(__imageVersion);
    FLRelease(__canCacheInMemory);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__fileName) [aCoder encodeObject:__fileName forKey:@"__fileName"];
    if(__url) [aCoder encodeObject:__url forKey:@"__url"];
    if(__imageId) [aCoder encodeObject:__imageId forKey:@"__imageId"];
    if(__photoUrl) [aCoder encodeObject:__photoUrl forKey:@"__photoUrl"];
    if(__host) [aCoder encodeObject:__host forKey:@"__host"];
    if(__imageVersion) [aCoder encodeObject:__imageVersion forKey:@"__imageVersion"];
    if(__canCacheInMemory) [aCoder encodeObject:__canCacheInMemory forKey:@"__canCacheInMemory"];
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
        __fileName = FLReturnRetained([aDecoder decodeObjectForKey:@"__fileName"]);
        __url = FLReturnRetained([aDecoder decodeObjectForKey:@"__url"]);
        __imageId = FLReturnRetained([aDecoder decodeObjectForKey:@"__imageId"]);
        __photoUrl = FLReturnRetained([aDecoder decodeObjectForKey:@"__photoUrl"]);
        __host = FLReturnRetained([aDecoder decodeObjectForKey:@"__host"]);
        __imageVersion = FLReturnRetained([aDecoder decodeObjectForKey:@"__imageVersion"]);
        __canCacheInMemory = FLReturnRetained([aDecoder decodeObjectForKey:@"__canCacheInMemory"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"fileName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"fileName"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"url" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"url"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"imageId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"imageId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoUrl" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"photoUrl"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"host" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"host"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"imageVersion" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"imageVersion"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"canCacheInMemory" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"canCacheInMemory"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"fileName" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"url" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"imageId" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"host" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLDatabaseColumn notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"host" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"imageVersion" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"canCacheInMemory" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLCachedImageBaseClass (ValueProperties) 

- (BOOL) canCacheInMemoryValue
{
    return [self.canCacheInMemory boolValue];
}

- (void) setCanCacheInMemoryValue:(BOOL) value
{
    self.canCacheInMemory = [NSNumber numberWithBool:value];
}
@end

// [/Generated]
