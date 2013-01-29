//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSyncState.m
//	Project: myZenfolio
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfSyncState.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfSyncState


@synthesize isSynced = _isSynced;
@synthesize lastSyncDate = _lastSyncDate;
@synthesize syncObjectId = _syncObjectId;

+ (NSString*) isSyncedKey
{
	return @"isSynced";
}

+ (NSString*) lastSyncDateKey
{
	return @"lastSyncDate";
}

+ (NSString*) syncObjectIdKey
{
	return @"syncObjectId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfSyncState*)object).syncObjectId = FLCopyOrRetainObject(_syncObjectId);
	((FLZfSyncState*)object).isSynced = FLCopyOrRetainObject(_isSynced);
	((FLZfSyncState*)object).lastSyncDate = FLCopyOrRetainObject(_lastSyncDate);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_lastSyncDate);
	FLRelease(_isSynced);
	FLRelease(_syncObjectId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_lastSyncDate) [aCoder encodeObject:_lastSyncDate forKey:@"_lastSyncDate"];
	if(_isSynced) [aCoder encodeObject:_isSynced forKey:@"_isSynced"];
	if(_syncObjectId) [aCoder encodeObject:_syncObjectId forKey:@"_syncObjectId"];
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
		_lastSyncDate = FLRetain([aDecoder decodeObjectForKey:@"_lastSyncDate"]);
		_isSynced = FLRetain([aDecoder decodeObjectForKey:@"_isSynced"]);
		_syncObjectId = FLRetain([aDecoder decodeObjectForKey:@"_syncObjectId"]);
	}
	return self;
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"lastSyncDate" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"lastSyncDate"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"isSynced" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"isSynced"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"syncObjectId" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"syncObjectId"];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
	});
	return s_inflator;
}

+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		FLDatabaseTable* superTable = [super sharedDatabaseTable];
		if(superTable)
		{
			s_table = [superTable copy];
			s_table.tableName = [self databaseTableName];
		}
		else
		{
			s_table = [[FLDatabaseTable alloc] initWithTableName:[self databaseTableName]];
		}
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"lastSyncDate" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"isSynced" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"syncObjectId" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
	});
	return s_table;
}

+ (FLZfSyncState*) syncState
{
	return FLAutorelease([[FLZfSyncState alloc] init]);
}

@end

@implementation FLZfSyncState (ValueProperties) 

- (BOOL) isSyncedValue
{
	return [self.isSynced boolValue];
}

- (void) setIsSyncedValue:(BOOL) value
{
	self.isSynced = [NSNumber numberWithBool:value];
}

- (NSInteger) syncObjectIdValue
{
	return [self.syncObjectId integerValue];
}

- (void) setSyncObjectIdValue:(NSInteger) value
{
	self.syncObjectId = [NSNumber numberWithInteger:value];
}
@end

