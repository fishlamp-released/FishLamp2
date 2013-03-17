// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookComment.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookComment.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookComment


@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize likes = __likes;
@synthesize message = __message;

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) likesKey
{
    return @"likes";
}

+ (NSString*) messageKey
{
    return @"message";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookComment*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookComment*)object).likes = FLCopyOrRetainObject(__likes);
    ((FLFacebookComment*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookComment*)object).from = FLCopyOrRetainObject(__from);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__created_time);
    FLRelease(__message);
    FLRelease(__from);
    FLRelease(__likes);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__likes) [aCoder encodeObject:__likes forKey:@"__likes"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookComment*) facebookComment
{
    return FLAutorelease([[FLFacebookComment alloc] init]);
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
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
        __from = FLRetain([aDecoder decodeObjectForKey:@"__from"]);
        __likes = FLRetain([aDecoder decodeObjectForKey:@"__likes"]);
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
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
        [s_describer addProperty:@"message" withClass:[NSString class]];
        [s_describer addProperty:@"from" withClass:[FLFacebookNamedObject class] ];
        [s_describer addProperty:@"likes" withClass:[FLIntegerNumber class] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"likes" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookComment (ValueProperties) 

- (int) likesValue
{
    return [self.likes intValue];
}

- (void) setLikesValue:(int) value
{
    self.likes = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
