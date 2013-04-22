//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFShareFavoritesSetHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFShareFavoritesSetHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFShareFavoritesSetHttpPostIn


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
	((ZFShareFavoritesSetHttpPostIn*)object).sharerEmail = FLCopyOrRetainObject(_sharerEmail);
	((ZFShareFavoritesSetHttpPostIn*)object).favoritesSetId = FLCopyOrRetainObject(_favoritesSetId);
	((ZFShareFavoritesSetHttpPostIn*)object).favoritesSetName = FLCopyOrRetainObject(_favoritesSetName);
	((ZFShareFavoritesSetHttpPostIn*)object).sharerName = FLCopyOrRetainObject(_sharerName);
	((ZFShareFavoritesSetHttpPostIn*)object).sharerMessage = FLCopyOrRetainObject(_sharerMessage);
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

+ (ZFShareFavoritesSetHttpPostIn*) shareFavoritesSetHttpPostIn
{
	return FLAutorelease([[ZFShareFavoritesSetHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"favoritesSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"favoritesSetName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerEmail" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerMessage" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"favoritesSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"favoritesSetName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerMessage" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFShareFavoritesSetHttpPostIn (ValueProperties) 
@end

