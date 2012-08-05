// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookPagingResponse.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookPagingResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLFacebookPagingResponse


@synthesize next = __next;
@synthesize previous = __previous;

+ (NSString*) nextKey
{
    return @"next";
}

+ (NSString*) previousKey
{
    return @"previous";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookPagingResponse*)object).previous = FLCopyOrRetainObject(__previous);
    ((FLFacebookPagingResponse*)object).next = FLCopyOrRetainObject(__next);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__previous);
    FLRelease(__next);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__previous) [aCoder encodeObject:__previous forKey:@"__previous"];
    if(__next) [aCoder encodeObject:__next forKey:@"__next"];
}

+ (FLFacebookPagingResponse*) facebookPagingResponse
{
    return FLReturnAutoreleased([[FLFacebookPagingResponse alloc] init]);
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
        __previous = FLReturnRetained([aDecoder decodeObjectForKey:@"__previous"]);
        __next = FLReturnRetained([aDecoder decodeObjectForKey:@"__next"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"previous" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"previous"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"next" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"next"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"previous" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"next" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookPagingResponse (ValueProperties) 
@end

// [/Generated]
