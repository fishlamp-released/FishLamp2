//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadAccessRealmResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioLoadAccessRealmResponse.h"
#import "FLZenfolioAccessDescriptor.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioLoadAccessRealmResponse


@synthesize LoadAccessRealmResult = _LoadAccessRealmResult;

+ (NSString*) LoadAccessRealmResultKey
{
	return @"LoadAccessRealmResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioLoadAccessRealmResponse*)object).LoadAccessRealmResult = FLCopyOrRetainObject(_LoadAccessRealmResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadAccessRealmResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadAccessRealmResult) [aCoder encodeObject:_LoadAccessRealmResult forKey:@"_LoadAccessRealmResult"];
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
		_LoadAccessRealmResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadAccessRealmResult"]);
	}
	return self;
}

+ (FLZenfolioLoadAccessRealmResponse*) loadAccessRealmResponse
{
	return FLAutorelease([[FLZenfolioLoadAccessRealmResponse alloc] init]);
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
		[s_describer addProperty:@"LoadAccessRealmResult" withClass:[FLZenfolioAccessDescriptor class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadAccessRealmResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioLoadAccessRealmResponse (ValueProperties) 
@end

