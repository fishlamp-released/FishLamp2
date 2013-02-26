// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookFetchStatusListResponse.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookFetchStatusListResponse.h"
#import "FLFacebookPagingResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLFacebookPost.h"

@implementation FLFacebookFetchStatusListResponse


@synthesize data = __data;
@synthesize paging = __paging;

+ (NSString*) dataKey
{
    return @"data";
}

+ (NSString*) pagingKey
{
    return @"paging";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookFetchStatusListResponse*)object).data = FLCopyOrRetainObject(__data);
    ((FLFacebookFetchStatusListResponse*)object).paging = FLCopyOrRetainObject(__paging);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__paging);
    FLRelease(__data);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__paging) [aCoder encodeObject:__paging forKey:@"__paging"];
    if(__data) [aCoder encodeObject:__data forKey:@"__data"];
}

+ (FLFacebookFetchStatusListResponse*) facebookFetchStatusListResponse
{
    return FLAutorelease([[FLFacebookFetchStatusListResponse alloc] init]);
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
        __paging = FLRetain([aDecoder decodeObjectForKey:@"__paging"]);
        __data = [[aDecoder decodeObjectForKey:@"__data"] mutableCopy];
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
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"paging" propertyClass:[FLFacebookPagingResponse class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"data" propertyClass:[NSMutableArray class]  arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"post" propertyClass:[FLFacebookPost class]], nil] isUnboundedArray:NO] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"paging" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"data" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookFetchStatusListResponse (ValueProperties) 
@end

// [/Generated]
