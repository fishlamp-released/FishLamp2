//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookLoadUserPictureOperationInput.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookLoadUserPictureOperationInput.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookLoadUserPictureOperationInput


@synthesize pictureSize = m_pictureSize;
@synthesize type = m_type;

+ (NSString*) pictureSizeKey
{
	return @"pictureSize";
}

+ (NSString*) typeKey
{
	return @"type";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookLoadUserPictureOperationInput*)object).type = GtCopyOrRetainObject(m_type);
	((GtFacebookLoadUserPictureOperationInput*)object).pictureSize = GtCopyOrRetainObject(m_pictureSize);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_type);
	GtRelease(m_pictureSize);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_type) [aCoder encodeObject:m_type forKey:@"m_type"];
	if(m_pictureSize) [aCoder encodeObject:m_pictureSize forKey:@"m_pictureSize"];
}

+ (GtFacebookLoadUserPictureOperationInput*) facebookLoadUserPictureOperationInput
{
	return GtReturnAutoreleased([[GtFacebookLoadUserPictureOperationInput alloc] init]);
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
		m_type = [[aDecoder decodeObjectForKey:@"m_type"] retain];
		m_pictureSize = [[aDecoder decodeObjectForKey:@"m_pictureSize"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"type" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"type"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"pictureSize" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"pictureSize"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"type" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"pictureSize" columnType:GtSqliteTypeText columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookLoadUserPictureOperationInput (ValueProperties) 
@end

