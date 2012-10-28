// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookEmployer.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookEmployer.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookEmployer


@synthesize employer = __employer;
@synthesize end_date = __end_date;
@synthesize location = __location;
@synthesize position = __position;
@synthesize start_date = __start_date;

+ (NSString*) employerKey
{
    return @"employer";
}

+ (NSString*) end_dateKey
{
    return @"end_date";
}

+ (NSString*) locationKey
{
    return @"location";
}

+ (NSString*) positionKey
{
    return @"position";
}

+ (NSString*) start_dateKey
{
    return @"start_date";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookEmployer*)object).employer = FLCopyOrRetainObject(__employer);
    ((FLFacebookEmployer*)object).start_date = FLCopyOrRetainObject(__start_date);
    ((FLFacebookEmployer*)object).end_date = FLCopyOrRetainObject(__end_date);
    ((FLFacebookEmployer*)object).position = FLCopyOrRetainObject(__position);
    ((FLFacebookEmployer*)object).location = FLCopyOrRetainObject(__location);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__employer);
    FLRelease(__location);
    FLRelease(__position);
    FLRelease(__start_date);
    FLRelease(__end_date);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__employer) [aCoder encodeObject:__employer forKey:@"__employer"];
    if(__location) [aCoder encodeObject:__location forKey:@"__location"];
    if(__position) [aCoder encodeObject:__position forKey:@"__position"];
    if(__start_date) [aCoder encodeObject:__start_date forKey:@"__start_date"];
    if(__end_date) [aCoder encodeObject:__end_date forKey:@"__end_date"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookEmployer*) facebookEmployer
{
    return FLReturnAutoreleased([[FLFacebookEmployer alloc] init]);
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
        __employer = FLReturnRetained([aDecoder decodeObjectForKey:@"__employer"]);
        __location = FLReturnRetained([aDecoder decodeObjectForKey:@"__location"]);
        __position = FLReturnRetained([aDecoder decodeObjectForKey:@"__position"]);
        __start_date = FLReturnRetained([aDecoder decodeObjectForKey:@"__start_date"]);
        __end_date = FLReturnRetained([aDecoder decodeObjectForKey:@"__end_date"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"employer" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"employer"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"location"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"position" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"position"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"start_date" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"start_date"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"end_date" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"end_date"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"employer" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"location" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"position" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"start_date" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"end_date" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookEmployer (ValueProperties) 
@end

// [/Generated]
