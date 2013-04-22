//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVideoPlaybackUrlResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetVideoPlaybackUrlResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetVideoPlaybackUrlResponse


@synthesize GetVideoPlaybackUrlResult = _GetVideoPlaybackUrlResult;

+ (NSString*) GetVideoPlaybackUrlResultKey
{
	return @"GetVideoPlaybackUrlResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetVideoPlaybackUrlResponse*)object).GetVideoPlaybackUrlResult = FLCopyOrRetainObject(_GetVideoPlaybackUrlResult);
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

+ (ZFGetVideoPlaybackUrlResponse*) getVideoPlaybackUrlResponse
{
	return FLAutorelease([[ZFGetVideoPlaybackUrlResponse alloc] init]);
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

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"GetVideoPlaybackUrlResult" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetVideoPlaybackUrlResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetVideoPlaybackUrlResponse (ValueProperties) 
@end

