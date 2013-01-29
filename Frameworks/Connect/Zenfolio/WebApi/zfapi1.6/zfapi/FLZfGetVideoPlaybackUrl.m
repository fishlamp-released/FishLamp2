//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetVideoPlaybackUrl.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfGetVideoPlaybackUrl.h"
#import "FLZfApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfGetVideoPlaybackUrl


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
	((FLZfGetVideoPlaybackUrl*)object).height = FLCopyOrRetainObject(_height);
	((FLZfGetVideoPlaybackUrl*)object).width = FLCopyOrRetainObject(_width);
	((FLZfGetVideoPlaybackUrl*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZfGetVideoPlaybackUrl*)object).mode = FLCopyOrRetainObject(_mode);
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

+ (FLZfGetVideoPlaybackUrl*) getVideoPlaybackUrl
{
	return FLAutorelease([[FLZfGetVideoPlaybackUrl alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoId" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"photoId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"mode" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"mode"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"width" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"width"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"height" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"height"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"width" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"height" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfGetVideoPlaybackUrl (ValueProperties) 

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}

- (FLZfVideoPlaybackMode) modeValue
{
	return [[FLZfApi1_6EnumLookup instance] videoPlaybackModeFromString:self.mode];
}

- (void) setModeValue:(FLZfVideoPlaybackMode) inEnumValue
{
	self.mode = [[FLZfApi1_6EnumLookup instance] stringFromVideoPlaybackMode:inEnumValue];
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

