// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookInsight.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookInsight.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookInsight


@synthesize end_time = __end_time;
@synthesize value = __value;

+ (NSString*) end_timeKey
{
    return @"end_time";
}

+ (NSString*) valueKey
{
    return @"value";
}

- (void) dealloc
{
    mrc_release_(__value);
    mrc_release_(__end_time);
    mrc_super_dealloc_();
}

+ (FLFacebookInsight*) facebookInsight
{
    return autorelease_([[FLFacebookInsight alloc] init]);
}

- (id) init
{
    if((self = [super init]))
    {
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"value" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"value"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"end_time" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"end_time"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"value" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"end_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookInsight (ValueProperties) 

- (int) valueValue
{
    return [self.value intValue];
}

- (void) setValueValue:(int) value
{
    self.value = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
