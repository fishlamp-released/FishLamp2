//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSetGroupTitlePhoto.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioSetGroupTitlePhoto.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioSetGroupTitlePhoto


@synthesize groupId = _groupId;
@synthesize photoId = _photoId;

+ (NSString*) groupIdKey
{
	return @"groupId";
}

+ (NSString*) photoIdKey
{
	return @"photoId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioSetGroupTitlePhoto*)object).groupId = FLCopyOrRetainObject(_groupId);
	((FLZenfolioSetGroupTitlePhoto*)object).photoId = FLCopyOrRetainObject(_photoId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_groupId);
	FLRelease(_photoId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_groupId) [aCoder encodeObject:_groupId forKey:@"_groupId"];
	if(_photoId) [aCoder encodeObject:_photoId forKey:@"_photoId"];
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
		_groupId = FLRetain([aDecoder decodeObjectForKey:@"_groupId"]);
		_photoId = FLRetain([aDecoder decodeObjectForKey:@"_photoId"]);
	}
	return self;
}

+ (FLZenfolioSetGroupTitlePhoto*) setGroupTitlePhoto
{
	return FLAutorelease([[FLZenfolioSetGroupTitlePhoto alloc] init]);
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
		[s_describer addProperty:@"groupId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"photoId" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"groupId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioSetGroupTitlePhoto (ValueProperties) 

- (int) groupIdValue
{
	return [self.groupId intValue];
}

- (void) setGroupIdValue:(int) value
{
	self.groupId = [NSNumber numberWithInt:value];
}

- (int) photoIdValue
{
	return [self.photoId intValue];
}

- (void) setPhotoIdValue:(int) value
{
	self.photoId = [NSNumber numberWithInt:value];
}
@end

