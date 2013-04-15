//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetRecentSetsResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetRecentSetsResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"
#import "ZFPhotoSet.h"

@implementation ZFGetRecentSetsResponse


@synthesize GetRecentSetsResult = _GetRecentSetsResult;

+ (NSString*) GetRecentSetsResultKey
{
	return @"GetRecentSetsResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetRecentSetsResponse*)object).GetRecentSetsResult = FLCopyOrRetainObject(_GetRecentSetsResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetRecentSetsResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetRecentSetsResult) [aCoder encodeObject:_GetRecentSetsResult forKey:@"_GetRecentSetsResult"];
}

+ (ZFGetRecentSetsResponse*) getRecentSetsResponse
{
	return FLAutorelease([[ZFGetRecentSetsResponse alloc] init]);
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
		_GetRecentSetsResult = [[aDecoder decodeObjectForKey:@"_GetRecentSetsResult"] mutableCopy];
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
		[s_describer setChildForIdentifier:@"GetRecentSetsResult" withArrayTypes:[NSArray arrayWithObjects:[FLTypeDesc typeDesc:@"PhotoSet" class:[ZFPhotoSet class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetRecentSetsResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetRecentSetsResponse (ValueProperties) 
@end

