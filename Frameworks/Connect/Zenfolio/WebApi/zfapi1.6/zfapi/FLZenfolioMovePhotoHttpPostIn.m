//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioMovePhotoHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioMovePhotoHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioMovePhotoHttpPostIn


@synthesize destSetId = _destSetId;
@synthesize index = _index;
@synthesize photoId = _photoId;
@synthesize srcSetId = _srcSetId;

+ (NSString*) destSetIdKey
{
	return @"destSetId";
}

+ (NSString*) indexKey
{
	return @"index";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) srcSetIdKey
{
	return @"srcSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioMovePhotoHttpPostIn*)object).destSetId = FLCopyOrRetainObject(_destSetId);
	((FLZenfolioMovePhotoHttpPostIn*)object).index = FLCopyOrRetainObject(_index);
	((FLZenfolioMovePhotoHttpPostIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZenfolioMovePhotoHttpPostIn*)object).srcSetId = FLCopyOrRetainObject(_srcSetId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_srcSetId);
	FLRelease(_photoId);
	FLRelease(_destSetId);
	FLRelease(_index);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_srcSetId) [aCoder encodeObject:_srcSetId forKey:@"_srcSetId"];
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_destSetId) [aCoder encodeObject:_destSetId forKey:@"_destSetId"];
	if(_index) [aCoder encodeObject:_index forKey:@"_index"];
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
		_srcSetId = FLRetain([aDecoder decodeObjectForKey:@"_srcSetId"]);
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_destSetId = FLRetain([aDecoder decodeObjectForKey:@"_destSetId"]);
		_index = FLRetain([aDecoder decodeObjectForKey:@"_index"]);
	}
	return self;
}

+ (FLZenfolioMovePhotoHttpPostIn*) movePhotoHttpPostIn
{
	return FLAutorelease([[FLZenfolioMovePhotoHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addProperty:@"srcSetId" withClass:[NSString class]];
		[s_describer addProperty:@"photoId" withClass:[NSString class]];
		[s_describer addProperty:@"destSetId" withClass:[NSString class]];
		[s_describer addProperty:@"index" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"srcSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"destSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioMovePhotoHttpPostIn (ValueProperties) 
@end

