// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookLikeList.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookLikeList.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLFacebookNamedObject.h"

@implementation FLFacebookLikeList


@synthesize count = __count;
@synthesize data = __data;

+ (NSString*) countKey
{
    return @"count";
}

+ (NSString*) dataKey
{
    return @"data";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookLikeList*)object).count = FLCopyOrRetainObject(__count);
    ((FLFacebookLikeList*)object).data = FLCopyOrRetainObject(__data);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__count);
    FLRelease(__data);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__count) [aCoder encodeObject:__count forKey:@"__count"];
    if(__data) [aCoder encodeObject:__data forKey:@"__data"];
}

+ (FLFacebookLikeList*) facebookLikeList
{
    return FLAutorelease([[FLFacebookLikeList alloc] init]);
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
        __count = FLRetain([aDecoder decodeObjectForKey:@"__count"]);
        __data = [[aDecoder decodeObjectForKey:@"__data"] mutableCopy];
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
        [s_describer addProperty:@"count" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"data" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"like" objectClass:[FLFacebookNamedObject class]], nil]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"count" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"data" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookLikeList (ValueProperties) 

- (int) countValue
{
    return [self.count intValue];
}

- (void) setCountValue:(int) value
{
    self.count = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
