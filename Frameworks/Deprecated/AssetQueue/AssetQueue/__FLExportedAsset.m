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

#import "FLDatabaseTable.h"

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
    return FLAutorelease([[FLExportedAsset alloc] init]);
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
        __originalID = FLRetain([aDecoder decodeObjectForKey:@"__originalID"]);
        __assetURL = FLRetain([aDecoder decodeObjectForKey:@"__assetURL"]);
        __exportedDate = FLRetain([aDecoder decodeObjectForKey:@"__exportedDate"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLLegacyObjectDescriber* describer = [FLLegacyObjectDescriber registerClass:[self class]];
        
        

        [describer addPropertyWithName:@"originalID" withClass:[NSString class]];
        [describer addPropertyWithName:@"assetURL" withClass:[NSString class]];
        [describer addPropertyWithName:@"exportedDate" withClass:[NSDate class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"originalID" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"originalID" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"assetURL" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"assetURL" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"exportedDate" columnType:FLDatabaseTypeDate columnConstraints:[NSArray arrayWithObjects:[FLNotNullConstraint notNullConstraint], nil]]];
    });
    return s_table;
}

@end

@implementation FLExportedAsset (ValueProperties) 
@end

// [/Generated]
