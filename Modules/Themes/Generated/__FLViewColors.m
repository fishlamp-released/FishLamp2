// [Generated]
//
// This file was generated at 5/31/12 5:54 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLViewColors.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewColors.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLViewColors


@synthesize disabledColor = __disabledColor;
@synthesize highlightedColor = __highlightedColor;
@synthesize normalColor = __normalColor;
@synthesize selectedColor = __selectedColor;

+ (NSString*) disabledColorKey
{
    return @"disabledColor";
}

+ (NSString*) highlightedColorKey
{
    return @"highlightedColor";
}

+ (NSString*) normalColorKey
{
    return @"normalColor";
}

+ (NSString*) selectedColorKey
{
    return @"selectedColor";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLViewColors*)object).normalColor = FLCopyOrRetainObject(__normalColor);
    ((FLViewColors*)object).highlightedColor = FLCopyOrRetainObject(__highlightedColor);
    ((FLViewColors*)object).disabledColor = FLCopyOrRetainObject(__disabledColor);
    ((FLViewColors*)object).selectedColor = FLCopyOrRetainObject(__selectedColor);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__normalColor);
    FLRelease(__selectedColor);
    FLRelease(__highlightedColor);
    FLRelease(__disabledColor);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__normalColor) [aCoder encodeObject:__normalColor forKey:@"__normalColor"];
    if(__selectedColor) [aCoder encodeObject:__selectedColor forKey:@"__selectedColor"];
    if(__highlightedColor) [aCoder encodeObject:__highlightedColor forKey:@"__highlightedColor"];
    if(__disabledColor) [aCoder encodeObject:__disabledColor forKey:@"__disabledColor"];
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
        __normalColor = FLReturnRetained([aDecoder decodeObjectForKey:@"__normalColor"]);
        __selectedColor = FLReturnRetained([aDecoder decodeObjectForKey:@"__selectedColor"]);
        __highlightedColor = FLReturnRetained([aDecoder decodeObjectForKey:@"__highlightedColor"]);
        __disabledColor = FLReturnRetained([aDecoder decodeObjectForKey:@"__disabledColor"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"normalColor" propertyClass:[CocoaColor class] propertyType:FLDataTypeColor] forPropertyName:@"normalColor"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"selectedColor" propertyClass:[CocoaColor class] propertyType:FLDataTypeColor] forPropertyName:@"selectedColor"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"highlightedColor" propertyClass:[CocoaColor class] propertyType:FLDataTypeColor] forPropertyName:@"highlightedColor"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"disabledColor" propertyClass:[CocoaColor class] propertyType:FLDataTypeColor] forPropertyName:@"disabledColor"];
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

+ (FLSqliteTable*) sharedSqliteTable
{
    static FLSqliteTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        FLSqliteTable* superTable = [super sharedSqliteTable];
        if(superTable)
        {
            s_table = [superTable copy];
            s_table.tableName = [self sqliteTableName];
        }
        else
        {
            s_table = [[FLSqliteTable alloc] initWithTableName:[self sqliteTableName]];
        }
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"normalColor" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"selectedColor" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"highlightedColor" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"disabledColor" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

+ (FLViewColors*) viewColors
{
    return FLReturnAutoreleased([[FLViewColors alloc] init]);
}

@end

@implementation FLViewColors (ValueProperties) 
@end

// [/Generated]
