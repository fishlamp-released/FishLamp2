// [Generated]
//
// This file was generated at 6/2/12 5:43 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLViewGradients.m
// Project: FishLamp Themes
// Schema: FLThemeObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLViewGradients.h"
#import "__FLThemeObjectsEnums.h"
#import "FLColorRange.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLViewGradients


@synthesize disabledGradient = __disabledGradient;
@synthesize disabledGradientEnum = __disabledGradientEnum;
@synthesize highlightedGradient = __highlightedGradient;
@synthesize highlightedGradientEnum = __highlightedGradientEnum;
@synthesize normalGradient = __normalGradient;
@synthesize normalGradientEnum = __normalGradientEnum;
@synthesize selectedGradient = __selectedGradient;
@synthesize selectedGradientEnum = __selectedGradientEnum;

+ (NSString*) disabledGradientEnumKey
{
    return @"disabledGradientEnum";
}

+ (NSString*) disabledGradientKey
{
    return @"disabledGradient";
}

+ (NSString*) highlightedGradientEnumKey
{
    return @"highlightedGradientEnum";
}

+ (NSString*) highlightedGradientKey
{
    return @"highlightedGradient";
}

+ (NSString*) normalGradientEnumKey
{
    return @"normalGradientEnum";
}

+ (NSString*) normalGradientKey
{
    return @"normalGradient";
}

+ (NSString*) selectedGradientEnumKey
{
    return @"selectedGradientEnum";
}

+ (NSString*) selectedGradientKey
{
    return @"selectedGradient";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLViewGradients*)object).highlightedGradientEnum = FLCopyOrRetainObject(__highlightedGradientEnum);
    ((FLViewGradients*)object).highlightedGradient = FLCopyOrRetainObject(__highlightedGradient);
    ((FLViewGradients*)object).selectedGradient = FLCopyOrRetainObject(__selectedGradient);
    ((FLViewGradients*)object).disabledGradient = FLCopyOrRetainObject(__disabledGradient);
    ((FLViewGradients*)object).selectedGradientEnum = FLCopyOrRetainObject(__selectedGradientEnum);
    ((FLViewGradients*)object).normalGradient = FLCopyOrRetainObject(__normalGradient);
    ((FLViewGradients*)object).normalGradientEnum = FLCopyOrRetainObject(__normalGradientEnum);
    ((FLViewGradients*)object).disabledGradientEnum = FLCopyOrRetainObject(__disabledGradientEnum);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__normalGradientEnum);
    FLRelease(__selectedGradientEnum);
    FLRelease(__highlightedGradientEnum);
    FLRelease(__disabledGradientEnum);
    FLRelease(__normalGradient);
    FLRelease(__selectedGradient);
    FLRelease(__highlightedGradient);
    FLRelease(__disabledGradient);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__normalGradientEnum) [aCoder encodeObject:__normalGradientEnum forKey:@"__normalGradientEnum"];
    if(__selectedGradientEnum) [aCoder encodeObject:__selectedGradientEnum forKey:@"__selectedGradientEnum"];
    if(__highlightedGradientEnum) [aCoder encodeObject:__highlightedGradientEnum forKey:@"__highlightedGradientEnum"];
    if(__disabledGradientEnum) [aCoder encodeObject:__disabledGradientEnum forKey:@"__disabledGradientEnum"];
    if(__normalGradient) [aCoder encodeObject:__normalGradient forKey:@"__normalGradient"];
    if(__selectedGradient) [aCoder encodeObject:__selectedGradient forKey:@"__selectedGradient"];
    if(__highlightedGradient) [aCoder encodeObject:__highlightedGradient forKey:@"__highlightedGradient"];
    if(__disabledGradient) [aCoder encodeObject:__disabledGradient forKey:@"__disabledGradient"];
}

- (id) init
{
    if((self = [super init]))
    {
        self.normalGradientEnumValue = FLColorRangeEnumDarkGray;
        self.selectedGradientEnumValue = FLColorRangeEnumGray;
        self.highlightedGradientEnumValue = FLColorRangeEnumIPhoneBlue;
        self.disabledGradientEnumValue = FLColorRangeEnumLightGray;
    }
    return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
    if((self = [super init]))
    {
        __normalGradientEnum = FLReturnRetained([aDecoder decodeObjectForKey:@"__normalGradientEnum"]);
        __selectedGradientEnum = FLReturnRetained([aDecoder decodeObjectForKey:@"__selectedGradientEnum"]);
        __highlightedGradientEnum = FLReturnRetained([aDecoder decodeObjectForKey:@"__highlightedGradientEnum"]);
        __disabledGradientEnum = FLReturnRetained([aDecoder decodeObjectForKey:@"__disabledGradientEnum"]);
        __normalGradient = FLReturnRetained([aDecoder decodeObjectForKey:@"__normalGradient"]);
        __selectedGradient = FLReturnRetained([aDecoder decodeObjectForKey:@"__selectedGradient"]);
        __highlightedGradient = FLReturnRetained([aDecoder decodeObjectForKey:@"__highlightedGradient"]);
        __disabledGradient = FLReturnRetained([aDecoder decodeObjectForKey:@"__disabledGradient"]);
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"normalGradientEnum" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"normalGradientEnum"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"selectedGradientEnum" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"selectedGradientEnum"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"highlightedGradientEnum" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"highlightedGradientEnum"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"disabledGradientEnum" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"disabledGradientEnum"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"normalGradient" propertyClass:[FLColorRange class] propertyType:FLDataTypeObject] forPropertyName:@"normalGradient"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"selectedGradient" propertyClass:[FLColorRange class] propertyType:FLDataTypeObject] forPropertyName:@"selectedGradient"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"highlightedGradient" propertyClass:[FLColorRange class] propertyType:FLDataTypeObject] forPropertyName:@"highlightedGradient"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"disabledGradient" propertyClass:[FLColorRange class] propertyType:FLDataTypeObject] forPropertyName:@"disabledGradient"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"normalGradientEnum" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"selectedGradientEnum" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"highlightedGradientEnum" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"disabledGradientEnum" columnType:FLSqliteTypeText columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"normalGradient" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"selectedGradient" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"highlightedGradient" columnType:FLSqliteTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"disabledGradient" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

+ (FLViewGradients*) viewGradients
{
    return FLReturnAutoreleased([[FLViewGradients alloc] init]);
}

@end

@implementation FLViewGradients (ValueProperties) 

- (FLColorRangeEnum) normalGradientEnumValue
{
    return [[FLThemeObjectsEnumLookup instance] colorRangeEnumFromString:self.normalGradientEnum];
}

- (void) setNormalGradientEnumValue:(FLColorRangeEnum) inEnumValue
{
    self.normalGradientEnum = [[FLThemeObjectsEnumLookup instance] stringFromColorRangeEnum:inEnumValue];
}

- (FLColorRangeEnum) selectedGradientEnumValue
{
    return [[FLThemeObjectsEnumLookup instance] colorRangeEnumFromString:self.selectedGradientEnum];
}

- (void) setSelectedGradientEnumValue:(FLColorRangeEnum) inEnumValue
{
    self.selectedGradientEnum = [[FLThemeObjectsEnumLookup instance] stringFromColorRangeEnum:inEnumValue];
}

- (FLColorRangeEnum) highlightedGradientEnumValue
{
    return [[FLThemeObjectsEnumLookup instance] colorRangeEnumFromString:self.highlightedGradientEnum];
}

- (void) setHighlightedGradientEnumValue:(FLColorRangeEnum) inEnumValue
{
    self.highlightedGradientEnum = [[FLThemeObjectsEnumLookup instance] stringFromColorRangeEnum:inEnumValue];
}

- (FLColorRangeEnum) disabledGradientEnumValue
{
    return [[FLThemeObjectsEnumLookup instance] colorRangeEnumFromString:self.disabledGradientEnum];
}

- (void) setDisabledGradientEnumValue:(FLColorRangeEnum) inEnumValue
{
    self.disabledGradientEnum = [[FLThemeObjectsEnumLookup instance] stringFromColorRangeEnum:inEnumValue];
}
@end

// [/Generated]
