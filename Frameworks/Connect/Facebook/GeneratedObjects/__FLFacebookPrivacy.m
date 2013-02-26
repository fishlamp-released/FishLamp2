// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPrivacy.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookPrivacy.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookPrivacy


@synthesize deny = __deny;
@synthesize description = __description;
@synthesize friends = __friends;
@synthesize networks = __networks;
@synthesize value = __value;

+ (NSString*) denyKey
{
    return @"deny";
}

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) friendsKey
{
    return @"friends";
}

+ (NSString*) networksKey
{
    return @"networks";
}

+ (NSString*) valueKey
{
    return @"value";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookPrivacy*)object).value = FLCopyOrRetainObject(__value);
    ((FLFacebookPrivacy*)object).friends = FLCopyOrRetainObject(__friends);
    ((FLFacebookPrivacy*)object).networks = FLCopyOrRetainObject(__networks);
    ((FLFacebookPrivacy*)object).deny = FLCopyOrRetainObject(__deny);
    ((FLFacebookPrivacy*)object).description = FLCopyOrRetainObject(__description);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__value);
    FLRelease(__friends);
    FLRelease(__networks);
    FLRelease(__deny);
    FLRelease(__description);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__value) [aCoder encodeObject:__value forKey:@"__value"];
    if(__friends) [aCoder encodeObject:__friends forKey:@"__friends"];
    if(__networks) [aCoder encodeObject:__networks forKey:@"__networks"];
    if(__deny) [aCoder encodeObject:__deny forKey:@"__deny"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
}

+ (FLFacebookPrivacy*) facebookPrivacy
{
    return FLAutorelease([[FLFacebookPrivacy alloc] init]);
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
        __value = FLRetain([aDecoder decodeObjectForKey:@"__value"]);
        __friends = FLRetain([aDecoder decodeObjectForKey:@"__friends"]);
        __networks = FLRetain([aDecoder decodeObjectForKey:@"__networks"]);
        __deny = FLRetain([aDecoder decodeObjectForKey:@"__deny"]);
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
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
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"value" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"friends" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"networks" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"deny" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"description" propertyClass:[NSString class] ] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"value" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"friends" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"networks" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"deny" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookPrivacy (ValueProperties) 
@end

// [/Generated]
