//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookError.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookError.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookError


@synthesize error = m_error;
@synthesize error_description = m_error_description;
@synthesize error_reason = m_error_reason;
@synthesize externalUrl = m_externalUrl;

+ (NSString*) errorKey
{
	return @"error";
}

+ (NSString*) error_descriptionKey
{
	return @"error_description";
}

+ (NSString*) error_reasonKey
{
	return @"error_reason";
}

+ (NSString*) externalUrlKey
{
	return @"externalUrl";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookError*)object).error_reason = GtCopyOrRetainObject(m_error_reason);
	((GtFacebookError*)object).error_description = GtCopyOrRetainObject(m_error_description);
	((GtFacebookError*)object).externalUrl = GtCopyOrRetainObject(m_externalUrl);
	((GtFacebookError*)object).error = GtCopyOrRetainObject(m_error);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_error_reason);
	GtRelease(m_error);
	GtRelease(m_error_description);
	GtRelease(m_externalUrl);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_error_reason) [aCoder encodeObject:m_error_reason forKey:@"m_error_reason"];
	if(m_error) [aCoder encodeObject:m_error forKey:@"m_error"];
	if(m_error_description) [aCoder encodeObject:m_error_description forKey:@"m_error_description"];
	if(m_externalUrl) [aCoder encodeObject:m_externalUrl forKey:@"m_externalUrl"];
}

+ (GtFacebookError*) facebookError
{
	return GtReturnAutoreleased([[GtFacebookError alloc] init]);
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
		m_error_reason = [[aDecoder decodeObjectForKey:@"m_error_reason"] retain];
		m_error = [[aDecoder decodeObjectForKey:@"m_error"] retain];
		m_error_description = [[aDecoder decodeObjectForKey:@"m_error_description"] retain];
		m_externalUrl = [[aDecoder decodeObjectForKey:@"m_externalUrl"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"error_reason" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"error_reason"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"error" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"error"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"error_description" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"error_description"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"externalUrl" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"externalUrl"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"error_reason" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"error" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"error_description" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"externalUrl" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookError (ValueProperties) 
@end

