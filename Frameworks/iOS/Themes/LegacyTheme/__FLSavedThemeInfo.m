// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSavedThemeInfo.m
// Project: FishLamp
// Schema: FLGeneratedCoreObject
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSavedThemeInfo.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLSavedThemeInfo


@synthesize className = __className;
@synthesize fontSize = __fontSize;
@synthesize name = __name;

+ (NSString*) classNameKey
{
    return @"className";
}

+ (NSString*) fontSizeKey
{
    return @"fontSize";
}

+ (NSString*) nameKey
{
    return @"name";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLSavedThemeInfo*)object).name = FLCopyOrRetainObject(__name);
    ((FLSavedThemeInfo*)object).className = FLCopyOrRetainObject(__className);
    ((FLSavedThemeInfo*)object).fontSize = FLCopyOrRetainObject(__fontSize);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    release_(__name);
    release_(__className);
    release_(__fontSize);
    super_dealloc_();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__name) [aCoder encodeObject:__name forKey:@"__name"];
    if(__className) [aCoder encodeObject:__className forKey:@"__className"];
    if(__fontSize) [aCoder encodeObject:__fontSize forKey:@"__fontSize"];
    [super encodeWithCoder:aCoder];
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
        __name = retain_([aDecoder decodeObjectForKey:@"__name"]);
        __className = retain_([aDecoder decodeObjectForKey:@"__className"]);
        __fontSize = retain_([aDecoder decodeObjectForKey:@"__fontSize"]);
    }
    return self;
}

+ (FLSavedThemeInfo*) savedThemeInfo
{
    return autorelease_([[FLSavedThemeInfo alloc] init]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"name"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"className" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"className"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"fontSize" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"fontSize"];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"className" columnType:FLDatabaseTypeText columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"fontSize" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
    });
    return s_table;
}

@end

@implementation FLSavedThemeInfo (ValueProperties) 

- (int) fontSizeValue
{
    return [self.fontSize intValue];
}

- (void) setFontSizeValue:(int) value
{
    self.fontSize = [NSNumber numberWithInt:value];
}
@end

// [/Generated]
