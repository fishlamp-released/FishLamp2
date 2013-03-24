//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCollectionRemovePhoto.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCollectionRemovePhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCollectionRemovePhoto


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

+ (ZFCollectionRemovePhoto*) collectionRemovePhoto
{
	return FLAutorelease([[ZFCollectionRemovePhoto alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCollectionRemovePhoto*)object).collectionId = FLCopyOrRetainObject(_collectionId);
	((ZFCollectionRemovePhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
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
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addProperty:@"collectionId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"photoId" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"collectionId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCollectionRemovePhoto (ValueProperties) 

- (int) collectionIdValue
{
	return [self.collectionId intValue];
}

- (void) setCollectionIdValue:(int) value
{
	self.collectionId = [NSNumber numberWithInt:value];
}

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}
@end

