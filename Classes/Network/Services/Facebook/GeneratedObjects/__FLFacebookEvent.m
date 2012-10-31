// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookEvent.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookEvent.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookEvent


@synthesize description = __description;
@synthesize end_time = __end_time;
@synthesize location = __location;
@synthesize owner = __owner;
@synthesize privacy = __privacy;
@synthesize start_time = __start_time;
@synthesize updated_time = __updated_time;
@synthesize venue = __venue;

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) end_timeKey
{
    return @"end_time";
}

+ (NSString*) locationKey
{
    return @"location";
}

+ (NSString*) ownerKey
{
    return @"owner";
}

+ (NSString*) privacyKey
{
    return @"privacy";
}

+ (NSString*) start_timeKey
{
    return @"start_time";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

+ (NSString*) venueKey
{
    return @"venue";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookEvent*)object).location = FLCopyOrRetainObject(__location);
    ((FLFacebookEvent*)object).owner = FLCopyOrRetainObject(__owner);
    ((FLFacebookEvent*)object).venue = FLCopyOrRetainObject(__venue);
    ((FLFacebookEvent*)object).end_time = FLCopyOrRetainObject(__end_time);
    ((FLFacebookEvent*)object).privacy = FLCopyOrRetainObject(__privacy);
    ((FLFacebookEvent*)object).start_time = FLCopyOrRetainObject(__start_time);
    ((FLFacebookEvent*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookEvent*)object).description = FLCopyOrRetainObject(__description);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    mrc_release_(__owner);
    mrc_release_(__description);
    mrc_release_(__start_time);
    mrc_release_(__end_time);
    mrc_release_(__location);
    mrc_release_(__venue);
    mrc_release_(__privacy);
    mrc_release_(__updated_time);
    mrc_super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__owner) [aCoder encodeObject:__owner forKey:@"__owner"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__start_time) [aCoder encodeObject:__start_time forKey:@"__start_time"];
    if(__end_time) [aCoder encodeObject:__end_time forKey:@"__end_time"];
    if(__location) [aCoder encodeObject:__location forKey:@"__location"];
    if(__venue) [aCoder encodeObject:__venue forKey:@"__venue"];
    if(__privacy) [aCoder encodeObject:__privacy forKey:@"__privacy"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookEvent*) facebookEvent
{
    return autorelease_([[FLFacebookEvent alloc] init]);
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
    if((self = [super initWithCoder:aDecoder]))
    {
        __owner = retain_([aDecoder decodeObjectForKey:@"__owner"]);
        __description = retain_([aDecoder decodeObjectForKey:@"__description"]);
        __start_time = retain_([aDecoder decodeObjectForKey:@"__start_time"]);
        __end_time = retain_([aDecoder decodeObjectForKey:@"__end_time"]);
        __location = retain_([aDecoder decodeObjectForKey:@"__location"]);
        __venue = retain_([aDecoder decodeObjectForKey:@"__venue"]);
        __privacy = retain_([aDecoder decodeObjectForKey:@"__privacy"]);
        __updated_time = retain_([aDecoder decodeObjectForKey:@"__updated_time"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"owner" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"owner"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"description"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"start_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"start_time"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"end_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"end_time"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"location"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"venue" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"venue"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"privacy" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"privacy"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"updated_time"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"owner" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"start_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"end_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"location" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"venue" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"privacy" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookEvent (ValueProperties) 
@end

// [/Generated]
