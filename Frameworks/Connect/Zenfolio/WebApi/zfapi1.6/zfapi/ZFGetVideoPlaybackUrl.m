//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFGetVideoPlaybackUrl.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFGetVideoPlaybackUrl.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFGetVideoPlaybackUrl


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
	((ZFGetVideoPlaybackUrl*)object).height = FLCopyOrRetainObject(_height);
	((ZFGetVideoPlaybackUrl*)object).width = FLCopyOrRetainObject(_width);
	((ZFGetVideoPlaybackUrl*)object).photoId = FLCopyOrRetainObject(_photoId);
	((ZFGetVideoPlaybackUrl*)object).mode = FLCopyOrRetainObject(_mode);
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

+ (ZFGetVideoPlaybackUrl*) getVideoPlaybackUrl
{
	return FLAutorelease([[ZFGetVideoPlaybackUrl alloc] init]);
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
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer setChildForIdentifier:@"photoId" withClass:[FLIntegerNumber class] ];
		[s_describer setChildForIdentifier:@"mode" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"width" withClass:[FLIntegerNumber class] ];
		[s_describer setChildForIdentifier:@"height" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"width" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"height" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFGetVideoPlaybackUrl (ValueProperties) 

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}

- (ZFVideoPlaybackMode) modeValue
{
	return [[ZFApi1_6EnumLookup instance] videoPlaybackModeFromString:self.mode];
}

- (void) setModeValue:(ZFVideoPlaybackMode) inEnumValue
{
	self.mode = [[ZFApi1_6EnumLookup instance] stringFromVideoPlaybackMode:inEnumValue];
}

- (int) widthValue
{
	return [self.width intValue];
}

- (void) setWidthValue:(int) value
{
	self.width = [NSNumber numberWithInt:value];
}

- (int) heightValue
{
	return [self.height intValue];
}

- (void) setHeightValue:(int) value
{
	self.height = [NSNumber numberWithInt:value];
}
@end

