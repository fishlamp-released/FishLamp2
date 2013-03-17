//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUpdatePhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioUpdatePhoto.h"
#import "FLZenfolioPhotoUpdater.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioUpdatePhoto


@synthesize photoId = _photoId;
@synthesize updater = _updater;

+ (NSString*) photoIdKey
{
	return @"photoId";
}

+ (NSString*) updaterKey
{
	return @"updater";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioUpdatePhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
	((FLZenfolioUpdatePhoto*)object).updater = FLCopyOrRetainObject(_updater);
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
	FLRelease(_updater);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
	if(_updater) [aCoder encodeObject:_updater forKey:@"_updater"];
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
		_updater = FLRetain([aDecoder decodeObjectForKey:@"_updater"]);
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
			s_describer = [[FLObjectDescriber alloc] init];
		}
		[s_describer addProperty:@"photoId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"updater" withClass:[FLZenfolioPhotoUpdater class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"updater" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZenfolioUpdatePhoto*) updatePhoto
{
	return FLAutorelease([[FLZenfolioUpdatePhoto alloc] init]);
}

@end

@implementation FLZenfolioUpdatePhoto (ValueProperties) 

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}
@end

