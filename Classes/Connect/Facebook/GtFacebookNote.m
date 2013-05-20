//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookNote.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookNote.h"
#import "GtFacebookNamedObject.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookNote


@synthesize created_time = m_created_time;
@synthesize from = m_from;
@synthesize icon = m_icon;
@synthesize message = m_message;
@synthesize subject = m_subject;
@synthesize updated_time = m_updated_time;

+ (NSString*) created_timeKey
{
	return @"created_time";
}

+ (NSString*) fromKey
{
	return @"from";
}

+ (NSString*) iconKey
{
	return @"icon";
}

+ (NSString*) messageKey
{
	return @"message";
}

+ (NSString*) subjectKey
{
	return @"subject";
}

+ (NSString*) updated_timeKey
{
	return @"updated_time";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookNote*)object).updated_time = GtCopyOrRetainObject(m_updated_time);
	((GtFacebookNote*)object).message = GtCopyOrRetainObject(m_message);
	((GtFacebookNote*)object).subject = GtCopyOrRetainObject(m_subject);
	((GtFacebookNote*)object).icon = GtCopyOrRetainObject(m_icon);
	((GtFacebookNote*)object).created_time = GtCopyOrRetainObject(m_created_time);
	((GtFacebookNote*)object).from = GtCopyOrRetainObject(m_from);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_from);
	GtRelease(m_subject);
	GtRelease(m_message);
	GtRelease(m_icon);
	GtRelease(m_updated_time);
	GtRelease(m_created_time);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_from) [aCoder encodeObject:m_from forKey:@"m_from"];
	if(m_subject) [aCoder encodeObject:m_subject forKey:@"m_subject"];
	if(m_message) [aCoder encodeObject:m_message forKey:@"m_message"];
	if(m_icon) [aCoder encodeObject:m_icon forKey:@"m_icon"];
	if(m_updated_time) [aCoder encodeObject:m_updated_time forKey:@"m_updated_time"];
	if(m_created_time) [aCoder encodeObject:m_created_time forKey:@"m_created_time"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookNote*) facebookNote
{
	return GtReturnAutoreleased([[GtFacebookNote alloc] init]);
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
		m_from = [[aDecoder decodeObjectForKey:@"m_from"] retain];
		m_subject = [[aDecoder decodeObjectForKey:@"m_subject"] retain];
		m_message = [[aDecoder decodeObjectForKey:@"m_message"] retain];
		m_icon = [[aDecoder decodeObjectForKey:@"m_icon"] retain];
		m_updated_time = [[aDecoder decodeObjectForKey:@"m_updated_time"] retain];
		m_created_time = [[aDecoder decodeObjectForKey:@"m_created_time"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"from" propertyClass:[GtFacebookNamedObject class] propertyType:GtDataTypeObject] forPropertyName:@"from"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"subject" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"subject"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"icon" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"icon"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"updated_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"updated_time"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"created_time" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"created_time"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"from" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"subject" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"icon" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"updated_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"created_time" columnType:GtSqliteTypeDate columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookNote (ValueProperties) 
@end

