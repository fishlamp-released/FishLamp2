// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLLastUpdateTime.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLLastUpdateTime.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLLastUpdateTime


@synthesize lastUpdate = __lastUpdate;
@synthesize lastUpdateId = __lastUpdateId;

+ (NSString*) lastUpdateIdKey
{
    return @"lastUpdateId";
}

+ (NSString*) lastUpdateKey
{
    return @"lastUpdate";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLLastUpdateTime*)object).lastUpdateId = FLCopyOrRetainObject(__lastUpdateId);
    ((FLLastUpdateTime*)object).lastUpdate = FLCopyOrRetainObject(__lastUpdate);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__lastUpdateId);
    FLRelease(__lastUpdate);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__lastUpdateId) [aCoder encodeObject:__lastUpdateId forKey:@"__lastUpdateId"];
    if(__lastUpdate) [aCoder encodeObject:__lastUpdate forKey:@"__lastUpdate"];
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
        __lastUpdateId = FLRetain([aDecoder decodeObjectForKey:@"__lastUpdateId"]);
        __lastUpdate = FLRetain([aDecoder decodeObjectForKey:@"__lastUpdate"]);
    }
    return self;
}

+ (FLLastUpdateTime*) lastUpdateTime
{
    return FLAutorelease([[FLLastUpdateTime alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        

        [describer setChildForIdentifier:@"lastUpdateId" withClass:[NSString class]];
        [describer setChildForIdentifier:@"lastUpdate" withClass:[NSDate class]];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
}



+ (FLDatabaseTable*) sharedDatabaseTable
{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastUpdateId" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastUpdate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLLastUpdateTime (ValueProperties) 
@end

// [/Generated]
