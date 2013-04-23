//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByCategoryHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchPhotoByCategoryHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchPhotoByCategoryHttpGetIn


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
	((ZFSearchPhotoByCategoryHttpGetIn*)object).categoryCode = FLCopyOrRetainObject(_categoryCode);
	((ZFSearchPhotoByCategoryHttpGetIn*)object).searchId = FLCopyOrRetainObject(_searchId);
	((ZFSearchPhotoByCategoryHttpGetIn*)object).sortOrder = FLCopyOrRetainObject(_sortOrder);
	((ZFSearchPhotoByCategoryHttpGetIn*)object).offset = FLCopyOrRetainObject(_offset);
	((ZFSearchPhotoByCategoryHttpGetIn*)object).limit = FLCopyOrRetainObject(_limit);
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

+ (ZFSearchPhotoByCategoryHttpGetIn*) searchPhotoByCategoryHttpGetIn
{
	return FLAutorelease([[ZFSearchPhotoByCategoryHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"searchId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sortOrder" withClass:[NSString class]];
		[describer setChildForIdentifier:@"categoryCode" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sortOrder" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"categoryCode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"offset" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"limit" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchPhotoByCategoryHttpGetIn (ValueProperties) 
@end

