// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookStatusMessage.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookStatusMessage.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookStatusMessage


@synthesize from = __from;
@synthesize message = __message;
@synthesize updated_time = __updated_time;

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookStatusMessage*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookStatusMessage*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookStatusMessage*)object).from = FLCopyOrRetainObject(__from);
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
    FLRelease(__message);
    FLRelease(__updated_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookStatusMessage*) facebookStatusMessage
{
    return FLAutorelease([[FLFacebookStatusMessage alloc] init]);
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
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
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
        [s_describer addProperty:@"from" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"message" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookStatusMessage (ValueProperties) 
@end

// [/Generated]
