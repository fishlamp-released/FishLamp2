// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookCheckin.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookCheckin.h"
#import "FLFacebookObject.h"
#import "FLFacebookDataList.h"
#import "FLFacebookPlace.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookCheckin


@synthesize application = __application;
@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize message = __message;
@synthesize place = __place;
@synthesize tags = __tags;

+ (NSString*) applicationKey
{
    return @"application";
}

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) placeKey
{
    return @"place";
}

+ (NSString*) tagsKey
{
    return @"tags";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookCheckin*)object).place = FLCopyOrRetainObject(__place);
    ((FLFacebookCheckin*)object).tags = FLCopyOrRetainObject(__tags);
    ((FLFacebookCheckin*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookCheckin*)object).application = FLCopyOrRetainObject(__application);
    ((FLFacebookCheckin*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookCheckin*)object).from = FLCopyOrRetainObject(__from);
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
    FLRelease(__tags);
    FLRelease(__place);
    FLRelease(__message);
    FLRelease(__application);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__tags) [aCoder encodeObject:__tags forKey:@"__tags"];
    if(__place) [aCoder encodeObject:__place forKey:@"__place"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__application) [aCoder encodeObject:__application forKey:@"__application"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookCheckin*) facebookCheckin
{
    return FLReturnAutoreleased([[FLFacebookCheckin alloc] init]);
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
        __tags = FLReturnRetained([aDecoder decodeObjectForKey:@"__tags"]);
        __place = FLReturnRetained([aDecoder decodeObjectForKey:@"__place"]);
        __message = FLReturnRetained([aDecoder decodeObjectForKey:@"__message"]);
        __application = FLReturnRetained([aDecoder decodeObjectForKey:@"__application"]);
        __created_time = FLReturnRetained([aDecoder decodeObjectForKey:@"__created_time"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"from" propertyClass:[FLFacebookObject class] propertyType:FLDataTypeObject] forPropertyName:@"from"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"tags" propertyClass:[FLFacebookDataList class] propertyType:FLDataTypeObject] forPropertyName:@"tags"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"place" propertyClass:[FLFacebookPlace class] propertyType:FLDataTypeObject] forPropertyName:@"place"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"message"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"application" propertyClass:[FLFacebookNamedObject class] propertyType:FLDataTypeObject] forPropertyName:@"application"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"created_time"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"tags" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"place" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"application" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookCheckin (ValueProperties) 
@end

// [/Generated]
