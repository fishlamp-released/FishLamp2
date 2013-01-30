//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGroupElementSyncInfo.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGroupElementSyncInfo.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioGroupElementSyncInfo


@synthesize isGroup = _isGroup;
@synthesize name = _name;
@synthesize syncObjectId = _syncObjectId;

+ (NSString*) isGroupKey
{
	return @"isGroup";
}

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) syncObjectIdKey
{
	return @"syncObjectId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGroupElementSyncInfo*)object).isGroup = FLCopyOrRetainObject(_isGroup);
	((FLZenfolioGroupElementSyncInfo*)object).syncObjectId = FLCopyOrRetainObject(_syncObjectId);
	((FLZenfolioGroupElementSyncInfo*)object).name = FLCopyOrRetainObject(_name);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_isGroup);
	FLRelease(_syncObjectId);
	FLRelease(_name);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_isGroup) [aCoder encodeObject:_isGroup forKey:@"_isGroup"];
	if(_syncObjectId) [aCoder encodeObject:_syncObjectId forKey:@"_syncObjectId"];
	if(_name) [aCoder encodeObject:_name forKey:@"_name"];
}

+ (FLZenfolioGroupElementSyncInfo*) groupElementSyncInfo
{
	return FLAutorelease([[FLZenfolioGroupElementSyncInfo alloc] init]);
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
		_isGroup = FLRetain([aDecoder decodeObjectForKey:@"_isGroup"]);
		_syncObjectId = FLRetain([aDecoder decodeObjectForKey:@"_syncObjectId"]);
		_name = FLRetain([aDecoder decodeObjectForKey:@"_name"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"isGroup" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"isGroup"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"syncObjectId" propertyClass:[NSNumber class] propertyType:FLDataTypeNSInteger] forPropertyName:@"syncObjectId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"name" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"name"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"isGroup" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"syncObjectId" columnType:FLDatabaseTypeInteger columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGroupElementSyncInfo (ValueProperties) 

- (BOOL) isGroupValue
{
	return [self.isGroup boolValue];
}

- (void) setIsGroupValue:(BOOL) value
{
	self.isGroup = [NSNumber numberWithBool:value];
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

