// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSoapFault11.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSoapFault11.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLSoapFault11


@synthesize detail = __detail;
@synthesize faultactor = __faultactor;
@synthesize faultcode = __faultcode;
@synthesize faultstring = __faultstring;

+ (NSString*) detailKey
{
    return @"detail";
}

+ (NSString*) faultactorKey
{
    return @"faultactor";
}

+ (NSString*) faultcodeKey
{
    return @"faultcode";
}

+ (NSString*) faultstringKey
{
    return @"faultstring";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLSoapFault11*)object).faultactor = FLCopyOrRetainObject(__faultactor);
    ((FLSoapFault11*)object).detail = FLCopyOrRetainObject(__detail);
    ((FLSoapFault11*)object).faultstring = FLCopyOrRetainObject(__faultstring);
    ((FLSoapFault11*)object).faultcode = FLCopyOrRetainObject(__faultcode);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__faultcode);
    FLRelease(__faultstring);
    FLRelease(__faultactor);
    FLRelease(__detail);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__faultcode) [aCoder encodeObject:__faultcode forKey:@"__faultcode"];
    if(__faultstring) [aCoder encodeObject:__faultstring forKey:@"__faultstring"];
    if(__faultactor) [aCoder encodeObject:__faultactor forKey:@"__faultactor"];
    if(__detail) [aCoder encodeObject:__detail forKey:@"__detail"];
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
        __faultcode = FLReturnRetained([aDecoder decodeObjectForKey:@"__faultcode"]);
        __faultstring = FLReturnRetained([aDecoder decodeObjectForKey:@"__faultstring"]);
        __faultactor = FLReturnRetained([aDecoder decodeObjectForKey:@"__faultactor"]);
        __detail = FLReturnRetained([aDecoder decodeObjectForKey:@"__detail"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"faultcode" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"faultcode"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"faultstring" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"faultstring"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"faultactor" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"faultactor"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"detail" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"detail"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"faultcode" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"faultstring" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"faultactor" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"detail" columnType:FLSqliteTypeText columnConstraints:nil]];
    });
    return s_table;
}

+ (FLSoapFault11*) soapFault11
{
    return FLReturnAutoreleased([[FLSoapFault11 alloc] init]);
}

@end

@implementation FLSoapFault11 (ValueProperties) 
@end

// [/Generated]
