//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookComment.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookComment.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookComment


@synthesize created_time = m_created_time;
@synthesize from = m_from;
@synthesize likes = m_likes;
@synthesize message = m_message;

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) likesKey
{
	return @"likes";
}

+ (NSString*) messageKey
{
	return @"message";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookComment*)object).message = GtCopyOrRetainObject(m_message);
	((GtFacebookComment*)object).likes = GtCopyOrRetainObject(m_likes);
	((GtFacebookComment*)object).created_time = GtCopyOrRetainObject(m_created_time);
	((GtFacebookComment*)object).from = GtCopyOrRetainObject(m_from);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_created_time);
	GtRelease(m_message);
	GtRelease(m_from);
	GtRelease(m_likes);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	if(m_message) [aCoder encodeObject:m_message forKey:@"m_message"];
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_likes) [aCoder encodeObject:m_likes forKey:@"m_likes"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookComment*) facebookComment
{
	return GtReturnAutoreleased([[GtFacebookComment alloc] init]);
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
		m_created_time = [[aDecoder decodeObjectForKey:@"m_created_time"] retain];
		m_message = [[aDecoder decodeObjectForKey:@"m_message"] retain];
		m_from = [[aDecoder decodeObjectForKey:@"m_from"] retain];
		m_likes = [[aDecoder decodeObjectForKey:@"m_likes"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"created_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"likes" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"likes"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"from" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"likes" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookComment (ValueProperties) 

- (int) likesValue
{
	return [self.likes intValue];
}

- (void) setLikesValue:(int) value
{
	self.likes = [NSNumber numberWithInt:value];
}
@end

