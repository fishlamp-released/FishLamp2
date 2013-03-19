// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookError.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookError.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLFacebookError


@synthesize error = __error;
@synthesize error_description = __error_description;
@synthesize error_reason = __error_reason;
@synthesize externalUrl = __externalUrl;

+ (NSString*) errorKey
{
    return @"error";
}

+ (NSString*) error_descriptionKey
{
    return @"error_description";
}

+ (NSString*) error_reasonKey
{
    return @"error_reason";
}

+ (NSString*) externalUrlKey
{
    return @"externalUrl";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookError*)object).error_reason = FLCopyOrRetainObject(__error_reason);
    ((FLFacebookError*)object).error_description = FLCopyOrRetainObject(__error_description);
    ((FLFacebookError*)object).externalUrl = FLCopyOrRetainObject(__externalUrl);
    ((FLFacebookError*)object).error = FLCopyOrRetainObject(__error);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__error_reason);
    FLRelease(__error);
    FLRelease(__error_description);
    FLRelease(__externalUrl);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__error_reason) [aCoder encodeObject:__error_reason forKey:@"__error_reason"];
    if(__error) [aCoder encodeObject:__error forKey:@"__error"];
    if(__error_description) [aCoder encodeObject:__error_description forKey:@"__error_description"];
    if(__externalUrl) [aCoder encodeObject:__externalUrl forKey:@"__externalUrl"];
}

+ (FLFacebookError*) facebookError
{
    return FLAutorelease([[FLFacebookError alloc] init]);
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
        __error_reason = FLRetain([aDecoder decodeObjectForKey:@"__error_reason"]);
        __error = FLRetain([aDecoder decodeObjectForKey:@"__error"]);
        __error_description = FLRetain([aDecoder decodeObjectForKey:@"__error_description"]);
        __externalUrl = FLRetain([aDecoder decodeObjectForKey:@"__externalUrl"]);
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
        [s_describer addProperty:@"error_reason" withClass:[NSString class]];
        [s_describer addProperty:@"error" withClass:[NSString class]];
        [s_describer addProperty:@"error_description" withClass:[NSString class]];
        [s_describer addProperty:@"externalUrl" withClass:[NSString class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"error_reason" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"error" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"error_description" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"externalUrl" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookError (ValueProperties) 
@end

// [/Generated]
