// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSlideshowOptions.m
// Project: FishLamp Mobile
// Schema: SlideShowObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. All rights reserved.
//

#import "FLSlideshowOptions.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLSqliteTable.h"

@implementation FLSlideshowOptions


@synthesize autoShowCaptions = __autoShowCaptions;
@synthesize autoStart = __autoStart;
@synthesize mediaItemList = __mediaItemList;
@synthesize playMusic = __playMusic;
@synthesize random = __random;
@synthesize repeat = __repeat;
@synthesize speed = __speed;

+ (NSString*) autoShowCaptionsKey
{
    return @"autoShowCaptions";
}

+ (NSString*) autoStartKey
{
    return @"autoStart";
}

+ (NSString*) mediaItemListKey
{
    return @"mediaItemList";
}

+ (NSString*) playMusicKey
{
    return @"playMusic";
}

+ (NSString*) randomKey
{
    return @"random";
}

+ (NSString*) repeatKey
{
    return @"repeat";
}

+ (NSString*) speedKey
{
    return @"speed";
}

- (void) copySelfTo:(id) object
{
    [super copySelfTo:object];
    ((FLSlideshowOptions*)object).random = FLCopyOrRetainObject(__random);
    ((FLSlideshowOptions*)object).speed = FLCopyOrRetainObject(__speed);
    ((FLSlideshowOptions*)object).repeat = FLCopyOrRetainObject(__repeat);
    ((FLSlideshowOptions*)object).playMusic = FLCopyOrRetainObject(__playMusic);
    ((FLSlideshowOptions*)object).mediaItemList = FLCopyOrRetainObject(__mediaItemList);
    ((FLSlideshowOptions*)object).autoShowCaptions = FLCopyOrRetainObject(__autoShowCaptions);
    ((FLSlideshowOptions*)object).autoStart = FLCopyOrRetainObject(__autoStart);
}

- (id) copyWithZone:(NSZone*) zone
{
    id outObject = [[[self class] alloc] init];
    [self copySelfTo:outObject];
    return outObject;
}

- (void) dealloc
{
    FLRelease(__speed);
    FLRelease(__repeat);
    FLRelease(__autoStart);
    FLRelease(__autoShowCaptions);
    FLRelease(__random);
    FLRelease(__playMusic);
    FLRelease(__mediaItemList);
    FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
    if(__speed) [aCoder encodeObject:__speed forKey:@"__speed"];
    if(__repeat) [aCoder encodeObject:__repeat forKey:@"__repeat"];
    if(__autoStart) [aCoder encodeObject:__autoStart forKey:@"__autoStart"];
    if(__autoShowCaptions) [aCoder encodeObject:__autoShowCaptions forKey:@"__autoShowCaptions"];
    if(__random) [aCoder encodeObject:__random forKey:@"__random"];
    if(__playMusic) [aCoder encodeObject:__playMusic forKey:@"__playMusic"];
    if(__mediaItemList) [aCoder encodeObject:__mediaItemList forKey:@"__mediaItemList"];
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
        __speed = FLReturnRetained([aDecoder decodeObjectForKey:@"__speed"]);
        __repeat = FLReturnRetained([aDecoder decodeObjectForKey:@"__repeat"]);
        __autoStart = FLReturnRetained([aDecoder decodeObjectForKey:@"__autoStart"]);
        __autoShowCaptions = FLReturnRetained([aDecoder decodeObjectForKey:@"__autoShowCaptions"]);
        __random = FLReturnRetained([aDecoder decodeObjectForKey:@"__random"]);
        __playMusic = FLReturnRetained([aDecoder decodeObjectForKey:@"__playMusic"]);
        __mediaItemList = [[aDecoder decodeObjectForKey:@"__mediaItemList"] mutableCopy];
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
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"speed" propertyClass:[NSNumber class] propertyType:FLDataTypeFloat] forPropertyName:@"speed"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"repeat" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"repeat"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoStart" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoStart"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"autoShowCaptions" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"autoShowCaptions"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"random" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"random"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"playMusic" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"playMusic"];
        [s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"mediaItemList" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject] forPropertyName:@"mediaItemList"];
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
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"speed" columnType:FLSqliteTypeFloat columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"repeat" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"autoStart" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"autoShowCaptions" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"random" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"playMusic" columnType:FLSqliteTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLSqliteColumn sqliteColumnWithColumnName:@"mediaItemList" columnType:FLSqliteTypeObject columnConstraints:nil]];
    });
    return s_table;
}

+ (FLSlideshowOptions*) slideshowOptions
{
    return FLReturnAutoreleased([[FLSlideshowOptions alloc] init]);
}

@end

@implementation FLSlideshowOptions (ValueProperties) 

- (float) speedValue
{
    return [self.speed floatValue];
}

- (void) setSpeedValue:(float) value
{
    self.speed = [NSNumber numberWithFloat:value];
}

- (BOOL) repeatValue
{
    return [self.repeat boolValue];
}

- (void) setRepeatValue:(BOOL) value
{
    self.repeat = [NSNumber numberWithBool:value];
}

- (BOOL) autoStartValue
{
    return [self.autoStart boolValue];
}

- (void) setAutoStartValue:(BOOL) value
{
    self.autoStart = [NSNumber numberWithBool:value];
}

- (BOOL) autoShowCaptionsValue
{
    return [self.autoShowCaptions boolValue];
}

- (void) setAutoShowCaptionsValue:(BOOL) value
{
    self.autoShowCaptions = [NSNumber numberWithBool:value];
}

- (BOOL) randomValue
{
    return [self.random boolValue];
}

- (void) setRandomValue:(BOOL) value
{
    self.random = [NSNumber numberWithBool:value];
}

- (BOOL) playMusicValue
{
    return [self.playMusic boolValue];
}

- (void) setPlayMusicValue:(BOOL) value
{
    self.playMusic = [NSNumber numberWithBool:value];
}
@end

// [/Generated]
