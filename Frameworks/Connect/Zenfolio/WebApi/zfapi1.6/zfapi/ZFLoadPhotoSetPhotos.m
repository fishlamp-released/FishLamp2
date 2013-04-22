//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotos.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSetPhotos.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoSetPhotos


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
	((ZFLoadPhotoSetPhotos*)object).startingIndex = FLCopyOrRetainObject(_startingIndex);
	((ZFLoadPhotoSetPhotos*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFLoadPhotoSetPhotos*)object).numberOfPhotos = FLCopyOrRetainObject(_numberOfPhotos);
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

+ (ZFLoadPhotoSetPhotos*) loadPhotoSetPhotos
{
	return FLAutorelease([[ZFLoadPhotoSetPhotos alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"photoSetId" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"startingIndex" withClass:[FLIntegerNumber class] ];
		[describer setChildForIdentifier:@"numberOfPhotos" withClass:[FLIntegerNumber class] ];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startingIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"numberOfPhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSetPhotos (ValueProperties) 

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

