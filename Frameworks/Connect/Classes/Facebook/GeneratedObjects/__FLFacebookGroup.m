// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookGroup.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookGroup.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookGroup


@synthesize description = __description;
@synthesize icon = __icon;
@synthesize link = __link;
@synthesize owner = __owner;
@synthesize privacy = __privacy;
@synthesize updated_time = __updated_time;

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) iconKey
{
    return @"icon";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) ownerKey
{
    return @"owner";
}

+ (NSString*) privacyKey
{
    return @"privacy";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookGroup*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookGroup*)object).owner = FLCopyOrRetainObject(__owner);
    ((FLFacebookGroup*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookGroup*)object).description = FLCopyOrRetainObject(__description);
    ((FLFacebookGroup*)object).privacy = FLCopyOrRetainObject(__privacy);
    ((FLFacebookGroup*)object).link = FLCopyOrRetainObject(__link);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__owner);
    FLRelease(__icon);
    FLRelease(__description);
    FLRelease(__link);
    FLRelease(__privacy);
    FLRelease(__updated_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__owner) [aCoder encodeObject:__owner forKey:@"__owner"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__privacy) [aCoder encodeObject:__privacy forKey:@"__privacy"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookGroup*) facebookGroup
{
    return FLAutorelease([[FLFacebookGroup alloc] init]);
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
        __owner = FLRetain([aDecoder decodeObjectForKey:@"__owner"]);
        __icon = FLRetain([aDecoder decodeObjectForKey:@"__icon"]);
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __privacy = FLRetain([aDecoder decodeObjectForKey:@"__privacy"]);
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
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addProperty:@"owner" withClass:[NSString class]];
        [s_describer addProperty:@"icon" withClass:[NSString class]];
        [s_describer addProperty:@"description" withClass:[NSString class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"privacy" withClass:[NSString class]];
        [s_describer addProperty:@"updated_time" withClass:[NSDate class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"owner" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"privacy" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookGroup (ValueProperties) 
@end

// [/Generated]
