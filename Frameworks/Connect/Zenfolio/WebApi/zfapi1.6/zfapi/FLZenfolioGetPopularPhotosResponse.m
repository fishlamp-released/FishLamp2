//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetPopularPhotosResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGetPopularPhotosResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLZenfolioPhoto.h"

@implementation FLZenfolioGetPopularPhotosResponse


@synthesize GetPopularPhotosResult = _GetPopularPhotosResult;

+ (NSString*) GetPopularPhotosResultKey
{
	return @"GetPopularPhotosResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGetPopularPhotosResponse*)object).GetPopularPhotosResult = FLCopyOrRetainObject(_GetPopularPhotosResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetPopularPhotosResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetPopularPhotosResult) [aCoder encodeObject:_GetPopularPhotosResult forKey:@"_GetPopularPhotosResult"];
}

+ (FLZenfolioGetPopularPhotosResponse*) getPopularPhotosResponse
{
	return FLAutorelease([[FLZenfolioGetPopularPhotosResponse alloc] init]);
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
		_GetPopularPhotosResult = [[aDecoder decodeObjectForKey:@"_GetPopularPhotosResult"] mutableCopy];
	}
	return self;
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
		[s_describer addProperty:@"GetPopularPhotosResult" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"Photo" propertyClass:[FLZenfolioPhoto class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetPopularPhotosResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGetPopularPhotosResponse (ValueProperties) 
@end

