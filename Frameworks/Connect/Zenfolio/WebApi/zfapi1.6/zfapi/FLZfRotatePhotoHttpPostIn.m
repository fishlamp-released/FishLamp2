//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfRotatePhotoHttpPostIn.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfRotatePhotoHttpPostIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfRotatePhotoHttpPostIn


@synthesize photoId = _photoId;
@synthesize rotation = _rotation;

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) rotationKey
{
	return @"rotation";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfRotatePhotoHttpPostIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZfRotatePhotoHttpPostIn*)object).rotation = FLCopyOrRetainObject(_rotation);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoId);
	FLRelease(_rotation);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_rotation) [aCoder encodeObject:_rotation forKey:@"_rotation"];
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
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_rotation = FLRetain([aDecoder decodeObjectForKey:@"_rotation"]);
	}
	return self;
}

+ (FLZfRotatePhotoHttpPostIn*) rotatePhotoHttpPostIn
{
	return FLAutorelease([[FLZfRotatePhotoHttpPostIn alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"photoId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"rotation" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"rotation"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"rotation" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfRotatePhotoHttpPostIn (ValueProperties) 
@end

