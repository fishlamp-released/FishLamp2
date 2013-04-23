//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSetHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSetHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoSetHttpGetIn


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
	((ZFLoadPhotoSetHttpGetIn*)object).level = FLCopyOrRetainObject(_level);
	((ZFLoadPhotoSetHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFLoadPhotoSetHttpGetIn*)object).includePhotos = FLCopyOrRetainObject(_includePhotos);
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

+ (ZFLoadPhotoSetHttpGetIn*) loadPhotoSetHttpGetIn
{
	return FLAutorelease([[ZFLoadPhotoSetHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"photoSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"level" withClass:[NSString class]];
		[describer setChildForIdentifier:@"includePhotos" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includePhotos" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSetHttpGetIn (ValueProperties) 
@end

