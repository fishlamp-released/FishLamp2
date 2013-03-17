//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadPhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioLoadPhotoSet.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioLoadPhotoSet


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
	((FLZenfolioLoadPhotoSet*)object).level = FLCopyOrRetainObject(_level);
	((FLZenfolioLoadPhotoSet*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZenfolioLoadPhotoSet*)object).includePhotos = FLCopyOrRetainObject(_includePhotos);
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

+ (FLZenfolioLoadPhotoSet*) loadPhotoSet
{
	return FLAutorelease([[FLZenfolioLoadPhotoSet alloc] init]);
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
		[s_describer addProperty:@"photoSetId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"level" withClass:[NSString class]];
		[s_describer addProperty:@"includePhotos" withClass:[FLBoolNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"level" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"includePhotos" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioLoadPhotoSet (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}

- (FLZenfolioInformatonLevel) levelValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] informatonLevelFromString:self.level];
}

- (void) setLevelValue:(FLZenfolioInformatonLevel) inEnumValue
{
	self.level = [[FLZenfolioApi1_6EnumLookup instance] stringFromInformatonLevel:inEnumValue];
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

