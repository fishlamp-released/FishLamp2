//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFPhotoSetResult.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFPhotoSetResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFPhotoSet.h"

@implementation ZFPhotoSetResult


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
	((ZFPhotoSetResult*)object).PhotoSets = FLCopyOrRetainObject(_PhotoSets);
	((ZFPhotoSetResult*)object).TotalCount = FLCopyOrRetainObject(_TotalCount);
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

+ (ZFPhotoSetResult*) photoSetResult
{
	return FLAutorelease([[ZFPhotoSetResult alloc] init]);
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
		[s_describer setChildForIdentifier:@"PhotoSets" withArrayTypes:[NSArray arrayWithObjects:[FLTypeDesc typeDesc:@"PhotoSet" class:[ZFPhotoSet class]], nil]];
		[s_describer setChildForIdentifier:@"TotalCount" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoSets" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"TotalCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFPhotoSetResult (ValueProperties) 

- (int) TotalCountValue
{
	return [self.TotalCount intValue];
}

- (void) setTotalCountValue:(int) value
{
	self.TotalCount = [NSNumber numberWithInt:value];
}
@end

