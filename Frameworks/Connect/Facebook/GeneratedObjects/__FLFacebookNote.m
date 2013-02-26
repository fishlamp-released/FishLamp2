// [Generated]
//
// This file was generated at 6/18/12 2:04 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLFacebookNote.m
// Project: FishLamp Connect
// Schema: Facebook
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLFacebookNote.h"
#import "FLFacebookNamedObject.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLFacebookNote


@synthesize created_time = __created_time;
@synthesize from = __from;
@synthesize icon = __icon;
@synthesize message = __message;
@synthesize subject = __subject;
@synthesize updated_time = __updated_time;

+ (NSString*) created_timeKey
{
    return @"created_time";
}

+ (NSString*) fromKey
{
    return @"from";
}

+ (NSString*) iconKey
{
    return @"icon";
}

+ (NSString*) messageKey
{
    return @"message";
}

+ (NSString*) subjectKey
{
    return @"subject";
}

+ (NSString*) updated_timeKey
{
    return @"updated_time";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLFacebookNote*)object).updated_time = FLCopyOrRetainObject(__updated_time);
    ((FLFacebookNote*)object).message = FLCopyOrRetainObject(__message);
    ((FLFacebookNote*)object).subject = FLCopyOrRetainObject(__subject);
    ((FLFacebookNote*)object).icon = FLCopyOrRetainObject(__icon);
    ((FLFacebookNote*)object).created_time = FLCopyOrRetainObject(__created_time);
    ((FLFacebookNote*)object).from = FLCopyOrRetainObject(__from);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__from);
    FLRelease(__subject);
    FLRelease(__message);
    FLRelease(__icon);
    FLRelease(__updated_time);
    FLRelease(__created_time);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__from) [aCoder encodeObject:__from forKey:@"__from"];
    if(__subject) [aCoder encodeObject:__subject forKey:@"__subject"];
    if(__message) [aCoder encodeObject:__message forKey:@"__message"];
    if(__icon) [aCoder encodeObject:__icon forKey:@"__icon"];
    if(__updated_time) [aCoder encodeObject:__updated_time forKey:@"__updated_time"];
    if(__created_time) [aCoder encodeObject:__created_time forKey:@"__created_time"];
    [super encodeWithCoder:aCoder];
}

+ (FLFacebookNote*) facebookNote
{
    return FLAutorelease([[FLFacebookNote alloc] init]);
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
        __from = FLRetain([aDecoder decodeObjectForKey:@"__from"]);
        __subject = FLRetain([aDecoder decodeObjectForKey:@"__subject"]);
        __message = FLRetain([aDecoder decodeObjectForKey:@"__message"]);
        __icon = FLRetain([aDecoder decodeObjectForKey:@"__icon"]);
        __updated_time = FLRetain([aDecoder decodeObjectForKey:@"__updated_time"]);
        __created_time = FLRetain([aDecoder decodeObjectForKey:@"__created_time"]);
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
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"from" propertyClass:[FLFacebookNamedObject class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"subject" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] ] ];
        [s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] ] ];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"from" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"subject" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"message" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"icon" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updated_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"created_time" columnType:FLDatabaseTypeDate columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLFacebookNote (ValueProperties) 
@end

// [/Generated]
