// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPost.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookPost.h"
#import "FLFacebookNamedObject.h"
#import "FLFacebookNamedObjectList.h"
#import "FLFacebookPrivacy.h"
#import "FLFacebookCommentList.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLFacebookAction.h"
#import "FLFacebookProperty.h"

@implementation FLFacebookPost


@synthesize actions = __actions;
@synthesize application = __application;
@synthesize caption = __caption;
@synthesize comments = __comments;
@synthesize created_time = __created_time;
@synthesize description = __description;
@synthesize from = __from;
@synthesize icon = __icon;
@synthesize likes = __likes;
@synthesize link = __link;
@synthesize message = __message;
@synthesize object_id = __object_id;
@synthesize picture = __picture;
@synthesize privacy = __privacy;
@synthesize properties = __properties;
@synthesize source = __source;
@synthesize to = __to;
@synthesize type = __type;
@synthesize updated_time = __updated_time;

+ (NSString*) actionsKey
{
    return @"actions";
}

+ (NSString*) applicationKey
{
    return @"application";
}

+ (NSString*) captionKey
{
    return @"caption";
}

+ (NSString*) commentsKey
{
    return @"comments";
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

+ (NSString*) iconKey
{
    return @"icon";
}

+ (NSString*) likesKey
{
    return @"likes";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) object_idKey
{
    return @"object_id";
}

+ (NSString*) pictureKey
{
    return @"picture";
}

+ (NSString*) privacyKey
{
    return @"privacy";
}

+ (NSString*) propertiesKey
{
    return @"properties";
}

+ (NSString*) sourceKey
{
    return @"source";
}

+ (NSString*) toKey
{
    return @"to";
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
    ((FLFacebookPost*)object).description = FLCopyOrRetainObject(__description);
    ((FLFacebookPost*)object).comments = FLCopyOrRetainObject(__comments);
    ((FLFacebookPost*)object).caption = FLCopyOrRetainObject(__caption);
    ((FLFacebookPost*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookPost*)object).actions = FLCopyOrRetainObject(__actions);
    ((FLFacebookPost*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookPost*)object).picture = FLCopyOrRetainObject(__picture);
    ((FLFacebookPost*)object).from = FLCopyOrRetainObject(__from);
    ((FLFacebookPost*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookPost*)object).source = FLCopyOrRetainObject(__source);
    ((FLFacebookPost*)object).application = FLCopyOrRetainObject(__application);
    ((FLFacebookPost*)object).likes = FLCopyOrRetainObject(__likes);
    ((FLFacebookPost*)object).type = FLCopyOrRetainObject(__type);
    ((FLFacebookPost*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookPost*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookPost*)object).properties = FLCopyOrRetainObject(__properties);
    ((FLFacebookPost*)object).object_id = FLCopyOrRetainObject(__object_id);
    ((FLFacebookPost*)object).privacy = FLCopyOrRetainObject(__privacy);
    ((FLFacebookPost*)object).to = FLCopyOrRetainObject(__to);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__object_id);
    FLRelease(__from);
    FLRelease(__to);
    FLRelease(__message);
    FLRelease(__picture);
    FLRelease(__link);
    FLRelease(__caption);
    FLRelease(__description);
    FLRelease(__source);
    FLRelease(__icon);
    FLRelease(__properties);
    FLRelease(__application);
    FLRelease(__privacy);
    FLRelease(__comments);
    FLRelease(__likes);
    FLRelease(__actions);
    FLRelease(__type);
    FLRelease(__updated_time);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__object_id) [aCoder encodeObject:__object_id forKey:@"__object_id"];
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__to) [aCoder encodeObject:__to forKey:@"__to"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__picture) [aCoder encodeObject:__picture forKey:@"__picture"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__caption) [aCoder encodeObject:__caption forKey:@"__caption"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__source) [aCoder encodeObject:__source forKey:@"__source"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__properties) [aCoder encodeObject:__properties forKey:@"__properties"];
    if(__application) [aCoder encodeObject:__application forKey:@"__application"];
    if(__privacy) [aCoder encodeObject:__privacy forKey:@"__privacy"];
    if(__comments) [aCoder encodeObject:__comments forKey:@"__comments"];
    if(__likes) [aCoder encodeObject:__likes forKey:@"__likes"];
    if(__actions) [aCoder encodeObject:__actions forKey:@"__actions"];
    if(__type) [aCoder encodeObject:__type forKey:@"__type"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookPost*) facebookPost
{
    return FLAutorelease([[FLFacebookPost alloc] init]);
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
        __object_id = FLRetain([aDecoder decodeObjectForKey:@"__object_id"]);
        __from = FLRetain([aDecoder decodeObjectForKey:@"__from"]);
        __to = FLRetain([aDecoder decodeObjectForKey:@"__to"]);
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
        __picture = FLRetain([aDecoder decodeObjectForKey:@"__picture"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __caption = FLRetain([aDecoder decodeObjectForKey:@"__caption"]);
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
        __source = FLRetain([aDecoder decodeObjectForKey:@"__source"]);
        __icon = FLRetain([aDecoder decodeObjectForKey:@"__icon"]);
        __properties = [[aDecoder decodeObjectForKey:@"__properties"] mutableCopy];
        __application = FLRetain([aDecoder decodeObjectForKey:@"__application"]);
        __privacy = FLRetain([aDecoder decodeObjectForKey:@"__privacy"]);
        __comments = FLRetain([aDecoder decodeObjectForKey:@"__comments"]);
        __likes = FLRetain([aDecoder decodeObjectForKey:@"__likes"]);
        __actions = [[aDecoder decodeObjectForKey:@"__actions"] mutableCopy];
        __type = FLRetain([aDecoder decodeObjectForKey:@"__type"]);
        __updated_time = FLRetain([aDecoder decodeObjectForKey:@"__updated_time"]);
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
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
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addProperty:@"object_id" withClass:[NSString class]];
        [s_describer addProperty:@"from" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"to" withClass:[FLFacebookNamedObjectList class]];
        [s_describer addProperty:@"message" withClass:[NSString class]];
        [s_describer addProperty:@"picture" withClass:[NSString class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"caption" withClass:[NSString class]];
        [s_describer addProperty:@"description" withClass:[NSString class]];
        [s_describer addProperty:@"source" withClass:[NSString class]];
        [s_describer addProperty:@"icon" withClass:[NSString class]];
        [s_describer addProperty:@"properties" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"property" objectClass:[FLFacebookProperty class]], nil]];
        [s_describer addProperty:@"application" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"privacy" withClass:[FLFacebookPrivacy class]];
        [s_describer addProperty:@"comments" withClass:[FLFacebookCommentList class]];
        [s_describer addProperty:@"likes" withClass:[FLFacebookNamedObjectList class]];
        [s_describer addProperty:@"actions" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"action" objectClass:[FLFacebookAction class]], nil]];
        [s_describer addProperty:@"type" withClass:[NSString class]];
        [s_describer addProperty:@"updated_time" withClass:[NSDate class]];
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
    });
    return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"object_id" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"to" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"picture" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"source" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"properties" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"application" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"privacy" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"comments" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"likes" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"actions" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"type" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"updated_time" indexProperties:FLDatabaseColumnIndexPropertyNone]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addIndex:[FLDatabaseIndex databaseIndex:@"created_time" indexProperties:FLDatabaseColumnIndexPropertyNone]];
    });
    return s_table;
}

@end

@implementation FLFacebookPost (ValueProperties) 
@end

// [/Generated]
