// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookUpdateStatusOperation.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookUpdateStatusOperation.h"
#import "FLFacebookStatusMessage.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookUpdateStatusOperation


@synthesize input = __input;
@synthesize output = __output;

+ (NSString*) inputKey
{
    return @"input";
}

+ (NSString*) outputKey
{
    return @"output";
}

- (void) dealloc
{
    FLRelease(__input);
    FLRelease(__output);
    FLSuperDealloc();
}

+ (FLFacebookUpdateStatusOperation*) facebookUpdateStatusOperation
{
    return FLReturnAutoreleased([[FLFacebookUpdateStatusOperation alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"input" propertyClass:[FLFacebookStatusMessage class] propertyType:FLDataTypeObject] forPropertyName:@"input"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"output" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"output"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"input" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"output" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookUpdateStatusOperation (ValueProperties) 
@end

// [/Generated]
