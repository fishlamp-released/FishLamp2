// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookWorkHistory.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookWorkHistory.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookWorkHistory


@synthesize employer = __employer;
@synthesize end_date = __end_date;
@synthesize location = __location;
@synthesize position = __position;
@synthesize start_date = __start_date;

+ (NSString*) employerKey
{
    return @"employer";
}

+ (NSString*) end_dateKey
{
    return @"end_date";
}

+ (NSString*) locationKey
{
    return @"location";
}

+ (NSString*) positionKey
{
    return @"position";
}

+ (NSString*) start_dateKey
{
    return @"start_date";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookWorkHistory*)object).employer = FLCopyOrRetainObject(__employer);
    ((FLFacebookWorkHistory*)object).start_date = FLCopyOrRetainObject(__start_date);
    ((FLFacebookWorkHistory*)object).end_date = FLCopyOrRetainObject(__end_date);
    ((FLFacebookWorkHistory*)object).position = FLCopyOrRetainObject(__position);
    ((FLFacebookWorkHistory*)object).location = FLCopyOrRetainObject(__location);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__employer);
    FLRelease(__location);
    FLRelease(__position);
    FLRelease(__start_date);
    FLRelease(__end_date);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__employer) [aCoder encodeObject:__employer forKey:@"__employer"];
    if(__location) [aCoder encodeObject:__location forKey:@"__location"];
    if(__position) [aCoder encodeObject:__position forKey:@"__position"];
    if(__start_date) [aCoder encodeObject:__start_date forKey:@"__start_date"];
    if(__end_date) [aCoder encodeObject:__end_date forKey:@"__end_date"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookWorkHistory*) facebookWorkHistory
{
    return FLAutorelease([[FLFacebookWorkHistory alloc] init]);
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
        __employer = FLRetain([aDecoder decodeObjectForKey:@"__employer"]);
        __location = FLRetain([aDecoder decodeObjectForKey:@"__location"]);
        __position = FLRetain([aDecoder decodeObjectForKey:@"__position"]);
        __start_date = FLRetain([aDecoder decodeObjectForKey:@"__start_date"]);
        __end_date = FLRetain([aDecoder decodeObjectForKey:@"__end_date"]);
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
        [s_describer addProperty:@"employer" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"location" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"position" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"start_date" withClass:[NSDate class]];
        [s_describer addProperty:@"end_date" withClass:[NSDate class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"employer" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"location" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"position" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"start_date" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"end_date" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookWorkHistory (ValueProperties) 
@end

// [/Generated]
