//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthenticateHttpGetIn.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthenticateHttpGetIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFAuthenticateHttpGetIn


@synthesize challenge = _challenge;
@synthesize proof = _proof;

+ (NSString*) challengeKey
{
	return @"challenge";
}

+ (NSString*) proofKey
{
	return @"proof";
}

+ (ZFAuthenticateHttpGetIn*) authenticateHttpGetIn
{
	return FLAutorelease([[ZFAuthenticateHttpGetIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthenticateHttpGetIn*)object).challenge = FLCopyOrRetainObject(_challenge);
	((ZFAuthenticateHttpGetIn*)object).proof = FLCopyOrRetainObject(_proof);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_challenge);
	FLRelease(_proof);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_challenge) [aCoder encodeObject:_challenge forKey:@"_challenge"];
	if(_proof) [aCoder encodeObject:_proof forKey:@"_proof"];
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
		_challenge = [[aDecoder decodeObjectForKey:@"_challenge"] mutableCopy];
		_proof = [[aDecoder decodeObjectForKey:@"_proof"] mutableCopy];
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"challenge" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"String" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"challenge"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"proof" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"String" propertyClass:[NSString class] propertyType:FLDataTypeString arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"proof"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"challenge" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"proof" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthenticateHttpGetIn (ValueProperties) 
@end

