//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPhotoSetPhotos.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfLoadPhotoSetPhotos.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfLoadPhotoSetPhotos


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
	((FLZfLoadPhotoSetPhotos*)object).startingIndex = FLCopyOrRetainObject(_startingIndex);
	((FLZfLoadPhotoSetPhotos*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZfLoadPhotoSetPhotos*)object).numberOfPhotos = FLCopyOrRetainObject(_numberOfPhotos);
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

+ (FLZfLoadPhotoSetPhotos*) loadPhotoSetPhotos
{
	return FLAutorelease([[FLZfLoadPhotoSetPhotos alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoSetId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"photoSetId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"startingIndex" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"startingIndex"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"numberOfPhotos" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"numberOfPhotos"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startingIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"numberOfPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfLoadPhotoSetPhotos (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}

- (int) startingIndexValue
{
	return [self.startingIndex intValue];
}

- (void) setStartingIndexValue:(int) value
{
	self.startingIndex = [NSNumber numberWithInt:value];
}

- (int) numberOfPhotosValue
{
	return [self.numberOfPhotos intValue];
}

- (void) setNumberOfPhotosValue:(int) value
{
	self.numberOfPhotos = [NSNumber numberWithInt:value];
}
@end

