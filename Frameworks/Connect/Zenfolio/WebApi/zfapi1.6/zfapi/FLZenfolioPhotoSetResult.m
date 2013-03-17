//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioPhotoSetResult.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioPhotoSetResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "FLZenfolioPhotoSet.h"

@implementation FLZenfolioPhotoSetResult


@synthesize PhotoSets = _PhotoSets;
@synthesize TotalCount = _TotalCount;

+ (NSString*) PhotoSetsKey
{
	return @"PhotoSets";
}

+ (NSString*) TotalCountKey
{
	return @"TotalCount";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioPhotoSetResult*)object).PhotoSets = FLCopyOrRetainObject(_PhotoSets);
	((FLZenfolioPhotoSetResult*)object).TotalCount = FLCopyOrRetainObject(_TotalCount);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_PhotoSets);
	FLRelease(_TotalCount);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_PhotoSets) [aCoder encodeObject:_PhotoSets forKey:@"_PhotoSets"];
	if(_TotalCount) [aCoder encodeObject:_TotalCount forKey:@"_TotalCount"];
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
		_PhotoSets = [[aDecoder decodeObjectForKey:@"_PhotoSets"] mutableCopy];
		_TotalCount = FLRetain([aDecoder decodeObjectForKey:@"_TotalCount"]);
	}
	return self;
}

+ (FLZenfolioPhotoSetResult*) photoSetResult
{
	return FLAutorelease([[FLZenfolioPhotoSetResult alloc] init]);
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
		[s_describer addProperty:@"PhotoSets" withArrayTypes:[NSArray arrayWithObjects:[FLPropertyType propertyType:@"PhotoSet" propertyClass:[FLZenfolioPhotoSet class]], nil]];
		[s_describer addProperty:@"TotalCount" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoSets" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TotalCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioPhotoSetResult (ValueProperties) 

- (int) TotalCountValue
{
	return [self.TotalCount intValue];
}

- (void) setTotalCountValue:(int) value
{
	self.TotalCount = [NSNumber numberWithInt:value];
}
@end

