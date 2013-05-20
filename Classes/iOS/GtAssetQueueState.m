//	This file was generated at 7/16/11 4:17 PM by PackMule. DO NOT MODIFY!!
//
//	GtAssetQueueState.m
//	Project: FishLamp Mobile
//	Schema: MobilePhotoObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. The FishLamp Framework is released under the MIT License: http://fishlamp.com/license 
//

#import "GtAssetQueueState.h"
#import "GtObjectDescriber.h"
#import "GtObjectInflator.h"
#import "GtSqliteTable.h"

@implementation GtAssetQueueState


@synthesize firstQueuePosition = m_firstQueuePosition;
@synthesize lastQueuePosition = m_lastQueuePosition;
@synthesize queueUID = m_queueUID;
@synthesize sortOrder = m_sortOrder;
@synthesize totalAssetsAdded = m_totalAssetsAdded;

+ (NSString*) firstQueuePositionKey
{
	return @"firstQueuePosition";
}

+ (NSString*) lastQueuePositionKey
{
	return @"lastQueuePosition";
}

+ (NSString*) queueUIDKey
{
	return @"queueUID";
}

+ (NSString*) sortOrderKey
{
	return @"sortOrder";
}

+ (NSString*) totalAssetsAddedKey
{
	return @"totalAssetsAdded";
}

+ (GtAssetQueueState*) assetQueueState
{
	return GtReturnAutoreleased([[GtAssetQueueState alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((GtAssetQueueState*)object).firstQueuePosition = GtCopyOrRetainObject(m_firstQueuePosition);
	((GtAssetQueueState*)object).totalAssetsAdded = GtCopyOrRetainObject(m_totalAssetsAdded);
	((GtAssetQueueState*)object).queueUID = GtCopyOrRetainObject(m_queueUID);
	((GtAssetQueueState*)object).sortOrder = GtCopyOrRetainObject(m_sortOrder);
	((GtAssetQueueState*)object).lastQueuePosition = GtCopyOrRetainObject(m_lastQueuePosition);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	GtRelease(m_queueUID);
	GtRelease(m_sortOrder);
	GtRelease(m_totalAssetsAdded);
	GtRelease(m_firstQueuePosition);
	GtRelease(m_lastQueuePosition);
	GtSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(m_queueUID) [aCoder encodeObject:m_queueUID forKey:@"m_queueUID"];
	if(m_sortOrder) [aCoder encodeObject:m_sortOrder forKey:@"m_sortOrder"];
	if(m_totalAssetsAdded) [aCoder encodeObject:m_totalAssetsAdded forKey:@"m_totalAssetsAdded"];
	if(m_firstQueuePosition) [aCoder encodeObject:m_firstQueuePosition forKey:@"m_firstQueuePosition"];
	if(m_lastQueuePosition) [aCoder encodeObject:m_lastQueuePosition forKey:@"m_lastQueuePosition"];
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
		m_queueUID = [[aDecoder decodeObjectForKey:@"m_queueUID"] retain];
		m_sortOrder = [[aDecoder decodeObjectForKey:@"m_sortOrder"] retain];
		m_totalAssetsAdded = [[aDecoder decodeObjectForKey:@"m_totalAssetsAdded"] retain];
		m_firstQueuePosition = [[aDecoder decodeObjectForKey:@"m_firstQueuePosition"] retain];
		m_lastQueuePosition = [[aDecoder decodeObjectForKey:@"m_lastQueuePosition"] retain];
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
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"queueUID" propertyClass:[NSString class] propertyType:GtDataTypeString] forPropertyName:@"queueUID"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"sortOrder" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"sortOrder"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"totalAssetsAdded" propertyClass:[NSNumber class] propertyType:GtDataTypeLong] forPropertyName:@"totalAssetsAdded"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"firstQueuePosition" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"firstQueuePosition"];
				[s_describer setPropertyDescriber:[GtPropertyDescription propertyDescription:@"lastQueuePosition" propertyClass:[NSNumber class] propertyType:GtDataTypeInteger] forPropertyName:@"lastQueuePosition"];
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
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"queueUID" columnType:GtSqliteTypeText columnConstraints:[NSArray arrayWithObject:[GtSqliteColumn primaryKeyConstraint]]]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"sortOrder" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"totalAssetsAdded" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"firstQueuePosition" columnType:GtSqliteTypeInteger columnConstraints:nil]];
				[s_table addColumn:[GtSqliteColumn sqliteColumnWithColumnName:@"lastQueuePosition" columnType:GtSqliteTypeInteger columnConstraints:nil]];
			}
		}
	}
	return s_table;
}

@end

@implementation GtAssetQueueState (ValueProperties) 

- (int) sortOrderValue
{
	return [self.sortOrder intValue];
}

- (void) setSortOrderValue:(int) value
{
	self.sortOrder = [NSNumber numberWithInt:value];
}

- (long) totalAssetsAddedValue
{
	return [self.totalAssetsAdded longValue];
}

- (void) setTotalAssetsAddedValue:(long) value
{
	self.totalAssetsAdded = [NSNumber numberWithLong:value];
}

- (int) firstQueuePositionValue
{
	return [self.firstQueuePosition intValue];
}

- (void) setFirstQueuePositionValue:(int) value
{
	self.firstQueuePosition = [NSNumber numberWithInt:value];
}

- (int) lastQueuePositionValue
{
	return [self.lastQueuePosition intValue];
}

- (void) setLastQueuePositionValue:(int) value
{
	self.lastQueuePosition = [NSNumber numberWithInt:value];
}
@end

