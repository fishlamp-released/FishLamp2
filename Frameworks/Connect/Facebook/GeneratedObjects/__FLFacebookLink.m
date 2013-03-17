// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookLink.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookLink.h"
#import "FLFacebookObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookLink


@synthesize caption = __caption;
@synthesize created_time = __created_time;
@synthesize description = __description;
@synthesize from = __from;
@synthesize icon = __icon;
@synthesize link = __link;
@synthesize message = __message;
@synthesize picture = __picture;

+ (NSString*) captionKey
{
    return @"caption";
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

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) pictureKey
{
    return @"picture";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookLink*)object).from = FLCopyOrRetainObject(__from);
    ((FLFacebookLink*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookLink*)object).picture = FLCopyOrRetainObject(__picture);
    ((FLFacebookLink*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookLink*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookLink*)object).description = FLCopyOrRetainObject(__description);
    ((FLFacebookLink*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookLink*)object).caption = FLCopyOrRetainObject(__caption);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__from);
    FLRelease(__link);
    FLRelease(__caption);
    FLRelease(__description);
    FLRelease(__icon);
    FLRelease(__picture);
    FLRelease(__message);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__caption) [aCoder encodeObject:__caption forKey:@"__caption"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__picture) [aCoder encodeObject:__picture forKey:@"__picture"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookLink*) facebookLink
{
    return FLAutorelease([[FLFacebookLink alloc] init]);
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
        __from = FLRetain([aDecoder decodeObjectForKey:@"__from"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __caption = FLRetain([aDecoder decodeObjectForKey:@"__caption"]);
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
        __icon = FLRetain([aDecoder decodeObjectForKey:@"__icon"]);
        __picture = FLRetain([aDecoder decodeObjectForKey:@"__picture"]);
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
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
        [s_describer addProperty:@"from" withClass:[FLFacebookObject class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"caption" withClass:[NSString class]];
        [s_describer addProperty:@"description" withClass:[NSString class]];
        [s_describer addProperty:@"icon" withClass:[NSString class]];
        [s_describer addProperty:@"picture" withClass:[NSString class]];
        [s_describer addProperty:@"message" withClass:[NSString class]];
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"caption" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"picture" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookLink (ValueProperties) 
@end

// [/Generated]
