//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchSetByText.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchSetByText.h"
#import "ZFApi1_6Enums.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchSetByText


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
	((ZFSearchSetByText*)object).limit = FLCopyOrRetainObject(_limit);
	((ZFSearchSetByText*)object).searchId = FLCopyOrRetainObject(_searchId);
	((ZFSearchSetByText*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((ZFSearchSetByText*)object).type = FLCopyOrRetainObject(_type);
	((ZFSearchSetByText*)object).query = FLCopyOrRetainObject(_query);
	((ZFSearchSetByText*)object).offset = FLCopyOrRetainObject(_offset);
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

+ (ZFSearchSetByText*) searchSetByText
{
	return FLAutorelease([[ZFSearchSetByText alloc] init]);
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
		[describer setChildForIdentifier:@"offset" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"limit" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchSetByText (ValueProperties) 

- (ZFPhotoSetType) typeValue
{
	return [[ZFApi1_6EnumLookup instance] photoSetTypeFromString:self.type];
}

- (void) setTypeValue:(ZFPhotoSetType) inEnumValue
{
	self.type = [[ZFApi1_6EnumLookup instance] stringFromPhotoSetType:inEnumValue];
}

- (ZFSortOrder) sortOrderValue
{
	return [[ZFApi1_6EnumLookup instance] sortOrderFromString:self.sortOrder];
}

- (void) setSortOrderValue:(ZFSortOrder) inEnumValue
{
	self.sortOrder = [[ZFApi1_6EnumLookup instance] stringFromSortOrder:inEnumValue];
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

