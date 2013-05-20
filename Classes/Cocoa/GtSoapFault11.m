//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtSoapFault11.m
//	Project: FishLamp
//	Schema: GtGeneratedCoreObjects
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtSoapFault11.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtSoapFault11


@synthesize detail = m_detail;
@synthesize faultactor = m_faultactor;
@synthesize faultcode = m_faultcode;
@synthesize faultstring = m_faultstring;

+ (NSString*) detailKey
{
	return @"detail";
}

+ (NSString*) faultactorKey
{
	return @"faultactor";
}

+ (NSString*) faultcodeKey
{
	return @"faultcode";
}

+ (NSString*) faultstringKey
{
	return @"faultstring";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtSoapFault11*)object).faultactor = GtCopyOrRetainObject(m_faultactor);
	((GtSoapFault11*)object).detail = GtCopyOrRetainObject(m_detail);
	((GtSoapFault11*)object).faultstring = GtCopyOrRetainObject(m_faultstring);
	((GtSoapFault11*)object).faultcode = GtCopyOrRetainObject(m_faultcode);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_faultcode);
	GtRelease(m_faultstring);
	GtRelease(m_faultactor);
	GtRelease(m_detail);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_faultcode) [aCoder encodeObject:m_faultcode forKey:@"m_faultcode"];
	if(m_faultstring) [aCoder encodeObject:m_faultstring forKey:@"m_faultstring"];
	if(m_faultactor) [aCoder encodeObject:m_faultactor forKey:@"m_faultactor"];
	if(m_detail) [aCoder encodeObject:m_detail forKey:@"m_detail"];
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
		m_faultcode = [[aDecoder decodeObjectForKey:@"m_faultcode"] retain];
		m_faultstring = [[aDecoder decodeObjectForKey:@"m_faultstring"] retain];
		m_faultactor = [[aDecoder decodeObjectForKey:@"m_faultactor"] retain];
		m_detail = [[aDecoder decodeObjectForKey:@"m_detail"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"faultcode" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"faultcode"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"faultstring" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"faultstring"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"faultactor" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"faultactor"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"detail" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"detail"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"faultcode" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"faultstring" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"faultactor" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"detail" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

+ (GtSoapFault11*) soapFault11
{
	return GtReturnAutoreleased([[GtSoapFault11 alloc] init]);
}

@end

@implementation GtSoapFault11 (ValueProperties) 
@end

