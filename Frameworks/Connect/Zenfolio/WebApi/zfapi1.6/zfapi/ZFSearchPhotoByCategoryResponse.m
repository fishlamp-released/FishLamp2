//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFSearchPhotoByCategoryResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFSearchPhotoByCategoryResponse.h"
#import "ZFPhotoResult.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFSearchPhotoByCategoryResponse


@synthesize SearchPhotoByCategoryResult = _SearchPhotoByCategoryResult;

+ (NSString*) SearchPhotoByCategoryResultKey
{
	return @"SearchPhotoByCategoryResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFSearchPhotoByCategoryResponse*)object).SearchPhotoByCategoryResult = FLCopyOrRetainObject(_SearchPhotoByCategoryResult);
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

+ (ZFSearchPhotoByCategoryResponse*) searchPhotoByCategoryResponse
{
	return FLAutorelease([[ZFSearchPhotoByCategoryResponse alloc] init]);
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
		[s_describer setChildForIdentifier:@"SearchPhotoByCategoryResult" withClass:[ZFPhotoResult class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"SearchPhotoByCategoryResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFSearchPhotoByCategoryResponse (ValueProperties) 
@end

