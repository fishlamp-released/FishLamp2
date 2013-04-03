// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookApplication.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookApplication.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookApplication


@synthesize category = __category;
@synthesize description = __description;
@synthesize link = __link;

+ (NSString*) categoryKey
{
    return @"category";
}

+ (NSString*) descriptionKey
{
    return @"description";
}

+ (NSString*) linkKey
{
    return @"link";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookApplication*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookApplication*)object).category = FLCopyOrRetainObject(__category);
    ((FLFacebookApplication*)object).description = FLCopyOrRetainObject(__description);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__category);
    FLRelease(__link);
    FLRelease(__description);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__category) [aCoder encodeObject:__category forKey:@"__category"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__description) [aCoder encodeObject:__description forKey:@"__description"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookApplication*) facebookApplication
{
    return FLAutorelease([[FLFacebookApplication alloc] init]);
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
        __category = FLRetain([aDecoder decodeObjectForKey:@"__category"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __description = FLRetain([aDecoder decodeObjectForKey:@"__description"]);
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
        [s_describer addProperty:@"category" withClass:[NSString class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"description" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"category" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"description" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookApplication (ValueProperties) 
@end

// [/Generated]
