//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioRotatePhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioRotatePhoto.h"
#import "FLZenfolioApi1_6Enums.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioRotatePhoto


@synthesize photoId = _photoId;
@synthesize rotation = _rotation;

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) rotationKey
{
	return @"rotation";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioRotatePhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZenfolioRotatePhoto*)object).rotation = FLCopyOrRetainObject(_rotation);
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
	FLRelease(_rotation);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_rotation) [aCoder encodeObject:_rotation forKey:@"_rotation"];
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
		_rotation = FLRetain([aDecoder decodeObjectForKey:@"_rotation"]);
	}
	return self;
}

+ (FLZenfolioRotatePhoto*) rotatePhoto
{
	return FLAutorelease([[FLZenfolioRotatePhoto alloc] init]);
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
		[s_describer addProperty:@"photoId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"rotation" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"rotation" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioRotatePhoto (ValueProperties) 

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}

- (FLZenfolioPhotoRotation) rotationValue
{
	return [[FLZenfolioApi1_6EnumLookup instance] photoRotationFromString:self.rotation];
}

- (void) setRotationValue:(FLZenfolioPhotoRotation) inEnumValue
{
	self.rotation = [[FLZenfolioApi1_6EnumLookup instance] stringFromPhotoRotation:inEnumValue];
}
@end

