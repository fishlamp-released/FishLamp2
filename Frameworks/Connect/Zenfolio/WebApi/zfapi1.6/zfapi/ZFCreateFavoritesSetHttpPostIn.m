//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateFavoritesSetHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateFavoritesSetHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateFavoritesSetHttpPostIn


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
	((ZFCreateFavoritesSetHttpPostIn*)object).name = FLCopyOrRetainObject(_name);
	((ZFCreateFavoritesSetHttpPostIn*)object).photographerLogin = FLCopyOrRetainObject(_photographerLogin);
	((ZFCreateFavoritesSetHttpPostIn*)object).photoIds = FLCopyOrRetainObject(_photoIds);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateFavoritesSetHttpPostIn*) createFavoritesSetHttpPostIn
{
	return FLAutorelease([[ZFCreateFavoritesSetHttpPostIn alloc] init]);
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
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"name" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photographerLogin" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoIds" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"String" class:[NSString class] ], nil]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"name" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photographerLogin" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoIds" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateFavoritesSetHttpPostIn (ValueProperties) 
@end

