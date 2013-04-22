//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSetPhotoSetTitlePhotoHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSetPhotoSetTitlePhotoHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSetPhotoSetTitlePhotoHttpGetIn


@synthesize photoId = _photoId;
@synthesize photoSetId = _photoSetId;

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFSetPhotoSetTitlePhotoHttpGetIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFSetPhotoSetTitlePhotoHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
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
	FLRelease(_photoId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
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
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
	}
	return self;
}

+ (ZFSetPhotoSetTitlePhotoHttpGetIn*) setPhotoSetTitlePhotoHttpGetIn
{
	return FLAutorelease([[ZFSetPhotoSetTitlePhotoHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"photoSetId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoId" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSetPhotoSetTitlePhotoHttpGetIn (ValueProperties) 
@end

