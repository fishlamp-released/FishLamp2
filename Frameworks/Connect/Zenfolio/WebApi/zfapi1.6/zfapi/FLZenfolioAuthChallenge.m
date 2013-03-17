//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAuthChallenge.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioAuthChallenge.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioAuthChallenge


@synthesize Challenge = _Challenge;
@synthesize PasswordSalt = _PasswordSalt;

+ (NSString*) ChallengeKey
{
	return @"Challenge";
}

+ (NSString*) PasswordSaltKey
{
	return @"PasswordSalt";
}

+ (FLZenfolioAuthChallenge*) authChallenge
{
	return FLAutorelease([[FLZenfolioAuthChallenge alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioAuthChallenge*)object).PasswordSalt = FLCopyOrRetainObject(_PasswordSalt);
	((FLZenfolioAuthChallenge*)object).Challenge = FLCopyOrRetainObject(_Challenge);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_PasswordSalt);
	FLRelease(_Challenge);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_PasswordSalt) [aCoder encodeObject:_PasswordSalt forKey:@"_PasswordSalt"];
	if(_Challenge) [aCoder encodeObject:_Challenge forKey:@"_Challenge"];
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
		_PasswordSalt = FLRetain([aDecoder decodeObjectForKey:@"_PasswordSalt"]);
		_Challenge = FLRetain([aDecoder decodeObjectForKey:@"_Challenge"]);
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
		[s_describer addProperty:@"PasswordSalt" withClass:[NSData class]];
		[s_describer addProperty:@"Challenge" withClass:[NSData class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PasswordSalt" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Challenge" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioAuthChallenge (ValueProperties) 
@end

