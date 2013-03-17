// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookObject.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookObject


@synthesize id = __id;

+ (NSString*) idKey
{
    return @"id";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookObject*)object).id = FLCopyOrRetainObject(__id);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__id);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__id) [aCoder encodeObject:__id forKey:@"__id"];
}

+ (FLFacebookObject*) facebookObject
{
    return FLAutorelease([[FLFacebookObject alloc] init]);
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
        __id = FLRetain([aDecoder decodeObjectForKey:@"__id"]);
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
        [s_describer addProperty:@"id" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"id" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
    });
    return s_table;
}

@end

@implementation FLFacebookObject (ValueProperties) 
@end

// [/Generated]
