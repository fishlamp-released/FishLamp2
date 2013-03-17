//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSetPhotosResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioLoadPhotoSetPhotosResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLZenfolioPhoto.h"

@implementation FLZenfolioLoadPhotoSetPhotosResponse


@synthesize LoadPhotoSetPhotosResult = _LoadPhotoSetPhotosResult;

+ (NSString*) LoadPhotoSetPhotosResultKey
{
	return @"LoadPhotoSetPhotosResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioLoadPhotoSetPhotosResponse*)object).LoadPhotoSetPhotosResult = FLCopyOrRetainObject(_LoadPhotoSetPhotosResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPhotoSetPhotosResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPhotoSetPhotosResult) [aCoder encodeObject:_LoadPhotoSetPhotosResult forKey:@"_LoadPhotoSetPhotosResult"];
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
		_LoadPhotoSetPhotosResult = [[aDecoder decodeObjectForKey:@"_LoadPhotoSetPhotosResult"] mutableCopy];
	}
	return self;
}

+ (FLZenfolioLoadPhotoSetPhotosResponse*) loadPhotoSetPhotosResponse
{
	return FLAutorelease([[FLZenfolioLoadPhotoSetPhotosResponse alloc] init]);
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
		[s_describer addProperty:@"LoadPhotoSetPhotosResult" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Photo" propertyClass:[FLZenfolioPhoto class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPhotoSetPhotosResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioLoadPhotoSetPhotosResponse (ValueProperties) 
@end

