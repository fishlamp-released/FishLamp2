//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSharedFavoritesSet.m
//	Project: FishLamp
//	Schema: ZenObjects
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSharedFavoritesSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSharedFavoritesSet


@synthesize favoritesSetName = _favoritesSetName;
@synthesize photoIds = _photoIds;
@synthesize photographerLogin = _photographerLogin;
@synthesize sharedFavoritesSetId = _sharedFavoritesSetId;
@synthesize sharerEmail = _sharerEmail;
@synthesize sharerMessage = _sharerMessage;
@synthesize sharerName = _sharerName;

+ (NSString*) favoritesSetNameKey
{
	return @"favoritesSetName";
}

+ (NSString*) photoIdsKey
{
	return @"photoIds";
}

+ (NSString*) photographerLoginKey
{
	return @"photographerLogin";
}

+ (NSString*) sharedFavoritesSetIdKey
{
	return @"sharedFavoritesSetId";
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
	((ZFSharedFavoritesSet*)object).sharedFavoritesSetId = FLCopyOrRetainObject(_sharedFavoritesSetId);
	((ZFSharedFavoritesSet*)object).sharerName = FLCopyOrRetainObject(_sharerName);
	((ZFSharedFavoritesSet*)object).favoritesSetName = FLCopyOrRetainObject(_favoritesSetName);
	((ZFSharedFavoritesSet*)object).photographerLogin = FLCopyOrRetainObject(_photographerLogin);
	((ZFSharedFavoritesSet*)object).photoIds = FLCopyOrRetainObject(_photoIds);
	((ZFSharedFavoritesSet*)object).sharerEmail = FLCopyOrRetainObject(_sharerEmail);
	((ZFSharedFavoritesSet*)object).sharerMessage = FLCopyOrRetainObject(_sharerMessage);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_sharedFavoritesSetId);
	FLRelease(_sharerName);
	FLRelease(_sharerMessage);
	FLRelease(_sharerEmail);
	FLRelease(_photographerLogin);
	FLRelease(_favoritesSetName);
	FLRelease(_photoIds);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_sharedFavoritesSetId) [aCoder encodeObject:_sharedFavoritesSetId forKey:@"_sharedFavoritesSetId"];
	if(_sharerName) [aCoder encodeObject:_sharerName forKey:@"_sharerName"];
	if(_sharerMessage) [aCoder encodeObject:_sharerMessage forKey:@"_sharerMessage"];
	if(_sharerEmail) [aCoder encodeObject:_sharerEmail forKey:@"_sharerEmail"];
	if(_photographerLogin) [aCoder encodeObject:_photographerLogin forKey:@"_photographerLogin"];
	if(_favoritesSetName) [aCoder encodeObject:_favoritesSetName forKey:@"_favoritesSetName"];
	if(_photoIds) [aCoder encodeObject:_photoIds forKey:@"_photoIds"];
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
		_sharedFavoritesSetId = FLRetain([aDecoder decodeObjectForKey:@"_sharedFavoritesSetId"]);
		_sharerName = FLRetain([aDecoder decodeObjectForKey:@"_sharerName"]);
		_sharerMessage = FLRetain([aDecoder decodeObjectForKey:@"_sharerMessage"]);
		_sharerEmail = FLRetain([aDecoder decodeObjectForKey:@"_sharerEmail"]);
		_photographerLogin = FLRetain([aDecoder decodeObjectForKey:@"_photographerLogin"]);
		_favoritesSetName = FLRetain([aDecoder decodeObjectForKey:@"_favoritesSetName"]);
		_photoIds = [[aDecoder decodeObjectForKey:@"_photoIds"] mutableCopy];
	}
	return self;
}

+ (ZFSharedFavoritesSet*) sharedFavoritesSet
{
	return FLAutorelease([[ZFSharedFavoritesSet alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"sharedFavoritesSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerMessage" withClass:[NSString class]];
		[describer setChildForIdentifier:@"sharerEmail" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photographerLogin" withClass:[NSString class]];
		[describer setChildForIdentifier:@"favoritesSetName" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoIds" withClass:[NSMutableSet class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharedFavoritesSetId" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLPrimaryKeyConstraint primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerMessage" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"sharerEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photographerLogin" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"favoritesSetName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoIds" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSharedFavoritesSet (ValueProperties) 
@end

