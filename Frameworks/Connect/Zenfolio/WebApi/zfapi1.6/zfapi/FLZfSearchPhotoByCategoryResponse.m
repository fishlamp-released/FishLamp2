//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfSearchPhotoByCategoryResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfSearchPhotoByCategoryResponse.h"
#import "FLZfPhotoResult.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfSearchPhotoByCategoryResponse


@synthesize SearchPhotoByCategoryResult = _SearchPhotoByCategoryResult;

+ (NSString*) SearchPhotoByCategoryResultKey
{
	return @"SearchPhotoByCategoryResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfSearchPhotoByCategoryResponse*)object).SearchPhotoByCategoryResult = FLCopyOrRetainObject(_SearchPhotoByCategoryResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_SearchPhotoByCategoryResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_SearchPhotoByCategoryResult) [aCoder encodeObject:_SearchPhotoByCategoryResult forKey:@"_SearchPhotoByCategoryResult"];
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
		_SearchPhotoByCategoryResult = FLRetain([aDecoder decodeObjectForKey:@"_SearchPhotoByCategoryResult"]);
	}
	return self;
}

+ (FLZfSearchPhotoByCategoryResponse*) searchPhotoByCategoryResponse
{
	return FLAutorelease([[FLZfSearchPhotoByCategoryResponse alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"SearchPhotoByCategoryResult" propertyClass:[FLZfPhotoResult class] propertyType:FLDataTypeObject] forPropertyName:@"SearchPhotoByCategoryResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SearchPhotoByCategoryResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfSearchPhotoByCategoryResponse (ValueProperties) 
@end

