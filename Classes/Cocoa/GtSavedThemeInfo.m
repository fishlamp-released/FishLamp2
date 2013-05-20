//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtSavedThemeInfo.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSavedThemeInfo.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtSavedThemeInfo


@synthesize className = m_className;
@synthesize fontSize = m_fontSize;
@synthesize name = m_name;

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
	((GtSavedThemeInfo*)object).name = GtCopyOrRetainObject(m_name);
	((GtSavedThemeInfo*)object).className = GtCopyOrRetainObject(m_className);
	((GtSavedThemeInfo*)object).fontSize = GtCopyOrRetainObject(m_fontSize);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_name);
	GtRelease(m_className);
	GtRelease(m_fontSize);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_name) [aCoder encodeObject:m_name forKey:@"m_name"];
	if(m_className) [aCoder encodeObject:m_className forKey:@"m_className"];
	if(m_fontSize) [aCoder encodeObject:m_fontSize forKey:@"m_fontSize"];
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
		m_name = [[aDecoder decodeObjectForKey:@"m_name"] retain];
		m_className = [[aDecoder decodeObjectForKey:@"m_className"] retain];
		m_fontSize = [[aDecoder decodeObjectForKey:@"m_fontSize"] retain];
	}
	return self;
}

+ (GtSavedThemeInfo*) savedThemeInfo
{
	return GtReturnAutoreleased([[GtSavedThemeInfo alloc] init]);
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"className" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"className"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"fontSize" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"fontSize"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"className" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"fontSize" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtSavedThemeInfo (ValueProperties) 

- (int) fontSizeValue
{
	return [self.fontSize intValue];
}

- (void) setFontSizeValue:(int) value
{
	self.fontSize = [NSNumber numberWithInt:value];
}
@end

