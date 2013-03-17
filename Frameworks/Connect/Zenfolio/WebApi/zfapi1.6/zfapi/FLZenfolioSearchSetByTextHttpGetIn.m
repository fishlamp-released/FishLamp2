//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchSetByTextHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioSearchSetByTextHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioSearchSetByTextHttpGetIn


@synthesize limit = _limit;
@synthesize offset = _offset;
@synthesize query = _query;
@synthesize searchId = _searchId;
@synthesize sortOrder = _sortOrder;
@synthesize type = _type;

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

+ (NSString*) typeKey
{
	return @"type";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioSearchSetByTextHttpGetIn*)object).limit = FLCopyOrRetainObject(_limit);
	((FLZenfolioSearchSetByTextHttpGetIn*)object).searchId = FLCopyOrRetainObject(_searchId);
	((FLZenfolioSearchSetByTextHttpGetIn*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((FLZenfolioSearchSetByTextHttpGetIn*)object).type = FLCopyOrRetainObject(_type);
	((FLZenfolioSearchSetByTextHttpGetIn*)object).query = FLCopyOrRetainObject(_query);
	((FLZenfolioSearchSetByTextHttpGetIn*)object).offset = FLCopyOrRetainObject(_offset);
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
	FLRelease(_type);
	FLRelease(_sortOrder);
	FLRelease(_query);
	FLRelease(_offset);
	FLRelease(_limit);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_searchId) [aCoder encodeObject:_searchId forKey:@"_searchId"];
	if(_type) [aCoder encodeObject:_type forKey:@"_type"];
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
		_type = FLRetain([aDecoder decodeObjectForKey:@"_type"]);
		_sortOrder = FLRetain([aDecoder decodeObjectForKey:@"_sortOrder"]);
		_query = FLRetain([aDecoder decodeObjectForKey:@"_query"]);
		_offset = FLRetain([aDecoder decodeObjectForKey:@"_offset"]);
		_limit = FLRetain([aDecoder decodeObjectForKey:@"_limit"]);
	}
	return self;
}

+ (FLZenfolioSearchSetByTextHttpGetIn*) searchSetByTextHttpGetIn
{
	return FLAutorelease([[FLZenfolioSearchSetByTextHttpGetIn alloc] init]);
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
		[s_describer addProperty:@"type" withClass:[NSString class]];
		[s_describer addProperty:@"sortOrder" withClass:[NSString class]];
		[s_describer addProperty:@"query" withClass:[NSString class]];
		[s_describer addProperty:@"offset" withClass:[NSString class]];
		[s_describer addProperty:@"limit" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"type" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sortOrder" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"query" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioSearchSetByTextHttpGetIn (ValueProperties) 
@end

