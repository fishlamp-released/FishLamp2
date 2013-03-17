// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookInsights.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookInsights.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLFacebookInsight.h"

@implementation FLFacebookInsights


@synthesize period = __period;
@synthesize values = __values;

+ (NSString*) periodKey
{
    return @"period";
}

+ (NSString*) valuesKey
{
    return @"values";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookInsights*)object).period = FLCopyOrRetainObject(__period);
    ((FLFacebookInsights*)object).values = FLCopyOrRetainObject(__values);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__period);
    FLRelease(__values);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__period) [aCoder encodeObject:__period forKey:@"__period"];
    if(__values) [aCoder encodeObject:__values forKey:@"__values"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookInsights*) facebookInsights
{
    return FLAutorelease([[FLFacebookInsights alloc] init]);
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
    if((self = [super initWithCoder:aDecoder]))
    {
        __period = FLRetain([aDecoder decodeObjectForKey:@"__period"]);
        __values = [[aDecoder decodeObjectForKey:@"__values"] mutableCopy];
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
        [s_describer addProperty:@"period" withClass:[NSString class]];
        [s_describer addArrayProperty:@"values" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"insights" propertyClass:[FLFacebookInsight class]], nil]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"period" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"values" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookInsights (ValueProperties) 
@end

// [/Generated]
