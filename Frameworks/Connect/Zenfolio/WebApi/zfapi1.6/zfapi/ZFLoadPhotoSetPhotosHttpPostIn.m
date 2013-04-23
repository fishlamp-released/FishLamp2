//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetPhotosHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSetPhotosHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoSetPhotosHttpPostIn


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
	((ZFLoadPhotoSetPhotosHttpPostIn*)object).startingIndex = FLCopyOrRetainObject(_startingIndex);
	((ZFLoadPhotoSetPhotosHttpPostIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFLoadPhotoSetPhotosHttpPostIn*)object).numberOfPhotos = FLCopyOrRetainObject(_numberOfPhotos);
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

+ (ZFLoadPhotoSetPhotosHttpPostIn*) loadPhotoSetPhotosHttpPostIn
{
	return FLAutorelease([[ZFLoadPhotoSetPhotosHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"photoSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"startingIndex" withClass:[NSString class]];
		[describer setChildForIdentifier:@"numberOfPhotos" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startingIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"numberOfPhotos" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSetPhotosHttpPostIn (ValueProperties) 
@end

