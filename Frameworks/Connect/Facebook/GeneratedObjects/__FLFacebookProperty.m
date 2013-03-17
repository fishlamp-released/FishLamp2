// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookProperty.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookProperty.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookProperty


@synthesize href = __href;
@synthesize name = __name;
@synthesize text = __text;

+ (NSString*) hrefKey
{
    return @"href";
}

+ (NSString*) nameKey
{
    return @"name";
}

+ (NSString*) textKey
{
    return @"text";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookProperty*)object).name = FLCopyOrRetainObject(__name);
    ((FLFacebookProperty*)object).text = FLCopyOrRetainObject(__text);
    ((FLFacebookProperty*)object).href = FLCopyOrRetainObject(__href);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__text);
    FLRelease(__name);
    FLRelease(__href);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__text) [aCoder encodeObject:__text forKey:@"__text"];
    if(__name) [aCoder encodeObject:__name forKey:@"__name"];
    if(__href) [aCoder encodeObject:__href forKey:@"__href"];
}

+ (FLFacebookProperty*) facebookProperty
{
    return FLAutorelease([[FLFacebookProperty alloc] init]);
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
        __text = FLRetain([aDecoder decodeObjectForKey:@"__text"]);
        __name = FLRetain([aDecoder decodeObjectForKey:@"__name"]);
        __href = FLRetain([aDecoder decodeObjectForKey:@"__href"]);
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
        [s_describer addProperty:@"text" withClass:[NSString class]];
        [s_describer addProperty:@"name" withClass:[NSString class]];
        [s_describer addProperty:@"href" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"text" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"href" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookProperty (ValueProperties) 
@end

// [/Generated]
