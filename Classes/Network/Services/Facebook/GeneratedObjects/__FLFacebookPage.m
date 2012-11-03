// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPage.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookPage.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookPage


@synthesize category = __category;
@synthesize likes = __likes;

+ (NSString*) categoryKey
{
    return @"category";
}

+ (NSString*) likesKey
{
    return @"likes";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookPage*)object).likes = FLCopyOrRetainObject(__likes);
    ((FLFacebookPage*)object).category = FLCopyOrRetainObject(__category);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    mrc_release_(__category);
    mrc_release_(__likes);
    super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__category) [aCoder encodeObject:__category forKey:@"__category"];
    if(__likes) [aCoder encodeObject:__likes forKey:@"__likes"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookPage*) facebookPage
{
    return autorelease_([[FLFacebookPage alloc] init]);
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
        __category = retain_([aDecoder decodeObjectForKey:@"__category"]);
        __likes = retain_([aDecoder decodeObjectForKey:@"__likes"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"category" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"category"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"likes" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"likes"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"category" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"likes" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookPage (ValueProperties) 

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
