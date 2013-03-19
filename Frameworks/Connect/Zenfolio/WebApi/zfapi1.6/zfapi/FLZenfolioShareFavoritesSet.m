//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioShareFavoritesSet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioShareFavoritesSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioShareFavoritesSet


@synthesize favoritesSetId = _favoritesSetId;
@synthesize favoritesSetName = _favoritesSetName;
@synthesize sharerEmail = _sharerEmail;
@synthesize sharerMessage = _sharerMessage;
@synthesize sharerName = _sharerName;

+ (NSString*) favoritesSetIdKey
{
	return @"favoritesSetId";
}

+ (NSString*) favoritesSetNameKey
{
	return @"favoritesSetName";
}

+ (NSString*) sharerEmailKey
{
	return @"sharerEmail";
}

+ (NSString*) sharerMessageKey
{
	return @"sharerMessage";
}

+ (NSString*) sharerNameKey
{
	return @"sharerName";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioShareFavoritesSet*)object).sharerEmail = FLCopyOrRetainObject(_sharerEmail);
	((FLZenfolioShareFavoritesSet*)object).favoritesSetId = FLCopyOrRetainObject(_favoritesSetId);
	((FLZenfolioShareFavoritesSet*)object).favoritesSetName = FLCopyOrRetainObject(_favoritesSetName);
	((FLZenfolioShareFavoritesSet*)object).sharerName = FLCopyOrRetainObject(_sharerName);
	((FLZenfolioShareFavoritesSet*)object).sharerMessage = FLCopyOrRetainObject(_sharerMessage);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_favoritesSetId);
	FLRelease(_favoritesSetName);
	FLRelease(_sharerName);
	FLRelease(_sharerEmail);
	FLRelease(_sharerMessage);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_favoritesSetId) [aCoder encodeObject:_favoritesSetId forKey:@"_favoritesSetId"];
	if(_favoritesSetName) [aCoder encodeObject:_favoritesSetName forKey:@"_favoritesSetName"];
	if(_sharerName) [aCoder encodeObject:_sharerName forKey:@"_sharerName"];
	if(_sharerEmail) [aCoder encodeObject:_sharerEmail forKey:@"_sharerEmail"];
	if(_sharerMessage) [aCoder encodeObject:_sharerMessage forKey:@"_sharerMessage"];
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
		_favoritesSetId = FLRetain([aDecoder decodeObjectForKey:@"_favoritesSetId"]);
		_favoritesSetName = FLRetain([aDecoder decodeObjectForKey:@"_favoritesSetName"]);
		_sharerName = FLRetain([aDecoder decodeObjectForKey:@"_sharerName"]);
		_sharerEmail = FLRetain([aDecoder decodeObjectForKey:@"_sharerEmail"]);
		_sharerMessage = FLRetain([aDecoder decodeObjectForKey:@"_sharerMessage"]);
	}
	return self;
}

+ (FLZenfolioShareFavoritesSet*) shareFavoritesSet
{
	return FLAutorelease([[FLZenfolioShareFavoritesSet alloc] init]);
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
		[s_describer addProperty:@"favoritesSetId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"favoritesSetName" withClass:[NSString class]];
		[s_describer addProperty:@"sharerName" withClass:[NSString class]];
		[s_describer addProperty:@"sharerEmail" withClass:[NSString class]];
		[s_describer addProperty:@"sharerMessage" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"favoritesSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"favoritesSetName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerMessage" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioShareFavoritesSet (ValueProperties) 

- (int) favoritesSetIdValue
{
	return [self.favoritesSetId intValue];
}

- (void) setFavoritesSetIdValue:(int) value
{
	self.favoritesSetId = [NSNumber numberWithInt:value];
}
@end

