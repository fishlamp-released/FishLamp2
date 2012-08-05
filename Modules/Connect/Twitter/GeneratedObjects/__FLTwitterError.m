// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLTwitterError.m
// Project: FishLamp
// Schema: Twitter
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLTwitterError.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLTwitterError


@synthesize error = __error;
@synthesize request = __request;

+ (NSString*) errorKey
{
    return @"error";
}

+ (NSString*) requestKey
{
    return @"request";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLTwitterError*)object).error = FLCopyOrRetainObject(__error);
    ((FLTwitterError*)object).request = FLCopyOrRetainObject(__request);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__error);
    FLRelease(__request);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__error) [aCoder encodeObject:__error forKey:@"__error"];
    if(__request) [aCoder encodeObject:__request forKey:@"__request"];
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
        __error = FLReturnRetained([aDecoder decodeObjectForKey:@"__error"]);
        __request = FLReturnRetained([aDecoder decodeObjectForKey:@"__request"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"error" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"error"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"request" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"request"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"error" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"request" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

+ (FLTwitterError*) twitterError
{
    return FLReturnAutoreleased([[FLTwitterError alloc] init]);
}

@end

@implementation FLTwitterError (ValueProperties) 
@end

// [/Generated]
