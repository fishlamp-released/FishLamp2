//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreatePhotoSetResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfCreatePhotoSetResponse.h"
#import "FLZfPhotoSet.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfCreatePhotoSetResponse


@synthesize CreatePhotoSetResult = _CreatePhotoSetResult;

+ (NSString*) CreatePhotoSetResultKey
{
	return @"CreatePhotoSetResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfCreatePhotoSetResponse*)object).CreatePhotoSetResult = FLCopyOrRetainObject(_CreatePhotoSetResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

+ (FLZfCreatePhotoSetResponse*) createPhotoSetResponse
{
	return FLAutorelease([[FLZfCreatePhotoSetResponse alloc] init]);
}

- (void) dealloc
{
	FLRelease(_CreatePhotoSetResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CreatePhotoSetResult) [aCoder encodeObject:_CreatePhotoSetResult forKey:@"_CreatePhotoSetResult"];
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
		_CreatePhotoSetResult = FLRetain([aDecoder decodeObjectForKey:@"_CreatePhotoSetResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CreatePhotoSetResult" propertyClass:[FLZfPhotoSet class] propertyType:FLDataTypeObject] forPropertyName:@"CreatePhotoSetResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CreatePhotoSetResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfCreatePhotoSetResponse (ValueProperties) 
@end

