//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioReindexPhotoSetHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioReindexPhotoSetHttpGetIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioReindexPhotoSetHttpGetIn


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
	((FLZenfolioReindexPhotoSetHttpGetIn*)object).startIndex = FLCopyOrRetainObject(_startIndex);
	((FLZenfolioReindexPhotoSetHttpGetIn*)object).photoSetId = FLCopyOrRetainObject(_photoSetId);
	((FLZenfolioReindexPhotoSetHttpGetIn*)object).mapping = FLCopyOrRetainObject(_mapping);
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

+ (FLZenfolioReindexPhotoSetHttpGetIn*) reindexPhotoSetHttpGetIn
{
	return FLAutorelease([[FLZenfolioReindexPhotoSetHttpGetIn alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"photoSetId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"photoSetId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"startIndex" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"startIndex"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"mapping" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"String" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"mapping"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"photoSetId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"startIndex" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"mapping" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioReindexPhotoSetHttpGetIn (ValueProperties) 
@end

