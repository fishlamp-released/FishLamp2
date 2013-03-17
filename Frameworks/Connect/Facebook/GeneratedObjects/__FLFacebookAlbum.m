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
    FLRelease(__description);
    FLRelease(__from);
    FLRelease(__location);
    FLRelease(__link);
    FLRelease(__cover_photo);
    FLRelease(__privacy);
    FLRelease(__count);
    FLRelease(__type);
    FLRelease(__created_time);
    FLRelease(__updated_time);
    FLSuperDealloc();
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
    return FLAutorelease([[FLFacebookAlbum alloc] init]);
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
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
        __from = FLRetain([aDecoder decodeObjectForKey:@"__from"]);
        __location = FLRetain([aDecoder decodeObjectForKey:@"__location"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __cover_photo = FLRetain([aDecoder decodeObjectForKey:@"__cover_photo"]);
        __privacy = FLRetain([aDecoder decodeObjectForKey:@"__privacy"]);
        __count = FLRetain([aDecoder decodeObjectForKey:@"__count"]);
        __type = FLRetain([aDecoder decodeObjectForKey:@"__type"]);
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
        __updated_time = FLRetain([aDecoder decodeObjectForKey:@"__updated_time"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] init];
        }
        [s_describer addProperty:@"description" withClass:[NSString class]];
        [s_describer addProperty:@"from" withClass:[FLFacebookNamedObject class] ];
        [s_describer addProperty:@"location" withClass:[NSString class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"cover_photo" withClass:[NSString class]];
        [s_describer addProperty:@"privacy" withClass:[NSString class]];
        [s_describer addProperty:@"count" withClass:[NSString class]];
        [s_describer addProperty:@"type" withClass:[NSString class]];
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
        [s_describer addProperty:@"updated_time" withClass:[NSDate class]];
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
