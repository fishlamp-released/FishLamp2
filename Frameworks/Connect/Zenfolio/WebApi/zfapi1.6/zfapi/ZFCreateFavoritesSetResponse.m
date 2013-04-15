//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCreateFavoritesSetResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCreateFavoritesSetResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFCreateFavoritesSetResponse


@synthesize CreateFavoritesSetResult = _CreateFavoritesSetResult;

+ (NSString*) CreateFavoritesSetResultKey
{
	return @"CreateFavoritesSetResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCreateFavoritesSetResponse*)object).CreateFavoritesSetResult = FLCopyOrRetainObject(_CreateFavoritesSetResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (ZFCreateFavoritesSetResponse*) createFavoritesSetResponse
{
	return FLAutorelease([[ZFCreateFavoritesSetResponse alloc] init]);
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

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer setChildForIdentifier:@"CreateFavoritesSetResult" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreateFavoritesSetResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCreateFavoritesSetResponse (ValueProperties) 

- (int) CreateFavoritesSetResultValue
{
	return [self.CreateFavoritesSetResult intValue];
}

- (void) setCreateFavoritesSetResultValue:(int) value
{
	self.CreateFavoritesSetResult = [NSNumber numberWithInt:value];
}
@end

