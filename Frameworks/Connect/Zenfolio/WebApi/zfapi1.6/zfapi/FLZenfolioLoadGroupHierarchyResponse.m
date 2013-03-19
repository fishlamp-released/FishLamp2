//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadGroupHierarchyResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioLoadGroupHierarchyResponse.h"
#import "FLZenfolioGroup.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioLoadGroupHierarchyResponse


@synthesize LoadGroupHierarchyResult = _LoadGroupHierarchyResult;

+ (NSString*) LoadGroupHierarchyResultKey
{
	return @"LoadGroupHierarchyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioLoadGroupHierarchyResponse*)object).LoadGroupHierarchyResult = FLCopyOrRetainObject(_LoadGroupHierarchyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadGroupHierarchyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadGroupHierarchyResult) [aCoder encodeObject:_LoadGroupHierarchyResult forKey:@"_LoadGroupHierarchyResult"];
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
		_LoadGroupHierarchyResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadGroupHierarchyResult"]);
	}
	return self;
}

+ (FLZenfolioLoadGroupHierarchyResponse*) loadGroupHierarchyResponse
{
	return FLAutorelease([[FLZenfolioLoadGroupHierarchyResponse alloc] init]);
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
		[s_describer addProperty:@"LoadGroupHierarchyResult" withClass:[FLZenfolioGroup class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadGroupHierarchyResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioLoadGroupHierarchyResponse (ValueProperties) 
@end

