//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVideoPlaybackUrlHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetVideoPlaybackUrlHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetVideoPlaybackUrlHttpPostIn


@synthesize height = _height;
@synthesize mode = _mode;
@synthesize photoId = _photoId;
@synthesize width = _width;

+ (NSString*) heightKey
{
	return @"height";
}

+ (NSString*) modeKey
{
	return @"mode";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) widthKey
{
	return @"width";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFGetVideoPlaybackUrlHttpPostIn*)object).height = FLCopyOrRetainObject(_height);
	((ZFGetVideoPlaybackUrlHttpPostIn*)object).width = FLCopyOrRetainObject(_width);
	((ZFGetVideoPlaybackUrlHttpPostIn*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFGetVideoPlaybackUrlHttpPostIn*)object).mode = FLCopyOrRetainObject(_mode);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoId);
	FLRelease(_mode);
	FLRelease(_width);
	FLRelease(_height);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_mode) [aCoder encodeObject:_mode forKey:@"_mode"];
	if(_width) [aCoder encodeObject:_width forKey:@"_width"];
	if(_height) [aCoder encodeObject:_height forKey:@"_height"];
}

+ (ZFGetVideoPlaybackUrlHttpPostIn*) getVideoPlaybackUrlHttpPostIn
{
	return FLAutorelease([[ZFGetVideoPlaybackUrlHttpPostIn alloc] init]);
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
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
		_mode = FLRetain([aDecoder decodeObjectForKey:@"_mode"]);
		_width = FLRetain([aDecoder decodeObjectForKey:@"_width"]);
		_height = FLRetain([aDecoder decodeObjectForKey:@"_height"]);
	}
	return self;
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"photoId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"mode" withClass:[NSString class]];
		[describer setChildForIdentifier:@"width" withClass:[NSString class]];
		[describer setChildForIdentifier:@"height" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"width" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"height" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetVideoPlaybackUrlHttpPostIn (ValueProperties) 
@end

