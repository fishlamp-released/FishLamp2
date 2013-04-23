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

#import "FLDatabaseTable.h"

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
        __normalColor = FLRetain([aDecoder decodeObjectForKey:@"__normalColor"]);
        __selectedColor = FLRetain([aDecoder decodeObjectForKey:@"__selectedColor"]);
        __highlightedColor = FLRetain([aDecoder decodeObjectForKey:@"__highlightedColor"]);
        __disabledColor = FLRetain([aDecoder decodeObjectForKey:@"__disabledColor"]);
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        

        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"normalColor" objectClass:[UIColor class] objectDescriber:FLDataTypeColor] forPropertyName:@"normalColor"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"selectedColor" objectClass:[UIColor class] objectDescriber:FLDataTypeColor] forPropertyName:@"selectedColor"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"highlightedColor" objectClass:[UIColor class] objectDescriber:FLDataTypeColor] forPropertyName:@"highlightedColor"];
        [describer setPropertyDescriber:[FLPropertyDescriber propertyDescriber:@"disabledColor" objectClass:[UIColor class] objectDescriber:FLDataTypeColor] forPropertyName:@"disabledColor"];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"normalColor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"selectedColor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"highlightedColor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"disabledColor" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

+ (FLViewColors*) viewColors
{
    return FLAutorelease([[FLViewColors alloc] init]);
}

@end

@implementation FLViewColors (ValueProperties) 
@end

// [/Generated]
