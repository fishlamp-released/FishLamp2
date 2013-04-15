//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFAuthChallenge.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFAuthChallenge.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFAuthChallenge


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

+ (ZFAuthChallenge*) authChallenge
{
	return FLAutorelease([[ZFAuthChallenge alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFAuthChallenge*)object).PasswordSalt = FLCopyOrRetainObject(_PasswordSalt);
	((ZFAuthChallenge*)object).Challenge = FLCopyOrRetainObject(_Challenge);
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

+ (FLObjectDescriber*) objectDescriber
{
	static FLObjectDescriber* s_describer = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		if(!s_describer)
		{
			s_describer = [[FLObjectDescriber alloc] initWithClass:[self class]];
		}
		[s_describer setChildForIdentifier:@"PasswordSalt" withClass:[NSData class]];
		[s_describer setChildForIdentifier:@"Challenge" withClass:[NSData class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PasswordSalt" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Challenge" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFAuthChallenge (ValueProperties) 
@end

