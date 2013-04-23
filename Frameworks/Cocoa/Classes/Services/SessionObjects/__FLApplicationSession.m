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

#import "FLDatabaseTable.h"

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
    return FLAutorelease([[FLApplicationSession alloc] init]);
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
        __sessionId = FLRetain([aDecoder decodeObjectForKey:@"__sessionId"]);
        __userGuid = FLRetain([aDecoder decodeObjectForKey:@"__userGuid"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        

        [describer setChildForIdentifier:@"sessionId" withClass:[FLIntegerNumber class] ];
        [describer setChildForIdentifier:@"userGuid" withClass:[NSString class]];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
}

- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sessionId" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"userGuid" columnType:FLDatabaseTypeText columnConstraints:nil]];
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
