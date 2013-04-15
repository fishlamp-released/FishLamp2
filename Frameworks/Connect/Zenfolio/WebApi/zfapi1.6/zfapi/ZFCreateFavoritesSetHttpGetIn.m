//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateFavoritesSetHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateFavoritesSetHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateFavoritesSetHttpGetIn


@synthesize name = _name;
@synthesize photoIds = _photoIds;
@synthesize photographerLogin = _photographerLogin;

+ (NSString*) nameKey
{
	return @"name";
}

+ (NSString*) photoIdsKey
{
	return @"photoIds";
}

+ (NSString*) photographerLoginKey
{
	return @"photographerLogin";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreateFavoritesSetHttpGetIn*)object).name = FLCopyOrRetainObject(_name);
	((ZFCreateFavoritesSetHttpGetIn*)object).photographerLogin = FLCopyOrRetainObject(_photographerLogin);
	((ZFCreateFavoritesSetHttpGetIn*)object).photoIds = FLCopyOrRetainObject(_photoIds);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateFavoritesSetHttpGetIn*) createFavoritesSetHttpGetIn
{
	return FLAutorelease([[ZFCreateFavoritesSetHttpGetIn alloc] init]);
}

- (void) dealloc
{
	FLRelease(_name);
	FLRelease(_photographerLogin);
	FLRelease(_photoIds);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_name) [aCoder encodeObject:_name forKey:@"_name"];
	if(_photographerLogin) [aCoder encodeObject:_photographerLogin forKey:@"_photographerLogin"];
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
		_name = FLRetain([aDecoder decodeObjectForKey:@"_name"]);
		_photographerLogin = FLRetain([aDecoder decodeObjectForKey:@"_photographerLogin"]);
		_photoIds = [[aDecoder decodeObjectForKey:@"_photoIds"] mutableCopy];
	}
	return self;
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
		[s_describer setChildForIdentifier:@"name" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"photographerLogin" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"photoIds" withArrayTypes:[NSArray arrayWithObjects:[FLTypeDesc typeDesc:@"String" class:[NSString class] ], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photographerLogin" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoIds" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateFavoritesSetHttpGetIn (ValueProperties) 
@end

