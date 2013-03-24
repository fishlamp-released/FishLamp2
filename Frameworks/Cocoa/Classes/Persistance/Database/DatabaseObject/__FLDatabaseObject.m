// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLDatabaseObject.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLDatabaseObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLDatabaseObject


@synthesize uid = __uid;

+ (NSString*) uidKey
{
    return @"uid";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLDatabaseObject*)object).uid = FLCopyOrRetainObject(__uid);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

+ (FLDatabaseObject*) databaseObject
{
    return FLAutorelease([[FLDatabaseObject alloc] init]);
}

- (void) dealloc
{
    FLRelease(__uid);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__uid) [aCoder encodeObject:__uid forKey:@"__uid"];
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
        __uid = FLRetain([aDecoder decodeObjectForKey:@"__uid"]);
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
        [s_describer addProperty:@"uid" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"uid" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
    });
    return s_table;
}

@end

@implementation FLDatabaseObject (ValueProperties) 
@end

// [/Generated]