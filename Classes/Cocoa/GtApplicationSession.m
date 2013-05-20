//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtApplicationSession.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtApplicationSession.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtApplicationSession


@synthesize sessionId = m_sessionId;
@synthesize userGuid = m_userGuid;

+ (NSString*) sessionIdKey
{
	return @"sessionId";
}

+ (NSString*) userGuidKey
{
	return @"userGuid";
}

+ (GtApplicationSession*) applicationSession
{
	return GtReturnAutoreleased([[GtApplicationSession alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtApplicationSession*)object).sessionId = GtCopyOrRetainObject(m_sessionId);
	((GtApplicationSession*)object).userGuid = GtCopyOrRetainObject(m_userGuid);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_sessionId);
	GtRelease(m_userGuid);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_sessionId) [aCoder encodeObject:m_sessionId forKey:@"m_sessionId"];
	if(m_userGuid) [aCoder encodeObject:m_userGuid forKey:@"m_userGuid"];
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
		m_sessionId = [[aDecoder decodeObjectForKey:@"m_sessionId"] retain];
		m_userGuid = [[aDecoder decodeObjectForKey:@"m_userGuid"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"sessionId" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"sessionId"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"userGuid" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"userGuid"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"sessionId" columnType:GtSqliteTypeInteger columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"userGuid" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtApplicationSession (ValueProperties) 

- (int) sessionIdValue
{
	return [self.sessionId intValue];
}

- (void) setSessionIdValue:(int) value
{
	self.sessionId = [NSNumber numberWithInt:value];
}
@end

