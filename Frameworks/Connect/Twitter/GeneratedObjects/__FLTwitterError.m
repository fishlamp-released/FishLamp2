// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLTwitterError.m
// Project: FishLamp
// Schema: Twitter
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTwitterError.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLTwitterError


@synthesize error = __error;
@synthesize request = __request;

+ (NSString*) errorKey
{
    return @"error";
}

+ (NSString*) requestKey
{
    return @"request";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLTwitterError*)object).error = FLCopyOrRetainObject(__error);
    ((FLTwitterError*)object).request = FLCopyOrRetainObject(__request);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__error);
    FLRelease(__request);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__error) [aCoder encodeObject:__error forKey:@"__error"];
    if(__request) [aCoder encodeObject:__request forKey:@"__request"];
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
        __error = FLRetain([aDecoder decodeObjectForKey:@"__error"]);
        __request = FLRetain([aDecoder decodeObjectForKey:@"__request"]);
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
        [s_describer addProperty:@"error" withClass:[NSString class]];
        [s_describer addProperty:@"request" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"error" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"request" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

+ (FLTwitterError*) twitterError
{
    return FLAutorelease([[FLTwitterError alloc] init]);
}

@end

@implementation FLTwitterError (ValueProperties) 
@end

// [/Generated]
