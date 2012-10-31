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
#import "FLDatabaseTable.h"

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
    mrc_release_(__faultcode);
    mrc_release_(__faultstring);
    mrc_release_(__faultactor);
    mrc_release_(__detail);
    mrc_super_dealloc_();
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
        __faultcode = retain_([aDecoder decodeObjectForKey:@"__faultcode"]);
        __faultstring = retain_([aDecoder decodeObjectForKey:@"__faultstring"]);
        __faultactor = retain_([aDecoder decodeObjectForKey:@"__faultactor"]);
        __detail = retain_([aDecoder decodeObjectForKey:@"__detail"]);
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"faultcode" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"faultstring" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"faultactor" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"detail" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

+ (FLSoapFault11*) soapFault11
{
    return autorelease_([[FLSoapFault11 alloc] init]);
}

@end

@implementation FLSoapFault11 (ValueProperties) 
@end

// [/Generated]
