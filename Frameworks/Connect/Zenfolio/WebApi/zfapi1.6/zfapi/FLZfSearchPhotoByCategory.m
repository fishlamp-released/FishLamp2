//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchPhotoByCategory.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfSearchPhotoByCategory.h"
#import "FLZfApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfSearchPhotoByCategory


@synthesize categoryCode = _categoryCode;
@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;

+ (NSString*) categoryCodeKey
{
	return @"categoryCode";
}

+ (NSString*) limitKey
{
	return @"limit";
}

+ (NSString*) offsetKey
{
	return @"offset";
}

+ (NSString*) searchIdKey
{
	return @"searchId";
}

+ (NSString*) sortOrderKey
{
	return @"sortOrder";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfSearchPhotoByCategory*)object).categoryCode = FLCopyOrRetainObject(_categoryCode);
	((FLZfSearchPhotoByCategory*)object).searchId = FLCopyOrRetainObject(_searchId);
	((FLZfSearchPhotoByCategory*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((FLZfSearchPhotoByCategory*)object).offset = FLCopyOrRetainObject(_offset);
	((FLZfSearchPhotoByCategory*)object).limit = FLCopyOrRetainObject(_limit);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_searchId);
	FLRelease(_sortOrder);
	FLRelease(_categoryCode);
	FLRelease(_offset);
	FLRelease(_limit);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_searchId) [aCoder encodeObject:_searchId forKey:@"_searchId"];
	if(_sortOrder) [aCoder encodeObject:_sortOrder forKey:@"_sortOrder"];
	if(_categoryCode) [aCoder encodeObject:_categoryCode forKey:@"_categoryCode"];
	if(_offset) [aCoder encodeObject:_offset forKey:@"_offset"];
	if(_limit) [aCoder encodeObject:_limit forKey:@"_limit"];
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
		_searchId = FLRetain([aDecoder decodeObjectForKey:@"_searchId"]);
		_sortOrder = FLRetain([aDecoder decodeObjectForKey:@"_sortOrder"]);
		_categoryCode = FLRetain([aDecoder decodeObjectForKey:@"_categoryCode"]);
		_offset = FLRetain([aDecoder decodeObjectForKey:@"_offset"]);
		_limit = FLRetain([aDecoder decodeObjectForKey:@"_limit"]);
	}
	return self;
}

+ (FLZfSearchPhotoByCategory*) searchPhotoByCategory
{
	return FLAutorelease([[FLZfSearchPhotoByCategory alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"searchId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"searchId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"sortOrder" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"sortOrder"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"categoryCode" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"categoryCode"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"offset" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"offset"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"limit" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"limit"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"searchId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sortOrder" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryCode" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfSearchPhotoByCategory (ValueProperties) 

- (FLZfSortOrder) sortOrderValue
{
	return [[FLZfApi1_6EnumLookup instance] sortOrderFromString:self.sortOrder];
}

- (void) setSortOrderValue:(FLZfSortOrder) inEnumValue
{
	self.sortOrder = [[FLZfApi1_6EnumLookup instance] stringFromSortOrder:inEnumValue];
}

- (int) categoryCodeValue
{
	return [self.categoryCode intValue];
}

- (void) setCategoryCodeValue:(int) value
{
	self.categoryCode = [NSNumber numberWithInt:value];
}

- (int) offsetValue
{
	return [self.offset intValue];
}

- (void) setOffsetValue:(int) value
{
	self.offset = [NSNumber numberWithInt:value];
}

- (int) limitValue
{
	return [self.limit intValue];
}

- (void) setLimitValue:(int) value
{
	self.limit = [NSNumber numberWithInt:value];
}
@end

