//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPlace.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPlace.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookPlace


@synthesize location = m_location;

+ (NSString*) locationKey
{
	return @"location";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookPlace*)object).location = GtCopyOrRetainObject(m_location);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_location);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_location) [aCoder encodeObject:m_location forKey:@"m_location"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookPlace*) facebookPlace
{
	return GtReturnAutoreleased([[GtFacebookPlace alloc] init]);
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
		m_location = [[aDecoder decodeObjectForKey:@"m_location"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"location" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"location"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"location" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPlace (ValueProperties) 
@end

