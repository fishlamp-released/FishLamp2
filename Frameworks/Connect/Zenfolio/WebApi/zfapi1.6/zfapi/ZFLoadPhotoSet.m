//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadPhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadPhotoSet.h"
#import "ZFApi1_6Enums.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadPhotoSet


@synthesize includePhotos = _includePhotos;
@synthesize level = _level;
@synthesize photoSetId = _photoSetId;

+ (NSString*) includePhotosKey
{
	return @"includePhotos";
}

+ (NSString*) levelKey
{
	return @"level";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadPhotoSet*)object).level = FLCopyOrRetainObject(_level);
	((ZFLoadPhotoSet*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFLoadPhotoSet*)object).includePhotos = FLCopyOrRetainObject(_includePhotos);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_photoSetId);
	FLRelease(_level);
	FLRelease(_includePhotos);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_level) [aCoder encodeObject:_level forKey:@"_level"];
	if(_includePhotos) [aCoder encodeObject:_includePhotos forKey:@"_includePhotos"];
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
		_photoSetId = FLRetain([aDecoder decodeObjectForKey:@"_photoSetId"]);
		_level = FLRetain([aDecoder decodeObjectForKey:@"_level"]);
		_includePhotos = FLRetain([aDecoder decodeObjectForKey:@"_includePhotos"]);
	}
	return self;
}

+ (ZFLoadPhotoSet*) loadPhotoSet
{
	return FLAutorelease([[ZFLoadPhotoSet alloc] init]);
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
		[s_describer setChildForIdentifier:@"photoSetId" withClass:[FLIntegerNumber class] ];
		[s_describer setChildForIdentifier:@"level" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"includePhotos" withClass:[FLBoolNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includePhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadPhotoSet (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}

- (ZFInformatonLevel) levelValue
{
	return [[ZFApi1_6EnumLookup instance] informatonLevelFromString:self.level];
}

- (void) setLevelValue:(ZFInformatonLevel) inEnumValue
{
	self.level = [[ZFApi1_6EnumLookup instance] stringFromInformatonLevel:inEnumValue];
}

- (BOOL) includePhotosValue
{
	return [self.includePhotos boolValue];
}

- (void) setIncludePhotosValue:(BOOL) value
{
	self.includePhotos = [NSNumber numberWithBool:value];
}
@end
