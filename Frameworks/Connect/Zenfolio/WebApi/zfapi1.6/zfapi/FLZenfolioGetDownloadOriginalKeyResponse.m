//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetDownloadOriginalKeyResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioGetDownloadOriginalKeyResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioGetDownloadOriginalKeyResponse


@synthesize GetDownloadOriginalKeyResult = _GetDownloadOriginalKeyResult;

+ (NSString*) GetDownloadOriginalKeyResultKey
{
	return @"GetDownloadOriginalKeyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioGetDownloadOriginalKeyResponse*)object).GetDownloadOriginalKeyResult = FLCopyOrRetainObject(_GetDownloadOriginalKeyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetDownloadOriginalKeyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetDownloadOriginalKeyResult) [aCoder encodeObject:_GetDownloadOriginalKeyResult forKey:@"_GetDownloadOriginalKeyResult"];
}

+ (FLZenfolioGetDownloadOriginalKeyResponse*) getDownloadOriginalKeyResponse
{
	return FLAutorelease([[FLZenfolioGetDownloadOriginalKeyResponse alloc] init]);
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
		_GetDownloadOriginalKeyResult = FLRetain([aDecoder decodeObjectForKey:@"_GetDownloadOriginalKeyResult"]);
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
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer addProperty:@"GetDownloadOriginalKeyResult" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetDownloadOriginalKeyResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioGetDownloadOriginalKeyResponse (ValueProperties) 
@end

