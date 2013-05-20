//	This file was generated at 7/16/11 4:17 PM by PackMule. DO NOT MODIFY!!
//
//	GtSlideshowOptions.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSlideshowOptions.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtSlideshowOptions


@synthesize autoShowCaptions = m_autoShowCaptions;
@synthesize autoStart = m_autoStart;
@synthesize mediaItemList = m_mediaItemList;
@synthesize playMusic = m_playMusic;
@synthesize random = m_random;
@synthesize repeat = m_repeat;
@synthesize speed = m_speed;

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
	((GtSlideshowOptions*)object).random = GtCopyOrRetainObject(m_random);
	((GtSlideshowOptions*)object).speed = GtCopyOrRetainObject(m_speed);
	((GtSlideshowOptions*)object).repeat = GtCopyOrRetainObject(m_repeat);
	((GtSlideshowOptions*)object).playMusic = GtCopyOrRetainObject(m_playMusic);
	((GtSlideshowOptions*)object).mediaItemList = GtCopyOrRetainObject(m_mediaItemList);
	((GtSlideshowOptions*)object).autoShowCaptions = GtCopyOrRetainObject(m_autoShowCaptions);
	((GtSlideshowOptions*)object).autoStart = GtCopyOrRetainObject(m_autoStart);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_speed);
	GtRelease(m_repeat);
	GtRelease(m_autoStart);
	GtRelease(m_autoShowCaptions);
	GtRelease(m_random);
	GtRelease(m_playMusic);
	GtRelease(m_mediaItemList);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_speed) [aCoder encodeObject:m_speed forKey:@"m_speed"];
	if(m_repeat) [aCoder encodeObject:m_repeat forKey:@"m_repeat"];
	if(m_autoStart) [aCoder encodeObject:m_autoStart forKey:@"m_autoStart"];
	if(m_autoShowCaptions) [aCoder encodeObject:m_autoShowCaptions forKey:@"m_autoShowCaptions"];
	if(m_random) [aCoder encodeObject:m_random forKey:@"m_random"];
	if(m_playMusic) [aCoder encodeObject:m_playMusic forKey:@"m_playMusic"];
	if(m_mediaItemList) [aCoder encodeObject:m_mediaItemList forKey:@"m_mediaItemList"];
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
		m_speed = [[aDecoder decodeObjectForKey:@"m_speed"] retain];
		m_repeat = [[aDecoder decodeObjectForKey:@"m_repeat"] retain];
		m_autoStart = [[aDecoder decodeObjectForKey:@"m_autoStart"] retain];
		m_autoShowCaptions = [[aDecoder decodeObjectForKey:@"m_autoShowCaptions"] retain];
		m_random = [[aDecoder decodeObjectForKey:@"m_random"] retain];
		m_playMusic = [[aDecoder decodeObjectForKey:@"m_playMusic"] retain];
		m_mediaItemList = [[aDecoder decodeObjectForKey:@"m_mediaItemList"] mutableCopy];
	}
	return self;
}

+ (GtObjectDescriber*) sharedObjectDescriber
{
	static GtObjectDescriber* s_describer = nil;
	if(!s_describer)
	{
		@synchronized(self) {
			if(!s_describer)
			{
				s_describer = [[super sharedObjectDescriber] copy];
				if(!s_describer)
				{
					s_describer = [[GtObjectDescriber alloc] init];
				}
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"speed" propertyClass:[NSNumber class] propertyType:GtDataTypeFloat] forPropertyName:@"speed"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"repeat" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"repeat"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"autoStart" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"autoStart"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"autoShowCaptions" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"autoShowCaptions"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"random" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"random"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"playMusic" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"playMusic"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"mediaItemList" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject] forPropertyName:@"mediaItemList"];
			}
		}
	}
	return s_describer;
}

+ (GtObjectInflator*) sharedObjectInflator
{
	static GtObjectInflator* s_inflator = nil;
	if(!s_inflator)
	{
		@synchronized(self) {
			if(!s_inflator)
			{
				s_inflator = [[GtObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
			}
		}
	}
	return s_inflator;
}

+ (GtSqliteTable*) sharedSqliteTable
{
	static GtSqliteTable* s_table = nil;
	if(!s_table)
	{
		@synchronized(self) {
			if(!s_table)
			{
				GtSqliteTable* superTable = [super sharedSqliteTable];
				if(superTable)
				{
					s_table = [superTable copy];
					s_table.tableName = [self sqliteTableName];
				}
				else
				{
					s_table = [[GtSqliteTable alloc] initWithTableName:[self sqliteTableName]];
				}
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"speed" columnType:GtSqliteTypeFloat columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"repeat" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"autoStart" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"autoShowCaptions" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"random" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"playMusic" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"mediaItemList" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtSlideshowOptions*) slideshowOptions
{
	return GtReturnAutoreleased([[GtSlideshowOptions alloc] init]);
}

@end

@implementation GtSlideshowOptions (ValueProperties) 

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

