// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLApplicationDataVersion.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLApplicationDataVersion.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLApplicationDataVersion


@synthesize userGuid = __userGuid;
@synthesize versionString = __versionString;

+ (NSString*) userGuidKey
{
    return @"userGuid";
}

+ (NSString*) versionStringKey
{
    return @"versionString";
}

+ (FLApplicationDataVersion*) applicationDataVersion
{
    return FLAutorelease([[FLApplicationDataVersion alloc] init]);
}

- (void) dealloc
{
    FLRelease(__userGuid);
    FLRelease(__versionString);
    FLSuperDealloc();
}

- (id) init
{
    if((self = [super init]))
    {
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
		
        [describer setChildForIdentifier:@"userGuid" withClass:[NSString class]];
        [describer setChildForIdentifier:@"versionString" withClass:[NSString class]];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];        
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userGuid" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"versionString" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLApplicationDataVersion (ValueProperties) 
@end

// [/Generated]
