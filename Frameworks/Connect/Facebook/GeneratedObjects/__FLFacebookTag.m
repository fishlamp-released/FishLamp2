// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookTag.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookTag.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookTag


@synthesize user = __user;
@synthesize x = __x;
@synthesize y = __y;

+ (NSString*) userKey
{
    return @"user";
}

+ (NSString*) xKey
{
    return @"x";
}

+ (NSString*) yKey
{
    return @"y";
}

- (void) dealloc
{
    FLRelease(__user);
    FLRelease(__x);
    FLRelease(__y);
    FLSuperDealloc();
}

+ (FLFacebookTag*) facebookTag
{
    return FLAutorelease([[FLFacebookTag alloc] init]);
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
        [s_describer addProperty:@"user" withClass:[FLFacebookNamedObject class]];
        [s_describer addProperty:@"x" withClass:[FLIntegerNumber class] ];
        [s_describer addProperty:@"y" withClass:[FLIntegerNumber class] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"user" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"x" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"y" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookTag (ValueProperties) 

- (int) xValue
{
    return [self.x intValue];
}

- (void) setXValue:(int) value
{
    self.x = [NSNumber numberWithInt:value];
}

- (int) yValue
{
    return [self.y intValue];
}

- (void) setYValue:(int) value
{
    self.y = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
