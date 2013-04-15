//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFMovePhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFMovePhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFMovePhotoSet


@synthesize destGroupId = _destGroupId;
@synthesize index = _index;
@synthesize photoSetId = _photoSetId;

+ (NSString*) destGroupIdKey
{
	return @"destGroupId";
}

+ (NSString*) indexKey
{
	return @"index";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFMovePhotoSet*)object).index = FLCopyOrRetainObject(_index);
	((ZFMovePhotoSet*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFMovePhotoSet*)object).destGroupId = FLCopyOrRetainObject(_destGroupId);
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
	FLRelease(_destGroupId);
	FLRelease(_index);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_destGroupId) [aCoder encodeObject:_destGroupId forKey:@"_destGroupId"];
	if(_index) [aCoder encodeObject:_index forKey:@"_index"];
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
		_destGroupId = FLRetain([aDecoder decodeObjectForKey:@"_destGroupId"]);
		_index = FLRetain([aDecoder decodeObjectForKey:@"_index"]);
	}
	return self;
}

+ (ZFMovePhotoSet*) movePhotoSet
{
	return FLAutorelease([[ZFMovePhotoSet alloc] init]);
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
		[s_describer setChildForIdentifier:@"destGroupId" withClass:[FLIntegerNumber class] ];
		[s_describer setChildForIdentifier:@"index" withClass:[FLIntegerNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"destGroupId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"index" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFMovePhotoSet (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}

- (int) destGroupIdValue
{
	return [self.destGroupId intValue];
}

- (void) setDestGroupIdValue:(int) value
{
	self.destGroupId = [NSNumber numberWithInt:value];
}

- (int) indexValue
{
	return [self.index intValue];
}

- (void) setIndexValue:(int) value
{
	self.index = [NSNumber numberWithInt:value];
}
@end

