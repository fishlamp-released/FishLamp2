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
#import "FLSqliteTable.h"

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
    FLRelease(__value);
    FLRelease(__end_time);
    FLSuperDealloc();
}

+ (FLFacebookInsight*) facebookInsight
{
    return FLReturnAutoreleased([[FLFacebookInsight alloc] init]);
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"value" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"end_time" columnType:FLSqliteTypeDate columnConstraints:nil]];
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
