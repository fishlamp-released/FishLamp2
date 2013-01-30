//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateFavoritesSetResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCreateFavoritesSetResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioCreateFavoritesSetResponse


@synthesize CreateFavoritesSetResult = _CreateFavoritesSetResult;

+ (NSString*) CreateFavoritesSetResultKey
{
	return @"CreateFavoritesSetResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCreateFavoritesSetResponse*)object).CreateFavoritesSetResult = FLCopyOrRetainObject(_CreateFavoritesSetResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZenfolioCreateFavoritesSetResponse*) createFavoritesSetResponse
{
	return FLAutorelease([[FLZenfolioCreateFavoritesSetResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreateFavoritesSetResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreateFavoritesSetResult) [aCoder encodeObject:_CreateFavoritesSetResult forKey:@"_CreateFavoritesSetResult"];
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
		_CreateFavoritesSetResult = FLRetain([aDecoder decodeObjectForKey:@"_CreateFavoritesSetResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CreateFavoritesSetResult" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"CreateFavoritesSetResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreateFavoritesSetResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCreateFavoritesSetResponse (ValueProperties) 

- (int) CreateFavoritesSetResultValue
{
	return [self.CreateFavoritesSetResult intValue];
}

- (void) setCreateFavoritesSetResultValue:(int) value
{
	self.CreateFavoritesSetResult = [NSNumber numberWithInt:value];
}
@end

