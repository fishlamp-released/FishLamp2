//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadSharedFavoritesSetsResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadSharedFavoritesSetsResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFFavoritesSet.h"

@implementation ZFLoadSharedFavoritesSetsResponse


@synthesize LoadSharedFavoritesSetsResult = _LoadSharedFavoritesSetsResult;

+ (NSString*) LoadSharedFavoritesSetsResultKey
{
	return @"LoadSharedFavoritesSetsResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadSharedFavoritesSetsResponse*)object).LoadSharedFavoritesSetsResult = FLCopyOrRetainObject(_LoadSharedFavoritesSetsResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadSharedFavoritesSetsResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadSharedFavoritesSetsResult) [aCoder encodeObject:_LoadSharedFavoritesSetsResult forKey:@"_LoadSharedFavoritesSetsResult"];
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
		_LoadSharedFavoritesSetsResult = [[aDecoder decodeObjectForKey:@"_LoadSharedFavoritesSetsResult"] mutableCopy];
	}
	return self;
}

+ (ZFLoadSharedFavoritesSetsResponse*) loadSharedFavoritesSetsResponse
{
	return FLAutorelease([[ZFLoadSharedFavoritesSetsResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addChildDescriberWithName:@"LoadSharedFavoritesSetsResult" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"FavoritesSet" objectClass:[ZFFavoritesSet class]], nil]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] objectDescriber]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadSharedFavoritesSetsResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadSharedFavoritesSetsResponse (ValueProperties) 
@end
