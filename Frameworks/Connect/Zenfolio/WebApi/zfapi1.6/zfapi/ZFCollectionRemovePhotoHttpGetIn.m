//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCollectionRemovePhotoHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCollectionRemovePhotoHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCollectionRemovePhotoHttpGetIn


@synthesize collectionId = _collectionId;
@synthesize photoId = _photoId;

+ (NSString*) collectionIdKey
{
	return @"collectionId";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (ZFCollectionRemovePhotoHttpGetIn*) collectionRemovePhotoHttpGetIn
{
	return FLAutorelease([[ZFCollectionRemovePhotoHttpGetIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCollectionRemovePhotoHttpGetIn*)object).collectionId = FLCopyOrRetainObject(_collectionId);
	((ZFCollectionRemovePhotoHttpGetIn*)object).photoId = FLCopyOrRetainObject(_photoId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_collectionId);
	FLRelease(_photoId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_collectionId) [aCoder encodeObject:_collectionId forKey:@"_collectionId"];
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
		_collectionId = FLRetain([aDecoder decodeObjectForKey:@"_collectionId"]);
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"collectionId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"photoId" withClass:[NSString class]];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"collectionId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCollectionRemovePhotoHttpGetIn (ValueProperties) 
@end

