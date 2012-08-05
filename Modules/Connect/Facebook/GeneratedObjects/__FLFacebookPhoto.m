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
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"
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
    return FLReturnAutoreleased([[FLFacebookPhoto alloc] init]);
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
        __from = FLReturnRetained([aDecoder decodeObjectForKey:@"__from"]);
        __updated_time = FLReturnRetained([aDecoder decodeObjectForKey:@"__updated_time"]);
        __created_time = FLReturnRetained([aDecoder decodeObjectForKey:@"__created_time"]);
        __link = FLReturnRetained([aDecoder decodeObjectForKey:@"__link"]);
        __icon = FLReturnRetained([aDecoder decodeObjectForKey:@"__icon"]);
        __source = FLReturnRetained([aDecoder decodeObjectForKey:@"__source"]);
        __height = FLReturnRetained([aDecoder decodeObjectForKey:@"__height"]);
        __width = FLReturnRetained([aDecoder decodeObjectForKey:@"__width"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"link" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"link"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"icon"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"source" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"source"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"height" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"height"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"width" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"width"];
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

+ (FLSqliteTable*) sharedSqliteTable
{
    static FLSqliteTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        FLSqliteTable* superTable = [super sharedSqliteTable];
        if(superTable)
        {
            s_table = [superTable copy];
            s_table.tableName = [self sqliteTableName];
        }
        else
        {
            s_table = [[FLSqliteTable alloc] initWithTableName:[self sqliteTableName]];
        }
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"from" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:FLSqliteTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:FLSqliteTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"link" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"source" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"height" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"width" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"tags" columnType:FLSqliteTypeObject columnConstraints:nil]];
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
