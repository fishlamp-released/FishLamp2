//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFReindexPhotoSet.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFReindexPhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFReindexPhotoSet


@synthesize mapping = _mapping;
@synthesize photoSetId = _photoSetId;
@synthesize startIndex = _startIndex;

+ (NSString*) mappingKey
{
	return @"mapping";
}

+ (NSString*) photoSetIdKey
{
	return @"photoSetId";
}

+ (NSString*) startIndexKey
{
	return @"startIndex";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFReindexPhotoSet*)object).startIndex = FLCopyOrRetainObject(_startIndex);
	((ZFReindexPhotoSet*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((ZFReindexPhotoSet*)object).mapping = FLCopyOrRetainObject(_mapping);
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
	FLRelease(_startIndex);
	FLRelease(_mapping);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_photoSetId) [aCoder encodeObject:_photoSetId forKey:@"_photoSetId"];
	if(_startIndex) [aCoder encodeObject:_startIndex forKey:@"_startIndex"];
	if(_mapping) [aCoder encodeObject:_mapping forKey:@"_mapping"];
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
		_startIndex = FLRetain([aDecoder decodeObjectForKey:@"_startIndex"]);
		_mapping = [[aDecoder decodeObjectForKey:@"_mapping"] mutableCopy];
	}
	return self;
}

+ (ZFReindexPhotoSet*) reindexPhotoSet
{
	return FLAutorelease([[ZFReindexPhotoSet alloc] init]);
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
		[s_describer addProperty:@"photoSetId" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"startIndex" withClass:[FLIntegerNumber class] ];
		[s_describer addProperty:@"mapping" withArrayTypes:[NSArray arrayWithObjects:[FLObjectDescriber objectDescriber:@"int" objectClass:[FLIntegerNumber class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startIndex" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mapping" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFReindexPhotoSet (ValueProperties) 

- (int) photoSetIdValue
{
	return [self.photoSetId intValue];
}

- (void) setPhotoSetIdValue:(int) value
{
	self.photoSetId = [NSNumber numberWithInt:value];
}

- (int) startIndexValue
{
	return [self.startIndex intValue];
}

- (void) setStartIndexValue:(int) value
{
	self.startIndex = [NSNumber numberWithInt:value];
}
@end

