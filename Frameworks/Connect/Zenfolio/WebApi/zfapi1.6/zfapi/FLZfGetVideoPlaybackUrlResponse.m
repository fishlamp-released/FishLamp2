//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetVideoPlaybackUrlResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfGetVideoPlaybackUrlResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfGetVideoPlaybackUrlResponse


@synthesize GetVideoPlaybackUrlResult = _GetVideoPlaybackUrlResult;

+ (NSString*) GetVideoPlaybackUrlResultKey
{
	return @"GetVideoPlaybackUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfGetVideoPlaybackUrlResponse*)object).GetVideoPlaybackUrlResult = FLCopyOrRetainObject(_GetVideoPlaybackUrlResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetVideoPlaybackUrlResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetVideoPlaybackUrlResult) [aCoder encodeObject:_GetVideoPlaybackUrlResult forKey:@"_GetVideoPlaybackUrlResult"];
}

+ (FLZfGetVideoPlaybackUrlResponse*) getVideoPlaybackUrlResponse
{
	return FLAutorelease([[FLZfGetVideoPlaybackUrlResponse alloc] init]);
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
		_GetVideoPlaybackUrlResult = FLRetain([aDecoder decodeObjectForKey:@"_GetVideoPlaybackUrlResult"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"GetVideoPlaybackUrlResult" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"GetVideoPlaybackUrlResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetVideoPlaybackUrlResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfGetVideoPlaybackUrlResponse (ValueProperties) 
@end

