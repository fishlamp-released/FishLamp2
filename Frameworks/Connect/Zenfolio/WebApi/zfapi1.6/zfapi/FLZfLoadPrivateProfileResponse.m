//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadPrivateProfileResponse.m
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfLoadPrivateProfileResponse.h"
#import "FLZfUser.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfLoadPrivateProfileResponse


@synthesize LoadPrivateProfileResult = _LoadPrivateProfileResult;

+ (NSString*) LoadPrivateProfileResultKey
{
	return @"LoadPrivateProfileResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfLoadPrivateProfileResponse*)object).LoadPrivateProfileResult = FLCopyOrRetainObject(_LoadPrivateProfileResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadPrivateProfileResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadPrivateProfileResult) [aCoder encodeObject:_LoadPrivateProfileResult forKey:@"_LoadPrivateProfileResult"];
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
		_LoadPrivateProfileResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadPrivateProfileResult"]);
	}
	return self;
}

+ (FLZfLoadPrivateProfileResponse*) loadPrivateProfileResponse
{
	return FLAutorelease([[FLZfLoadPrivateProfileResponse alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"LoadPrivateProfileResult" propertyClass:[FLZfUser class] propertyType:FLDataTypeObject] forPropertyName:@"LoadPrivateProfileResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadPrivateProfileResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfLoadPrivateProfileResponse (ValueProperties) 
@end

