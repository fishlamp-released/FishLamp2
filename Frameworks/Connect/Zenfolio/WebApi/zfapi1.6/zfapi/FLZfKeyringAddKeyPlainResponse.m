//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringAddKeyPlainResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfKeyringAddKeyPlainResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfKeyringAddKeyPlainResponse


@synthesize KeyringAddKeyPlainResult = _KeyringAddKeyPlainResult;

+ (NSString*) KeyringAddKeyPlainResultKey
{
	return @"KeyringAddKeyPlainResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfKeyringAddKeyPlainResponse*)object).KeyringAddKeyPlainResult = FLCopyOrRetainObject(_KeyringAddKeyPlainResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_KeyringAddKeyPlainResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_KeyringAddKeyPlainResult) [aCoder encodeObject:_KeyringAddKeyPlainResult forKey:@"_KeyringAddKeyPlainResult"];
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
		_KeyringAddKeyPlainResult = FLRetain([aDecoder decodeObjectForKey:@"_KeyringAddKeyPlainResult"]);
	}
	return self;
}

+ (FLZfKeyringAddKeyPlainResponse*) keyringAddKeyPlainResponse
{
	return FLAutorelease([[FLZfKeyringAddKeyPlainResponse alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"KeyringAddKeyPlainResult" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"KeyringAddKeyPlainResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"KeyringAddKeyPlainResult" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfKeyringAddKeyPlainResponse (ValueProperties) 
@end

