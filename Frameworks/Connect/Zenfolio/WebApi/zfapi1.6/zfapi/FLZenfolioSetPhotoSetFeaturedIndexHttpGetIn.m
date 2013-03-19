//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn


@synthesize index = _index;
@synthesize photoSetId = _photoSetId;

+ (NSString*) indexKey
{
	return @"index";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*)object).index = FLCopyOrRetainObject(_index);
	((FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoSetId);
	FLRelease(_index);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_index) [aCoder encodeObject:_index forKey:@"_index"];
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
		_photoSetId = FLRetain([aDecoder decodeObjectForKey:@"_photoSetId"]);
		_index = FLRetain([aDecoder decodeObjectForKey:@"_index"]);
	}
	return self;
}

+ (FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn*) setPhotoSetFeaturedIndexHttpGetIn
{
	return FLAutorelease([[FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn alloc] init]);
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
		[s_describer addProperty:@"photoSetId" withClass:[NSString class]];
		[s_describer addProperty:@"index" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioSetPhotoSetFeaturedIndexHttpGetIn (ValueProperties) 
@end

