// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLTwitterStatusUpdate.m
// Project: FishLamp
// Schema: Twitter
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTwitterStatusUpdate.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLTwitterStatusUpdate


@synthesize display_coordinates = __display_coordinates;
@synthesize in_reply_to_status_id = __in_reply_to_status_id;
@synthesize include_entities = __include_entities;
@synthesize place_id = __place_id;
@synthesize status = __status;
@synthesize trim_user = __trim_user;

+ (NSString*) display_coordinatesKey
{
    return @"display_coordinates";
}

+ (NSString*) in_reply_to_status_idKey
{
    return @"in_reply_to_status_id";
}

+ (NSString*) include_entitiesKey
{
    return @"include_entities";
}

+ (NSString*) place_idKey
{
    return @"place_id";
}

+ (NSString*) statusKey
{
    return @"status";
}

+ (NSString*) trim_userKey
{
    return @"trim_user";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLTwitterStatusUpdate*)object).status = FLCopyOrRetainObject(__status);
    ((FLTwitterStatusUpdate*)object).include_entities = FLCopyOrRetainObject(__include_entities);
    ((FLTwitterStatusUpdate*)object).in_reply_to_status_id = FLCopyOrRetainObject(__in_reply_to_status_id);
    ((FLTwitterStatusUpdate*)object).place_id = FLCopyOrRetainObject(__place_id);
    ((FLTwitterStatusUpdate*)object).display_coordinates = FLCopyOrRetainObject(__display_coordinates);
    ((FLTwitterStatusUpdate*)object).trim_user = FLCopyOrRetainObject(__trim_user);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__status);
    FLRelease(__in_reply_to_status_id);
    FLRelease(__place_id);
    FLRelease(__display_coordinates);
    FLRelease(__trim_user);
    FLRelease(__include_entities);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__status) [aCoder encodeObject:__status forKey:@"__status"];
    if(__in_reply_to_status_id) [aCoder encodeObject:__in_reply_to_status_id forKey:@"__in_reply_to_status_id"];
    if(__place_id) [aCoder encodeObject:__place_id forKey:@"__place_id"];
    if(__display_coordinates) [aCoder encodeObject:__display_coordinates forKey:@"__display_coordinates"];
    if(__trim_user) [aCoder encodeObject:__trim_user forKey:@"__trim_user"];
    if(__include_entities) [aCoder encodeObject:__include_entities forKey:@"__include_entities"];
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
        __status = FLRetain([aDecoder decodeObjectForKey:@"__status"]);
        __in_reply_to_status_id = FLRetain([aDecoder decodeObjectForKey:@"__in_reply_to_status_id"]);
        __place_id = FLRetain([aDecoder decodeObjectForKey:@"__place_id"]);
        __display_coordinates = FLRetain([aDecoder decodeObjectForKey:@"__display_coordinates"]);
        __trim_user = FLRetain([aDecoder decodeObjectForKey:@"__trim_user"]);
        __include_entities = FLRetain([aDecoder decodeObjectForKey:@"__include_entities"]);
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
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"status" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"in_reply_to_status_id" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"place_id" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"display_coordinates" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"trim_user" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"include_entities" propertyClass:[NSString class] ] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"status" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"in_reply_to_status_id" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"place_id" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"display_coordinates" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"trim_user" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"include_entities" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

+ (FLTwitterStatusUpdate*) twitterStatusUpdate
{
    return FLAutorelease([[FLTwitterStatusUpdate alloc] init]);
}

@end

@implementation FLTwitterStatusUpdate (ValueProperties) 
@end

// [/Generated]
