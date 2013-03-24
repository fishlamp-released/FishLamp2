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
        __faultcode = FLRetain([aDecoder decodeObjectForKey:@"__faultcode"]);
        __faultstring = FLRetain([aDecoder decodeObjectForKey:@"__faultstring"]);
        __faultactor = FLRetain([aDecoder decodeObjectForKey:@"__faultactor"]);
        __detail = FLRetain([aDecoder decodeObjectForKey:@"__detail"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    static FLObjectDescriber* s_describer = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
        if(!s_describer)
        {
            s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
        }
        [s_describer addProperty:@"faultcode" withClass:[NSString class]];
        [s_describer addProperty:@"faultstring" withClass:[NSString class]];
        [s_describer addProperty:@"faultactor" withClass:[NSString class]];
        [s_describer addProperty:@"detail" withClass:[NSString class]];
    });
    return s_describer;
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
    return FLAutorelease([[FLSoapFault11 alloc] init]);
}

@end

@implementation FLSoapFault11 (ValueProperties) 
@end

// [/Generated]
