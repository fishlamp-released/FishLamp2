//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioResolveResult.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioResolveResult.h"
#import "FLZenfolioGroup.h"
#import "FLZenfolioPhotoSet.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioResolveResult


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
	((FLZenfolioResolveResult*)object).Group = FLCopyOrRetainObject(_Group);
	((FLZenfolioResolveResult*)object).PhotoSet = FLCopyOrRetainObject(_PhotoSet);
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

+ (FLZenfolioResolveResult*) resolveResult
{
	return FLAutorelease([[FLZenfolioResolveResult alloc] init]);
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
		[s_describer addProperty:@"Group" withClass:[FLZenfolioGroup class]];
		[s_describer addProperty:@"PhotoSet" withClass:[FLZenfolioPhotoSet class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Group" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoSet" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioResolveResult (ValueProperties) 
@end

