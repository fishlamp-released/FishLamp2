//	This file was generated at 7/16/11 4:18 PM by PackMule. DO NOT MODIFY!!
//
//	GtFacebookPage.m
//	Project: FishLamp Connect
//	Schema: Facebook
//
//	Copywrite 2011 GreenTongue Software. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtFacebookPage.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtFacebookPage


@synthesize category = m_category;
@synthesize likes = m_likes;

+ (NSString*) categoryKey
{
	return @"category";
}

+ (NSString*) likesKey
{
	return @"likes";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtFacebookPage*)object).likes = GtCopyOrRetainObject(m_likes);
	((GtFacebookPage*)object).category = GtCopyOrRetainObject(m_category);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_category);
	GtRelease(m_likes);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_category) [aCoder encodeObject:m_category forKey:@"m_category"];
	if(m_likes) [aCoder encodeObject:m_likes forKey:@"m_likes"];
	[super encodeWithCoder:aCoder];
}

+ (GtFacebookPage*) facebookPage
{
	return GtReturnAutoreleased([[GtFacebookPage alloc] init]);
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
		m_category = [[aDecoder decodeObjectForKey:@"m_category"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"category" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"category"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"category" columnType:GtSqliteTypeText columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"likes" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtFacebookPage (ValueProperties) 

- (int) likesValue
{
	return [self.likes intValue];
}

- (void) setLikesValue:(int) value
{
	self.likes = [NSNumber numberWithInt:value];
}
@end

