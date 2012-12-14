// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookLoadUserPictureOperationInput.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookLoadUserPictureOperationInput.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookLoadUserPictureOperationInput


@synthesize pictureSize = __pictureSize;
@synthesize type = __type;

+ (NSString*) pictureSizeKey
{
    return @"pictureSize";
}

+ (NSString*) typeKey
{
    return @"type";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookLoadUserPictureOperationInput*)object).type = FLCopyOrRetainObject(__type);
    ((FLFacebookLoadUserPictureOperationInput*)object).pictureSize = FLCopyOrRetainObject(__pictureSize);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__type);
    FLRelease(__pictureSize);
    super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__type) [aCoder encodeObject:__type forKey:@"__type"];
    if(__pictureSize) [aCoder encodeObject:__pictureSize forKey:@"__pictureSize"];
}

+ (FLFacebookLoadUserPictureOperationInput*) facebookLoadUserPictureOperationInput
{
    return FLAutorelease([[FLFacebookLoadUserPictureOperationInput alloc] init]);
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
        __type = FLRetain([aDecoder decodeObjectForKey:@"__type"]);
        __pictureSize = FLRetain([aDecoder decodeObjectForKey:@"__pictureSize"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"type"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"pictureSize" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"pictureSize"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"pictureSize" columnType:FLDatabaseTypeText columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookLoadUserPictureOperationInput (ValueProperties) 
@end

// [/Generated]
