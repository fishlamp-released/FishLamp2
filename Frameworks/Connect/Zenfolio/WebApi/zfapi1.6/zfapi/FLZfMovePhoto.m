//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfMovePhoto.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfMovePhoto.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfMovePhoto


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
	((FLZfMovePhoto*)object).destSetId = FLCopyOrRetainObject(_destSetId);
	((FLZfMovePhoto*)object).index = FLCopyOrRetainObject(_index);
	((FLZfMovePhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZfMovePhoto*)object).srcSetId = FLCopyOrRetainObject(_srcSetId);
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

+ (FLZfMovePhoto*) movePhoto
{
	return FLAutorelease([[FLZfMovePhoto alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"srcSetId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"srcSetId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"photoId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"destSetId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"destSetId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"index" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"index"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"srcSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"destSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfMovePhoto (ValueProperties) 

- (int) srcSetIdValue
{
	return [self.srcSetId intValue];
}

- (void) setSrcSetIdValue:(int) value
{
	self.srcSetId = [NSNumber numberWithInt:value];
}

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}

- (int) destSetIdValue
{
	return [self.destSetId intValue];
}

- (void) setDestSetIdValue:(int) value
{
	self.destSetId = [NSNumber numberWithInt:value];
}

- (int) indexValue
{
	return [self.index intValue];
}

- (void) setIndexValue:(int) value
{
	self.index = [NSNumber numberWithInt:value];
}
@end

