// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookActionList.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookActionList.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"
#import "FLFacebookAction.h"

@implementation FLFacebookActionList


@synthesize count = __count;
@synthesize data = __data;

+ (NSString*) countKey
{
    return @"count";
}

+ (NSString*) dataKey
{
    return @"data";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookActionList*)object).count = FLCopyOrRetainObject(__count);
    ((FLFacebookActionList*)object).data = FLCopyOrRetainObject(__data);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__count);
    FLRelease(__data);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__count) [aCoder encodeObject:__count forKey:@"__count"];
    if(__data) [aCoder encodeObject:__data forKey:@"__data"];
}

+ (FLFacebookActionList*) facebookActionList
{
    return FLReturnAutoreleased([[FLFacebookActionList alloc] init]);
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
        __count = FLReturnRetained([aDecoder decodeObjectForKey:@"__count"]);
        __data = [[aDecoder decodeObjectForKey:@"__data"] mutableCopy];
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"count" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"count"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"data" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"like" propertyClass:[FLFacebookAction class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"data"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"count" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"data" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookActionList (ValueProperties) 

- (int) countValue
{
    return [self.count intValue];
}

- (void) setCountValue:(int) value
{
    self.count = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
