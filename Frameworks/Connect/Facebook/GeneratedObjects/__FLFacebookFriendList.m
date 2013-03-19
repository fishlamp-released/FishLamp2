// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookFriendList.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookFriendList.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLFacebookNamedObject.h"

@implementation FLFacebookFriendList


@synthesize friends = __friends;

+ (NSString*) friendsKey
{
    return @"friends";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookFriendList*)object).friends = FLCopyOrRetainObject(__friends);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__friends);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__friends) [aCoder encodeObject:__friends forKey:@"__friends"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookFriendList*) facebookFriendList
{
    return FLAutorelease([[FLFacebookFriendList alloc] init]);
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
        __friends = [[aDecoder decodeObjectForKey:@"__friends"] mutableCopy];
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
        [s_describer addProperty:@"friends" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"friend" objectClass:[FLFacebookNamedObject class]], nil]];
    });
    return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
    static FLObjectInflator* s_inflator = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"friends" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookFriendList (ValueProperties) 
@end

// [/Generated]
