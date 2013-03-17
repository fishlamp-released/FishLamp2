// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookMessage.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookMessage.h"
#import "FLFacebookEmailObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookMessage


@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize message = __message;
@synthesize to = __to;

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

+ (NSString*) toKey
{
    return @"to";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookMessage*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookMessage*)object).to = FLCopyOrRetainObject(__to);
    ((FLFacebookMessage*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookMessage*)object).from = FLCopyOrRetainObject(__from);
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
    FLRelease(__to);
    FLRelease(__message);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__to) [aCoder encodeObject:__to forKey:@"__to"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookMessage*) facebookMessage
{
    return FLAutorelease([[FLFacebookMessage alloc] init]);
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
        __to = FLRetain([aDecoder decodeObjectForKey:@"__to"]);
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
        [s_describer addProperty:@"from" withClass:[FLFacebookEmailObject class]];
        [s_describer addProperty:@"to" withClass:[FLFacebookEmailObject class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"to" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookMessage (ValueProperties) 
@end

// [/Generated]
