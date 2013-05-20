//	This file was generated at 7/16/11 4:15 PM by PackMule. DO NOT MODIFY!!
//
//	GtTestObject.m
//	Project: FishLamp
//	Schema: GtTestObjects
//
//	Copywrite 2011 GreentTongue Software. All rights reserved.
//

#import "GtTestObject.h"
#import "GtTestObjectsEnums.h"
#import "GtGuid.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"
#import "GtXmlParser.h"

@implementation GtTestObject

static NSString* m_foopy = @"hello!";

@synthesize anArray = m_anArray;

// Getter will create m_anArray if nil. Alternately, use the anArrayObject property, which will not lazy create it.
- (NSMutableArray*) anArray
{
	if(!m_anArray)
	{
		m_anArray = [[NSMutableArray alloc] init];
	}
	return m_anArray;
}
@synthesize anotherInt = m_anotherInt;
@synthesize databaseGuid = m_databaseGuid;

// Getter will create m_databaseGuid if nil. Alternately, use the databaseGuidObject property, which will not lazy create it.
- (GtGuid*) databaseGuid
{
	if(!m_databaseGuid)
	{
		m_databaseGuid = [[GtGuid alloc] init];
	}
	return m_databaseGuid;
}
@synthesize dateCreated = m_dateCreated;
@synthesize dateModified = m_dateModified;
@synthesize expireDate = m_expireDate;
@synthesize foo = m_foo;

- (NSString*) foop
{
	return @"hello!";
}
@synthesize myBool = m_myBool;
@synthesize myString = m_myString;
@synthesize point = m_point;
@synthesize rect = m_rect;
@synthesize size = m_size;
@synthesize stateEnum = m_stateEnum;
@synthesize testFloat = m_testFloat;
@synthesize testInt = m_testInt;

+ (NSString*) anArrayKey
{
	return @"anArray";
}

+ (NSString*) anotherIntKey
{
	return @"anotherInt";
}

+ (NSString*) databaseGuidKey
{
	return @"databaseGuid";
}

+ (NSString*) dateCreatedKey
{
	return @"dateCreated";
}

+ (NSString*) dateModifiedKey
{
	return @"dateModified";
}

+ (NSString*) expireDateKey
{
	return @"expireDate";
}

+ (NSString*) fooKey
{
	return @"foo";
}

+ (NSString*) foopy
{
	return m_foopy;
}

+ (void) setFoopy:(NSString*) value
{
	GtAssignObject(m_foopy, value);
}

+ (NSString*) iLikeRum
{
	return @"Captain Morgan";
}

+ (NSString*) myBoolKey
{
	return @"myBool";
}

+ (NSString*) myStringKey
{
	return @"myString";
}

+ (NSString*) pointKey
{
	return @"point";
}

+ (NSString*) rectKey
{
	return @"rect";
}

+ (NSString*) sizeKey
{
	return @"size";
}

+ (NSString*) stateEnumKey
{
	return @"stateEnum";
}

+ (NSString*) testFloatKey
{
	return @"testFloat";
}

+ (NSString*) testIntKey
{
	return @"testInt";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtTestObject*)object).testFloat = GtCopyOrRetainObject(m_testFloat);
	((GtTestObject*)object).testInt = GtCopyOrRetainObject(m_testInt);
	((GtTestObject*)object).myBool = GtCopyOrRetainObject(m_myBool);
	((GtTestObject*)object).myString = GtCopyOrRetainObject(m_myString);
	((GtTestObject*)object).dateCreated = GtCopyOrRetainObject(m_dateCreated);
	((GtTestObject*)object).anArray = GtCopyOrRetainObject(m_anArray);
	((GtTestObject*)object).size = GtCopyOrRetainObject(m_size);
	((GtTestObject*)object).stateEnum = GtCopyOrRetainObject(m_stateEnum);
	((GtTestObject*)object).anotherInt = GtCopyOrRetainObject(m_anotherInt);
	((GtTestObject*)object).point = GtCopyOrRetainObject(m_point);
	((GtTestObject*)object).dateModified = GtCopyOrRetainObject(m_dateModified);
	((GtTestObject*)object).expireDate = GtCopyOrRetainObject(m_expireDate);
	((GtTestObject*)object).databaseGuid = GtCopyOrRetainObject(m_databaseGuid);
	((GtTestObject*)object).foo = GtCopyOrRetainObject(m_foo);
	((GtTestObject*)object).rect = GtCopyOrRetainObject(m_rect);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	[m_testInt release];
	[m_anotherInt release];
	[m_rect release];
	[m_point release];
	[m_size release];
	[m_stateEnum release];
	[m_myBool release];
	[m_databaseGuid release];
	[m_dateModified release];
	[m_dateCreated release];
	[m_expireDate release];
	[m_foo release];
	[m_myString release];
	[m_testFloat release];
	[m_anArray release];
	[super dealloc];
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_testInt) [aCoder encodeObject:m_testInt forKey:@"m_testInt"];
	if(m_anotherInt) [aCoder encodeObject:m_anotherInt forKey:@"m_anotherInt"];
	if(m_rect) [aCoder encodeObject:m_rect forKey:@"m_rect"];
	if(m_point) [aCoder encodeObject:m_point forKey:@"m_point"];
	if(m_size) [aCoder encodeObject:m_size forKey:@"m_size"];
	if(m_stateEnum) [aCoder encodeObject:m_stateEnum forKey:@"m_stateEnum"];
	if(m_myBool) [aCoder encodeObject:m_myBool forKey:@"m_myBool"];
	if(m_databaseGuid) [aCoder encodeObject:m_databaseGuid forKey:@"m_databaseGuid"];
	if(m_dateModified) [aCoder encodeObject:m_dateModified forKey:@"m_dateModified"];
	if(m_dateCreated) [aCoder encodeObject:m_dateCreated forKey:@"m_dateCreated"];
	if(m_expireDate) [aCoder encodeObject:m_expireDate forKey:@"m_expireDate"];
	if(m_foo) [aCoder encodeObject:m_foo forKey:@"m_foo"];
	if(m_myString) [aCoder encodeObject:m_myString forKey:@"m_myString"];
	if(m_testFloat) [aCoder encodeObject:m_testFloat forKey:@"m_testFloat"];
	if(m_anArray) [aCoder encodeObject:m_anArray forKey:@"m_anArray"];
}

- (NSUInteger) hash
{
	return [[self foo] hash];
}

- (id) init
{
	if((self = [super init]))
	{
		self.testIntValue = 5;
		self.stateEnumValue = GtMyEnumfoobar;
		self.myBoolValue = YES;
		self.myString = @"hello!";
	}
	return self;
}

- (id) initWithCoder:(NSCoder*) aDecoder
{
	if((self = [super init]))
	{
		m_testInt = [[aDecoder decodeObjectForKey:@"m_testInt"] retain];
		m_anotherInt = [[aDecoder decodeObjectForKey:@"m_anotherInt"] retain];
		m_rect = [[aDecoder decodeObjectForKey:@"m_rect"] retain];
		m_point = [[aDecoder decodeObjectForKey:@"m_point"] retain];
		m_size = [[aDecoder decodeObjectForKey:@"m_size"] retain];
		m_stateEnum = [[aDecoder decodeObjectForKey:@"m_stateEnum"] retain];
		m_myBool = [[aDecoder decodeObjectForKey:@"m_myBool"] retain];
		m_databaseGuid = [[aDecoder decodeObjectForKey:@"m_databaseGuid"] retain];
		m_dateModified = [[aDecoder decodeObjectForKey:@"m_dateModified"] retain];
		m_dateCreated = [[aDecoder decodeObjectForKey:@"m_dateCreated"] retain];
		m_expireDate = [[aDecoder decodeObjectForKey:@"m_expireDate"] retain];
		m_foo = [[aDecoder decodeObjectForKey:@"m_foo"] retain];
		m_myString = [[aDecoder decodeObjectForKey:@"m_myString"] retain];
		m_testFloat = [[aDecoder decodeObjectForKey:@"m_testFloat"] retain];
		m_anArray = [[aDecoder decodeObjectForKey:@"m_anArray"] mutableCopy];
	}
	return self;
}

- (BOOL) isEqual:(id) object
{
	return [object isKindOfClass:[self class]] && [[object foo] isEqual:[self foo]];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"testInt" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"testInt"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"anotherInt" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"anotherInt"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"rect" propertyClass:[NSValue class] propertyType:GtDataTypeRect] forPropertyName:@"rect"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"point" propertyClass:[NSValue class] propertyType:GtDataTypePoint] forPropertyName:@"point"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"size" propertyClass:[NSValue class] propertyType:GtDataTypeSize] forPropertyName:@"size"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"stateEnum" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"stateEnum"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"myBool" propertyClass:[NSNumber class] propertyType:GtDataTypeBool] forPropertyName:@"myBool"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"databaseGuid" propertyClass:[GtGuid class] propertyType:GtDataTypeObject] forPropertyName:@"databaseGuid"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"dateModified" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"dateModified"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"dateCreated" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"dateCreated"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"expireDate" propertyClass:[NSDate class] propertyType:GtDataTypeDate] forPropertyName:@"expireDate"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"foo" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"foo"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"myString" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"myString"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"testFloat" propertyClass:[NSNumber class] propertyType:GtDataTypeFloat] forPropertyName:@"testFloat"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"anArray" propertyClass:[NSMutableArray class] propertyType:GtDataTypeObject arrayTypes:[NSArray arrayWithObjects:[GtPropertyDescription propertyDescription:@"item" propertyClass:[NSString class] propertyType:GtDataTypeString arrayTypes:nil], [GtPropertyDescription propertyDescription:@"number" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger arrayTypes:nil], [GtPropertyDescription propertyDescription:@"parser" propertyClass:[GtXmlParser class] propertyType:GtDataTypeObject arrayTypes:nil], nil] isUnboundedArray:YES] forPropertyName:@"anArray"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"testInt" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addIndex:[GtSqliteIndex sqliteIndex:@"testInt" indexProperties:GtSqliteColumnIndexPropertyNone]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"anotherInt" columnType:GtSqliteTypeInteger columnConstraints:[NSArray arrayWithObjects:[GtSqliteColumn notNullConstraint], nil]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"rect" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"point" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"size" columnType:GtSqliteTypeObject columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"stateEnum" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"myBool" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"databaseGuid" columnType:GtSqliteTypeObject columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"dateModified" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"dateCreated" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"expireDate" columnType:GtSqliteTypeDate columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"foo" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"myString" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"testFloat" columnType:GtSqliteTypeFloat columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"anArray" columnType:GtSqliteTypeObject columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtTestObject*) testObject
{
	return [[[GtTestObject alloc] init] autorelease];
}

@end

@implementation GtTestObject (ValueProperties) 

- (int) testIntValue
{
	return [self.testInt intValue];
}

- (void) setTestIntValue:(int) value
{
	self.testInt = [NSNumber numberWithInt:value];
}

- (int) anotherIntValue
{
	return [self.anotherInt intValue];
}

- (void) setAnotherIntValue:(int) value
{
	self.anotherInt = [NSNumber numberWithInt:value];
}

- (NSRect) rectValue
{
	return [self.rect rectValue];
}

- (void) setRectValue:(NSRect) value
{
	self.rect = [NSValue valueWithRect:value];
}

- (NSPoint) pointValue
{
	return [self.point pointValue];
}

- (void) setPointValue:(NSPoint) value
{
	self.point = [NSValue valueWithPoint:value];
}

- (NSSize) sizeValue
{
	return [self.size sizeValue];
}

- (void) setSizeValue:(NSSize) value
{
	self.size = [NSValue valueWithSize:value];
}

- (GtMyEnum) stateEnumValue
{
	return [[GtTestObjectsEnumLookup instance] myEnumFromString:self.stateEnum];
}

- (void) setStateEnumValue:(GtMyEnum) inEnumValue
{
	self.stateEnum = [[GtTestObjectsEnumLookup instance] stringFromMyEnum:inEnumValue];
}

- (BOOL) myBoolValue
{
	return [self.myBool boolValue];
}

- (void) setMyBoolValue:(BOOL) value
{
	self.myBool = [NSNumber numberWithBool:value];
}

- (float) testFloatValue
{
	return [self.testFloat floatValue];
}

- (void) setTestFloatValue:(float) value
{
	self.testFloat = [NSNumber numberWithFloat:value];
}
@end


@implementation GtTestObject (ObjectMembers) 

// This returns m_databaseGuid. It does NOT create it if it's NIL.
- (GtGuid*) databaseGuidObject
{
	return m_databaseGuid;
}

// This returns m_anArray. It does NOT create it if it's NIL.
- (NSMutableArray*) anArrayObject
{
	return m_anArray;
}

- (void) createDatabaseGuidIfNil
{
	if(!m_databaseGuid)
	{
		m_databaseGuid = [[GtGuid alloc] init];
	}
}

- (void) createAnArrayIfNil
{
	if(!m_anArray)
	{
		m_anArray = [[NSMutableArray alloc] init];
	}
}
@end

