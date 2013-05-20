//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtCodeGeneratorMethod.m
//	Project: FishLamp Code Generator
//	Schema: GtCodeGenerator
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "GtCodeGeneratorMethod.h"
#import "GtCodeGeneratorCodeSnippet.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtCodeGeneratorVariable.h"

@implementation GtCodeGeneratorMethod


@synthesize code = m_code;

// Getter will create m_code if nil. Alternately, use the codeObject property, which will not lazy create it.
- (GtCodeGeneratorCodeSnippet*) code
{
	if(!m_code)
	{
		m_code = [[GtCodeGeneratorCodeSnippet alloc] init];
	}
	return m_code;
}
@synthesize comment = m_comment;
@synthesize isPrivate = m_isPrivate;
@synthesize isStatic = m_isStatic;
@synthesize name = m_name;
@synthesize parameters = m_parameters;

// Getter will create m_parameters if nil. Alternately, use the parametersObject property, which will not lazy create it.
- (NSMutableArray*) parameters
{
	if(!m_parameters)
	{
		m_parameters = [[NSMutableArray alloc] init];
	}
	return m_parameters;
}
@synthesize returnType = m_returnType;

+ (NSString*) codeKey
{
	return @"code";
}

+ (NSString*) commentKey
{
	return @"comment";
}

+ (NSString*) isPrivateKey
{
	return @"isPrivate";
}

+ (NSString*) isStaticKey
{
	return @"isStatic";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) parametersKey
{
	return @"parameters";
}

+ (NSString*) returnTypeKey
{
	return @"returnType";
}

+ (GtCodeGeneratorMethod*) codeGeneratorMethod
{
	return [[[GtCodeGeneratorMethod alloc] init] autorelease];
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtCodeGeneratorMethod*)object).name = GtCopyOrRetainObject(m_name);
	((GtCodeGeneratorMethod*)object).returnType = GtCopyOrRetainObject(m_returnType);
	((GtCodeGeneratorMethod*)object).parameters = GtCopyOrRetainObject(m_parameters);
	((GtCodeGeneratorMethod*)object).code = GtCopyOrRetainObject(m_code);
	((GtCodeGeneratorMethod*)object).comment = GtCopyOrRetainObject(m_comment);
	((GtCodeGeneratorMethod*)object).isPrivate = GtCopyOrRetainObject(m_isPrivate);
	((GtCodeGeneratorMethod*)object).isStatic = GtCopyOrRetainObject(m_isStatic);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_isStatic release];
	[m_isPrivate release];
	[m_returnType release];
	[m_name release];
	[m_comment release];
	[m_code release];
	[m_parameters release];
	[super dealloc];
}

- (NSUInteger) hash
{
	return [[self name] hash];
}

- (id) init
{
	if((self = [super init]))
	{
	}
	return self;
}

- (BOOL) isEqual:(id) object
{
	return [object isKindOfClass:[self class]] && [[object name] isEqual:[self name]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isStatic" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isStatic"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"isPrivate" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"isPrivate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"returnType" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"returnType"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"name"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"comment" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"comment"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"code" propertyClass:[GtCodeGeneratorCodeSnippet class] propertyType:GtDataTypeObject] forPropertyName:@"code"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"parameters" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"parameter" propertyClass:[GtCodeGeneratorVariable class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"parameters"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isStatic" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"isPrivate" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"returnType" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"name" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"comment" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"code" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"parameters" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtCodeGeneratorMethod (ValueProperties) 

// is this a class method, e.g. + (void) foo
- (BOOL) isStaticValue
{
	return [self.isStatic boolValue];
}

- (void) setIsStaticValue:(BOOL) value
{
	self.isStatic = [NSNumber numberWithBool:value];
}

// don't show the declaration in the header for this method
- (BOOL) isPrivateValue
{
	return [self.isPrivate boolValue];
}

- (void) setIsPrivateValue:(BOOL) value
{
	self.isPrivate = [NSNumber numberWithBool:value];
}
@end


@implementation GtCodeGeneratorMethod (ObjectMembers) 

// This returns m_code. It does NOT create it if it's NIL.
- (GtCodeGeneratorCodeSnippet*) codeObject
{
	return m_code;
}

// This returns m_parameters. It does NOT create it if it's NIL.
- (NSMutableArray*) parametersObject
{
	return m_parameters;
}

- (void) createCodeIfNil
{
	if(!m_code)
	{
		m_code = [[GtCodeGeneratorCodeSnippet alloc] init];
	}
}

- (void) createParametersIfNil
{
	if(!m_parameters)
	{
		m_parameters = [[NSMutableArray alloc] init];
	}
}
@end

