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
    FLRelease(__name);
    FLRelease(__className);
    FLRelease(__fontSize);
    FLSuperDealloc();
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
        __name = FLRetain([aDecoder decodeObjectForKey:@"__name"]);
        __className = FLRetain([aDecoder decodeObjectForKey:@"__className"]);
        __fontSize = FLRetain([aDecoder decodeObjectForKey:@"__fontSize"]);
    }
    return self;
}

+ (FLSavedThemeInfo*) savedThemeInfo
{
    return FLAutorelease([[FLSavedThemeInfo alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        

        [describer setPropertyDescriber:[FLObjectDescriber objectDescriber:@"name" objectClass:[NSString class] objectDescriber:FLDataTypeString] forPropertyName:@"name"];
        [describer setPropertyDescriber:[FLObjectDescriber objectDescriber:@"className" objectClass:[NSString class] objectDescriber:FLDataTypeString] forPropertyName:@"className"];
        [describer setPropertyDescriber:[FLObjectDescriber objectDescriber:@"fontSize" objectClass:[NSNumber class] objectDescriber:FLDataTypeInteger] forPropertyName:@"fontSize"];
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

+ (FLDatabaseTable*) sharedDatabaseTable
{
    static FLDatabaseTable* s_table = nil;
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]];
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
