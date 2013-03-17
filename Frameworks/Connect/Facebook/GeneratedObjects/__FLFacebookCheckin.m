// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookCheckin.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookCheckin.h"
#import "FLFacebookObject.h"
#import "FLFacebookDataList.h"
#import "FLFacebookPlace.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookCheckin


@synthesize application = __application;
@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize message = __message;
@synthesize place = __place;
@synthesize tags = __tags;

+ (NSString*) applicationKey
{
    return @"application";
}

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) placeKey
{
    return @"place";
}

+ (NSString*) tagsKey
{
    return @"tags";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookCheckin*)object).place = FLCopyOrRetainObject(__place);
    ((FLFacebookCheckin*)object).tags = FLCopyOrRetainObject(__tags);
    ((FLFacebookCheckin*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookCheckin*)object).application = FLCopyOrRetainObject(__application);
    ((FLFacebookCheckin*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookCheckin*)object).from = FLCopyOrRetainObject(__from);
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
    FLRelease(__tags);
    FLRelease(__place);
    FLRelease(__message);
    FLRelease(__application);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__tags) [aCoder encodeObject:__tags forKey:@"__tags"];
    if(__place) [aCoder encodeObject:__place forKey:@"__place"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__application) [aCoder encodeObject:__application forKey:@"__application"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookCheckin*) facebookCheckin
{
    return FLAutorelease([[FLFacebookCheckin alloc] init]);
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
        __tags = FLRetain([aDecoder decodeObjectForKey:@"__tags"]);
        __place = FLRetain([aDecoder decodeObjectForKey:@"__place"]);
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
        __application = FLRetain([aDecoder decodeObjectForKey:@"__application"]);
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
        [s_describer addProperty:@"from" withClass:[FLFacebookObject class] ];
        [s_describer addProperty:@"tags" withClass:[FLFacebookDataList class] ];
        [s_describer addProperty:@"place" withClass:[FLFacebookPlace class] ];
        [s_describer addProperty:@"message" withClass:[NSString class]];
        [s_describer addProperty:@"application" withClass:[FLFacebookNamedObject class] ];
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"tags" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"place" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"application" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookCheckin (ValueProperties) 
@end

// [/Generated]
