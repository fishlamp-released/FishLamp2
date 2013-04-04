//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSetPhotosHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoSetPhotosHttpGetIn


@synthesize numberOfPhotos = _numberOfPhotos;
@synthesize photoSetId = _photoSetId;
@synthesize startingIndex = _startingIndex;

+ (NSString*) numberOfPhotosKey
{
	return @"numberOfPhotos";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

+ (NSString*) startingIndexKey
{
	return @"startingIndex";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhotoSetPhotosHttpGetIn*)object).startingIndex = FLCopyOrRetainObject(_startingIndex);
	((ZFLoadPhotoSetPhotosHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFLoadPhotoSetPhotosHttpGetIn*)object).numberOfPhotos = FLCopyOrRetainObject(_numberOfPhotos);
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
	FLRelease(_startingIndex);
	FLRelease(_numberOfPhotos);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_startingIndex) [aCoder encodeObject:_startingIndex forKey:@"_startingIndex"];
	if(_numberOfPhotos) [aCoder encodeObject:_numberOfPhotos forKey:@"_numberOfPhotos"];
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
		_startingIndex = FLRetain([aDecoder decodeObjectForKey:@"_startingIndex"]);
		_numberOfPhotos = FLRetain([aDecoder decodeObjectForKey:@"_numberOfPhotos"]);
	}
	return self;
}

+ (ZFLoadPhotoSetPhotosHttpGetIn*) loadPhotoSetPhotosHttpGetIn
{
	return FLAutorelease([[ZFLoadPhotoSetPhotosHttpGetIn alloc] init]);
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
		[s_describer addChildDescriberWithName:@"photoSetId" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"startingIndex" withClass:[NSString class]];
		[s_describer addChildDescriberWithName:@"numberOfPhotos" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startingIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"numberOfPhotos" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSetPhotosHttpGetIn (ValueProperties) 
@end

