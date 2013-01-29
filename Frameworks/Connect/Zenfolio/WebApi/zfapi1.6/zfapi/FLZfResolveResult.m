//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfResolveResult.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfResolveResult.h"
#import "FLZfGroup.h"
#import "FLZfPhotoSet.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfResolveResult


@synthesize Group = _Group;
@synthesize PhotoSet = _PhotoSet;

+ (NSString*) GroupKey
{
	return @"Group";
}

+ (NSString*) PhotoSetKey
{
	return @"PhotoSet";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfResolveResult*)object).Group = FLCopyOrRetainObject(_Group);
	((FLZfResolveResult*)object).PhotoSet = FLCopyOrRetainObject(_PhotoSet);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_Group);
	FLRelease(_PhotoSet);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_Group) [aCoder encodeObject:_Group forKey:@"_Group"];
	if(_PhotoSet) [aCoder encodeObject:_PhotoSet forKey:@"_PhotoSet"];
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
		_Group = FLRetain([aDecoder decodeObjectForKey:@"_Group"]);
		_PhotoSet = FLRetain([aDecoder decodeObjectForKey:@"_PhotoSet"]);
	}
	return self;
}

+ (FLZfResolveResult*) resolveResult
{
	return FLAutorelease([[FLZfResolveResult alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Group" propertyClass:[FLZfGroup class] propertyType:FLDataTypeObject] forPropertyName:@"Group"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PhotoSet" propertyClass:[FLZfPhotoSet class] propertyType:FLDataTypeObject] forPropertyName:@"PhotoSet"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Group" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoSet" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfResolveResult (ValueProperties) 
@end

