//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchPhotoByText.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioSearchPhotoByText.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioSearchPhotoByText


@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize query = _query;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;

+ (NSString*) limitKey
{
	return @"limit";
}

+ (NSString*) offsetKey
{
	return @"offset";
}

+ (NSString*) queryKey
{
	return @"query";
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
	((FLZenfolioSearchPhotoByText*)object).query = FLCopyOrRetainObject(_query);
	((FLZenfolioSearchPhotoByText*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((FLZenfolioSearchPhotoByText*)object).searchId = FLCopyOrRetainObject(_searchId);
	((FLZenfolioSearchPhotoByText*)object).offset = FLCopyOrRetainObject(_offset);
	((FLZenfolioSearchPhotoByText*)object).limit = FLCopyOrRetainObject(_limit);
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
	FLRelease(_query);
	FLRelease(_offset);
	FLRelease(_limit);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_searchId) [aCoder encodeObject:_searchId forKey:@"_searchId"];
	if(_sortOrder) [aCoder encodeObject:_sortOrder forKey:@"_sortOrder"];
	if(_query) [aCoder encodeObject:_query forKey:@"_query"];
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
		_query = FLRetain([aDecoder decodeObjectForKey:@"_query"]);
		_offset = FLRetain([aDecoder decodeObjectForKey:@"_offset"]);
		_limit = FLRetain([aDecoder decodeObjectForKey:@"_limit"]);
	}
	return self;
}

+ (FLZenfolioSearchPhotoByText*) searchPhotoByText
{
	return FLAutorelease([[FLZenfolioSearchPhotoByText alloc] init]);
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
		[s_describer addProperty:@"searchId" withClass:[NSString class]];
		[s_describer addProperty:@"sortOrder" withClass:[NSString class]];
		[s_describer addProperty:@"query" withClass:[NSString class]];
		[s_describer addProperty:@"offset" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"limit" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"query" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioSearchPhotoByText (ValueProperties) 

- (FLZenfolioSortOrder) sortOrderValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] sortOrderFromString:self.sortOrder];
}

- (void) setSortOrderValue:(FLZenfolioSortOrder) inEnumValue
{
	self.sortOrder = [[FLZenfolioApi1_6EnumLookup instance] stringFromSortOrder:inEnumValue];
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

