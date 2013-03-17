//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSetHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioLoadPhotoSetHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioLoadPhotoSetHttpGetIn


@synthesize includePhotos = _includePhotos;
@synthesize level = _level;
@synthesize photoSetId = _photoSetId;

+ (NSString*) includePhotosKey
{
	return @"includePhotos";
}

+ (NSString*) levelKey
{
	return @"level";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioLoadPhotoSetHttpGetIn*)object).level = FLCopyOrRetainObject(_level);
	((FLZenfolioLoadPhotoSetHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZenfolioLoadPhotoSetHttpGetIn*)object).includePhotos = FLCopyOrRetainObject(_includePhotos);
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
	FLRelease(_level);
	FLRelease(_includePhotos);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_level) [aCoder encodeObject:_level forKey:@"_level"];
	if(_includePhotos) [aCoder encodeObject:_includePhotos forKey:@"_includePhotos"];
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
		_level = FLRetain([aDecoder decodeObjectForKey:@"_level"]);
		_includePhotos = FLRetain([aDecoder decodeObjectForKey:@"_includePhotos"]);
	}
	return self;
}

+ (FLZenfolioLoadPhotoSetHttpGetIn*) loadPhotoSetHttpGetIn
{
	return FLAutorelease([[FLZenfolioLoadPhotoSetHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) sharedObjectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_describer = [[super sharedObjectDescriber] copy];
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addProperty:@"photoSetId" withClass:[NSString class]];
		[s_describer addProperty:@"level" withClass:[NSString class]];
		[s_describer addProperty:@"includePhotos" withClass:[NSString class]];
	});
	return s_describer;
}

+ (FLObjectInflator*) sharedObjectInflator
{
	static FLObjectInflator* s_inflator = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		s_inflator = [[FLObjectInflator alloc] initWithObjectDescriber:[[self class] sharedObjectDescriber]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includePhotos" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioLoadPhotoSetHttpGetIn (ValueProperties) 
@end

