// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLApplicationSession.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLApplicationSession.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLApplicationSession


@synthesize sessionId = __sessionId;
@synthesize userGuid = __userGuid;

+ (NSString*) sessionIdKey
{
    return @"sessionId";
}

+ (NSString*) userGuidKey
{
    return @"userGuid";
}

+ (FLApplicationSession*) applicationSession
{
    return FLReturnAutoreleased([[FLApplicationSession alloc] init]);
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLApplicationSession*)object).sessionId = FLCopyOrRetainObject(__sessionId);
    ((FLApplicationSession*)object).userGuid = FLCopyOrRetainObject(__userGuid);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__sessionId);
    FLRelease(__userGuid);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__sessionId) [aCoder encodeObject:__sessionId forKey:@"__sessionId"];
    if(__userGuid) [aCoder encodeObject:__userGuid forKey:@"__userGuid"];
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
        __sessionId = FLReturnRetained([aDecoder decodeObjectForKey:@"__sessionId"]);
        __userGuid = FLReturnRetained([aDecoder decodeObjectForKey:@"__userGuid"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"sessionId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"sessionId"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"userGuid"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"sessionId" columnType:FLSqliteTypeInteger columnConstraints:[NSArray arrayWithObject:[FLSqliteColumn primaryKeyConstraint]]]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"userGuid" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLApplicationSession (ValueProperties) 

- (int) sessionIdValue
{
    return [self.sessionId intValue];
}

- (void) setSessionIdValue:(int) value
{
    self.sessionId = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
