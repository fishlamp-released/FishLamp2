// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookVideo.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookVideo.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLFacebookTag.h"

@implementation FLFacebookVideo


@synthesize created_time = __created_time;
@synthesize embed_html = __embed_html;
@synthesize from = __from;
@synthesize icon = __icon;
@synthesize source = __source;
@synthesize tags = __tags;
@synthesize updated_time = __updated_time;

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) embed_htmlKey
{
    return @"embed_html";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) iconKey
{
    return @"icon";
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

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookVideo*)object).from = FLCopyOrRetainObject(__from);
    ((FLFacebookVideo*)object).source = FLCopyOrRetainObject(__source);
    ((FLFacebookVideo*)object).tags = FLCopyOrRetainObject(__tags);
    ((FLFacebookVideo*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookVideo*)object).embed_html = FLCopyOrRetainObject(__embed_html);
    ((FLFacebookVideo*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookVideo*)object).created_time = FLCopyOrRetainObject(__created_time);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    mrc_release_(__from);
    mrc_release_(__updated_time);
    mrc_release_(__created_time);
    mrc_release_(__embed_html);
    mrc_release_(__icon);
    mrc_release_(__source);
    mrc_release_(__tags);
    mrc_super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    if(__embed_html) [aCoder encodeObject:__embed_html forKey:@"__embed_html"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__source) [aCoder encodeObject:__source forKey:@"__source"];
    if(__tags) [aCoder encodeObject:__tags forKey:@"__tags"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookVideo*) facebookVideo
{
    return autorelease_([[FLFacebookVideo alloc] init]);
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
        __from = retain_([aDecoder decodeObjectForKey:@"__from"]);
        __updated_time = retain_([aDecoder decodeObjectForKey:@"__updated_time"]);
        __created_time = retain_([aDecoder decodeObjectForKey:@"__created_time"]);
        __embed_html = retain_([aDecoder decodeObjectForKey:@"__embed_html"]);
        __icon = retain_([aDecoder decodeObjectForKey:@"__icon"]);
        __source = retain_([aDecoder decodeObjectForKey:@"__source"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"from" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"from"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"updated_time"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"created_time"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"embed_html" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"embed_html"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"icon"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"source" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"source"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"tags" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"tag" propertyClass:[FLFacebookTag class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"tags"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"embed_html" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"source" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"tags" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookVideo (ValueProperties) 
@end

// [/Generated]
