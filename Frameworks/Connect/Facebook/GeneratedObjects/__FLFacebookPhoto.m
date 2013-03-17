// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPhoto.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookPhoto.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLFacebookTag.h"

@implementation FLFacebookPhoto


@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize height = __height;
@synthesize icon = __icon;
@synthesize link = __link;
@synthesize source = __source;
@synthesize tags = __tags;
@synthesize updated_time = __updated_time;
@synthesize width = __width;

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) heightKey
{
    return @"height";
}

+ (NSString*) iconKey
{
    return @"icon";
}

+ (NSString*) linkKey
{
    return @"link";
}

+ (NSString*) sourceKey
{
    return @"source";
}

+ (NSString*) tagsKey
{
    return @"tags";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

+ (NSString*) widthKey
{
    return @"width";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookPhoto*)object).from = FLCopyOrRetainObject(__from);
    ((FLFacebookPhoto*)object).source = FLCopyOrRetainObject(__source);
    ((FLFacebookPhoto*)object).height = FLCopyOrRetainObject(__height);
    ((FLFacebookPhoto*)object).tags = FLCopyOrRetainObject(__tags);
    ((FLFacebookPhoto*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookPhoto*)object).width = FLCopyOrRetainObject(__width);
    ((FLFacebookPhoto*)object).link = FLCopyOrRetainObject(__link);
    ((FLFacebookPhoto*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookPhoto*)object).created_time = FLCopyOrRetainObject(__created_time);
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
    FLRelease(__updated_time);
    FLRelease(__created_time);
    FLRelease(__link);
    FLRelease(__icon);
    FLRelease(__source);
    FLRelease(__height);
    FLRelease(__width);
    FLRelease(__tags);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    if(__link) [aCoder encodeObject:__link forKey:@"__link"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__source) [aCoder encodeObject:__source forKey:@"__source"];
    if(__height) [aCoder encodeObject:__height forKey:@"__height"];
    if(__width) [aCoder encodeObject:__width forKey:@"__width"];
    if(__tags) [aCoder encodeObject:__tags forKey:@"__tags"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookPhoto*) facebookPhoto
{
    return FLAutorelease([[FLFacebookPhoto alloc] init]);
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
        __updated_time = FLRetain([aDecoder decodeObjectForKey:@"__updated_time"]);
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
        __link = FLRetain([aDecoder decodeObjectForKey:@"__link"]);
        __icon = FLRetain([aDecoder decodeObjectForKey:@"__icon"]);
        __source = FLRetain([aDecoder decodeObjectForKey:@"__source"]);
        __height = FLRetain([aDecoder decodeObjectForKey:@"__height"]);
        __width = FLRetain([aDecoder decodeObjectForKey:@"__width"]);
        __tags = [[aDecoder decodeObjectForKey:@"__tags"] mutableCopy];
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
        [s_describer addProperty:@"from" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"updated_time" withClass:[NSDate class]];
        [s_describer addProperty:@"created_time" withClass:[NSDate class]];
        [s_describer addProperty:@"link" withClass:[NSString class]];
        [s_describer addProperty:@"icon" withClass:[NSString class]];
        [s_describer addProperty:@"source" withClass:[NSString class]];
        [s_describer addProperty:@"height" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"width" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"tags" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"tag" propertyClass:[FLFacebookTag class]], nil]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"link" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"source" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"height" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"width" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"tags" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookPhoto (ValueProperties) 

- (int) heightValue
{
    return [self.height intValue];
}

- (void) setHeightValue:(int) value
{
    self.height = [NSNumber numberWithInt:value];
}

- (int) widthValue
{
    return [self.width intValue];
}

- (void) setWidthValue:(int) value
{
    self.width = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
