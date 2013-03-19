// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookAuthenticationResponse.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookAuthenticationResponse.h"
#import "FLFacebookNetworkSession.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookAuthenticationResponse


@synthesize redirectURL = __redirectURL;
@synthesize session = __session;

+ (NSString*) redirectURLKey
{
    return @"redirectURL";
}

+ (NSString*) sessionKey
{
    return @"session";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookAuthenticationResponse*)object).session = FLCopyOrRetainObject(__session);
    ((FLFacebookAuthenticationResponse*)object).redirectURL = FLCopyOrRetainObject(__redirectURL);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__session);
    FLRelease(__redirectURL);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__session) [aCoder encodeObject:__session forKey:@"__session"];
    if(__redirectURL) [aCoder encodeObject:__redirectURL forKey:@"__redirectURL"];
}

+ (FLFacebookAuthenticationResponse*) facebookAuthenticationResponse
{
    return FLAutorelease([[FLFacebookAuthenticationResponse alloc] init]);
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
        __session = FLRetain([aDecoder decodeObjectForKey:@"__session"]);
        __redirectURL = FLRetain([aDecoder decodeObjectForKey:@"__redirectURL"]);
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
        [s_describer addProperty:@"session" withClass:[FLFacebookNetworkSession class] ];
        
        [s_describer addProperty:@"redirectURL" withClass:[NSURL class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"session" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"redirectURL" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookAuthenticationResponse (ValueProperties) 
@end

// [/Generated]
