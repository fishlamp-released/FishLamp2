//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByTextHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchSetByTextHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchSetByTextHttpPostIn


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
	((ZFSearchSetByTextHttpPostIn*)object).limit = FLCopyOrRetainObject(_limit);
	((ZFSearchSetByTextHttpPostIn*)object).searchId = FLCopyOrRetainObject(_searchId);
	((ZFSearchSetByTextHttpPostIn*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((ZFSearchSetByTextHttpPostIn*)object).type = FLCopyOrRetainObject(_type);
	((ZFSearchSetByTextHttpPostIn*)object).query = FLCopyOrRetainObject(_query);
	((ZFSearchSetByTextHttpPostIn*)object).offset = FLCopyOrRetainObject(_offset);
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

+ (ZFSearchSetByTextHttpPostIn*) searchSetByTextHttpPostIn
{
	return FLAutorelease([[ZFSearchSetByTextHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"searchId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"type" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sortOrder" withClass:[NSString class]];
		[describer setChildForIdentifier:@"query" withClass:[NSString class]];
		[describer setChildForIdentifier:@"offset" withClass:[NSString class]];
		[describer setChildForIdentifier:@"limit" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

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

@implementation ZFSearchSetByTextHttpPostIn (ValueProperties) 
@end

