//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetPhotosHttpPostIn.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfLoadPhotoSetPhotosHttpPostIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfLoadPhotoSetPhotosHttpPostIn


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
	((FLZfLoadPhotoSetPhotosHttpPostIn*)object).startingIndex = FLCopyOrRetainObject(_startingIndex);
	((FLZfLoadPhotoSetPhotosHttpPostIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZfLoadPhotoSetPhotosHttpPostIn*)object).numberOfPhotos = FLCopyOrRetainObject(_numberOfPhotos);
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

+ (FLZfLoadPhotoSetPhotosHttpPostIn*) loadPhotoSetPhotosHttpPostIn
{
	return FLAutorelease([[FLZfLoadPhotoSetPhotosHttpPostIn alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoSetId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"photoSetId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"startingIndex" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"startingIndex"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"numberOfPhotos" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"numberOfPhotos"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startingIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"numberOfPhotos" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfLoadPhotoSetPhotosHttpPostIn (ValueProperties) 
@end

