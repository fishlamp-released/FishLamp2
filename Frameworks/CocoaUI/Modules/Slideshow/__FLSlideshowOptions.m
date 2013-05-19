// [Generated]
//
// This file was generated at 6/18/12 2:01 PM by Whittle ( http://whittle.greentongue.com/ ). DO NOT MODIFY!!
//
// __FLSlideshowOptions.m
// Project: FishLamp Mobile
// Schema: SlideShowObjects
//
// Copywrite (C) 2012 GreenTongue Software, LLC. 
//  The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "FLSlideshowOptions.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

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
        __speed = FLRetain([aDecoder decodeObjectForKey:@"__speed"]);
        __repeat = FLRetain([aDecoder decodeObjectForKey:@"__repeat"]);
        __autoStart = FLRetain([aDecoder decodeObjectForKey:@"__autoStart"]);
        __autoShowCaptions = FLRetain([aDecoder decodeObjectForKey:@"__autoShowCaptions"]);
        __random = FLRetain([aDecoder decodeObjectForKey:@"__random"]);
        __playMusic = FLRetain([aDecoder decodeObjectForKey:@"__playMusic"]);
        __mediaItemList = [[aDecoder decodeObjectForKey:@"__mediaItemList"] mutableCopy];
    }
    return self;
}

+ (FLObjectDescriber*) objectDescriber
{
    
    static dispatch_once_t pred = 0;
    dispatch_once(&pred, ^{
        
		
            FLLegacyObjectDescriber* describer = [FLLegacyObjectDescriber registerClass:[self class]];
        
        

        [describer addPropertyWithName:@"speed" withClass:[FLFloatNumber class] ];
        [describer addPropertyWithName:@"repeat" withClass:[FLBoolNumber class] ];
        [describer addPropertyWithName:@"autoStart" withClass:[FLBoolNumber class] ];
        [describer addPropertyWithName:@"autoShowCaptions" withClass:[FLBoolNumber class] ];
        [describer addPropertyWithName:@"random" withClass:[FLBoolNumber class] ];
        [describer addPropertyWithName:@"playMusic" withClass:[FLBoolNumber class] ];
        [describer addPropertyWithName:@"mediaItemList" withClass:[NSMutableArray class]];
    });
    return [FLObjectDescriber objectDescriber:[self class]];
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
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"speed" columnType:FLDatabaseTypeFloat columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"repeat" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoStart" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"autoShowCaptions" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"random" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"playMusic" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
        [s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mediaItemList" columnType:FLDatabaseTypeObject columnConstraints:nil]];
    });
    return s_table;
}

+ (FLSlideshowOptions*) slideshowOptions
{
    return FLAutorelease([[FLSlideshowOptions alloc] init]);
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
