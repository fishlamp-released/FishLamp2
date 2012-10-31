// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookAlbum.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookAlbum.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookAlbum


@synthesize count = __count;
@synthesize cover_photo = __cover_photo;
@synthesize created_time = __created_time;
@synthesize description = __description;
@synthesize from = __from;
@synthesize link = __link;
@synthesize location = __location;
@synthesize privacy = __privacy;
@synthesize type = __type;
@synthesize updated_time = __updated_time;

+ (NSString*) countKey
{
    return @"count";
}

+ (NSString*) cover_photoKey
{
    return @"cover_photo";
}

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) locationKey
{
    return @"location";
}

+ (NSString*) privacyKey
{
    return @"privacy";
}

+ (NSString*) typeKey
{
    return @"type";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookAlbum*)object).location = FLCopyOrRetainObject(__location);
    ((FLFacebookAlbum*)object).cover_photo = FLCopyOrRetainObject(__cover_photo);
    ((FLFacebookAlbum*)object).from = FLCopyOrRetainObject(__from);
    ((FLFacebookAlbum*)object).privacy = FLCopyOrRetainObject(__privacy);
    ((FLFacebookAlbum*)object).count = FLCopyOrRetainObject(__count);
    ((FLFacebookAlbum*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookAlbum*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookAlbum*)object).description = FLCopyOrRetainObject(__description);
    ((FLFacebookAlbum*)object).type = FLCopyOrRetainObject(__type);
    ((FLFacebookAlbum*)object).created_time = FLCopyOrRetainObject(__created_time);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    mrc_release_(__description);
    mrc_release_(__from);
    mrc_release_(__location);
    mrc_release_(__link);
    mrc_release_(__cover_photo);
    mrc_release_(__privacy);
    mrc_release_(__count);
    mrc_release_(__type);
    mrc_release_(__created_time);
    mrc_release_(__updated_time);
    mrc_super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__location) [aCoder encodeObject:__location forKey:@"__location"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__cover_photo) [aCoder encodeObject:__cover_photo forKey:@"__cover_photo"];
    if(__privacy) [aCoder encodeObject:__privacy forKey:@"__privacy"];
    if(__count) [aCoder encodeObject:__count forKey:@"__count"];
    if(__type) [aCoder encodeObject:__type forKey:@"__type"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookAlbum*) facebookAlbum
{
    return autorelease_([[FLFacebookAlbum alloc] init]);
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
        __description = retain_([aDecoder decodeObjectForKey:@"__description"]);
        __from = retain_([aDecoder decodeObjectForKey:@"__from"]);
        __location = retain_([aDecoder decodeObjectForKey:@"__location"]);
        __link = retain_([aDecoder decodeObjectForKey:@"__link"]);
        __cover_photo = retain_([aDecoder decodeObjectForKey:@"__cover_photo"]);
        __privacy = retain_([aDecoder decodeObjectForKey:@"__privacy"]);
        __count = retain_([aDecoder decodeObjectForKey:@"__count"]);
        __type = retain_([aDecoder decodeObjectForKey:@"__type"]);
        __created_time = retain_([aDecoder decodeObjectForKey:@"__created_time"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"description"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"from" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"from"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"location"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"link"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"cover_photo" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"cover_photo"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"privacy" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"privacy"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"count" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"count"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"type"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"created_time"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"location" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"cover_photo" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"privacy" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"count" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookAlbum (ValueProperties) 
@end

// [/Generated]
