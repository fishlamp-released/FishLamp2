//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfGetVisitorKeyResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfGetVisitorKeyResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfGetVisitorKeyResponse


@synthesize GetVisitorKeyResult = _GetVisitorKeyResult;

+ (NSString*) GetVisitorKeyResultKey
{
	return @"GetVisitorKeyResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfGetVisitorKeyResponse*)object).GetVisitorKeyResult = FLCopyOrRetainObject(_GetVisitorKeyResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_GetVisitorKeyResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_GetVisitorKeyResult) [aCoder encodeObject:_GetVisitorKeyResult forKey:@"_GetVisitorKeyResult"];
}

+ (FLZfGetVisitorKeyResponse*) getVisitorKeyResponse
{
	return FLAutorelease([[FLZfGetVisitorKeyResponse alloc] init]);
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
		_GetVisitorKeyResult = FLRetain([aDecoder decodeObjectForKey:@"_GetVisitorKeyResult"]);
	}
	return self;
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"GetVisitorKeyResult" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"GetVisitorKeyResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GetVisitorKeyResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfGetVisitorKeyResponse (ValueProperties) 
@end

