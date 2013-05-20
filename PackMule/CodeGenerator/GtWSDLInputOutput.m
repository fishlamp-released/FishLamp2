//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtWsdlInputOutput.m
//	Project: FishLamp
//	Schema: WSDLSchema
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtWsdlInputOutput.h"
#import "GtWsdlMessageBody.h"
#import "GtWsdlContent.h"
#import "GtWsdlMime.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtWsdlInputOutput


@synthesize body = m_body;

// Getter will create m_body if nil. Alternately, use the bodyObject property, which will not lazy create it.
- (GtWsdlMessageBody*) body
{
	if(!m_body)
	{
		m_body = [[GtWsdlMessageBody alloc] init];
	}
	return m_body;
}
@synthesize content = m_content;

// Getter will create m_content if nil. Alternately, use the contentObject property, which will not lazy create it.
- (GtWsdlContent*) content
{
	if(!m_content)
	{
		m_content = [[GtWsdlContent alloc] init];
	}
	return m_content;
}
@synthesize message = m_message;
@synthesize mimeXml = m_mimeXml;

// Getter will create m_mimeXml if nil. Alternately, use the mimeXmlObject property, which will not lazy create it.
- (GtWsdlMime*) mimeXml
{
	if(!m_mimeXml)
	{
		m_mimeXml = [[GtWsdlMime alloc] init];
	}
	return m_mimeXml;
}
@synthesize type = m_type;
@synthesize urlEncoded = m_urlEncoded;

+ (NSString*) bodyKey
{
	return @"body";
}

+ (NSString*) contentKey
{
	return @"content";
}

+ (NSString*) messageKey
{
	return @"message";
}

+ (NSString*) mimeXmlKey
{
	return @"mimeXml";
}

+ (NSString*) typeKey
{
	return @"type";
}

+ (NSString*) urlEncodedKey
{
	return @"urlEncoded";
}

- (void) dealloc
{
	[m_message release];
	[m_type release];
	[m_body release];
	[m_content release];
	[m_urlEncoded release];
	[m_mimeXml release];
	[super dealloc];
}

- (id) init
{
	if((self = [super init]))
	{
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"message" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"message"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"body" propertyClass:[GtWsdlMessageBody class] propertyType:GtDataTypeObject] forPropertyName:@"body"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"content" propertyClass:[GtWsdlContent class] propertyType:GtDataTypeObject] forPropertyName:@"content"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"urlEncoded" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"urlEncoded"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"mimeXml" propertyClass:[GtWsdlMime class] propertyType:GtDataTypeObject] forPropertyName:@"mimeXml"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"message" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"body" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"content" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"urlEncoded" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"mimeXml" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtWsdlInputOutput*) wsdlInputOutput
{
	return [[[GtWsdlInputOutput alloc] init] autorelease];
}

@end

@implementation GtWsdlInputOutput (ValueProperties) 
@end


@implementation GtWsdlInputOutput (ObjectMembers) 

// This returns m_body. It does NOT create it if it's NIL.
- (GtWsdlMessageBody*) bodyObject
{
	return m_body;
}

// This returns m_content. It does NOT create it if it's NIL.
- (GtWsdlContent*) contentObject
{
	return m_content;
}

// This returns m_mimeXml. It does NOT create it if it's NIL.
- (GtWsdlMime*) mimeXmlObject
{
	return m_mimeXml;
}

- (void) createBodyIfNil
{
	if(!m_body)
	{
		m_body = [[GtWsdlMessageBody alloc] init];
	}
}

- (void) createContentIfNil
{
	if(!m_content)
	{
		m_content = [[GtWsdlContent alloc] init];
	}
}

- (void) createMimeXmlIfNil
{
	if(!m_mimeXml)
	{
		m_mimeXml = [[GtWsdlMime alloc] init];
	}
}
@end

