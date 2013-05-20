//	This file was generated at 3/11/12 1:33 PM by PackMule. DO NOT MODIFY!!
//
//	GtThemeDescriptor.m
//	Project: FishLamp
//	Schema: GtThemeDescriptor
//
//	Copywrite 2011 GreentTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtThemeDescriptor.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtThemeDescriptor


@synthesize backgroundColor = m_backgroundColor;
@synthesize themeName = m_themeName;

+ (NSString*) backgroundColorKey
{
	return @"backgroundColor";
}

+ (NSString*) themeNameKey
{
	return @"themeName";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtThemeDescriptor*)object).backgroundColor = GtCopyOrRetainObject(m_backgroundColor);
	((GtThemeDescriptor*)object).themeName = GtCopyOrRetainObject(m_themeName);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_themeName);
	GtRelease(m_backgroundColor);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_themeName) [aCoder encodeObject:m_themeName forKey:@"m_themeName"];
	if(m_backgroundColor) [aCoder encodeObject:m_backgroundColor forKey:@"m_backgroundColor"];
}

- (NSUInteger) hash
{
	return [[self themeName] hash];
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
		m_themeName = GtRetain([aDecoder decodeObjectForKey:@"m_themeName"]);
		m_backgroundColor = GtRetain([aDecoder decodeObjectForKey:@"m_backgroundColor"]);
	}
	return self;
}

- (BOOL) isEqual:(id) object
{
	return [object isKindOfClass:[self class]] && [[object themeName] isEqual:[self themeName]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"themeName" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"themeName"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"backgroundColor" propertyClass:[UIColor class] propertyType:GtDataTypeColor] forPropertyName:@"backgroundColor"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"themeName" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"backgroundColor" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtThemeDescriptor*) themeDescriptor
{
	return GtReturnAutoreleased([[GtThemeDescriptor alloc] init]);
}

@end

@implementation GtThemeDescriptor (ValueProperties) 
@end

