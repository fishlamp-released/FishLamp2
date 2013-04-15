//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringAddKeyPlain.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFKeyringAddKeyPlain.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFKeyringAddKeyPlain


@synthesize keyring = _keyring;
@synthesize password = _password;
@synthesize realmId = _realmId;

+ (NSString*) keyringKey
{
	return @"keyring";
}

+ (NSString*) passwordKey
{
	return @"password";
}

+ (NSString*) realmIdKey
{
	return @"realmId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFKeyringAddKeyPlain*)object).keyring = FLCopyOrRetainObject(_keyring);
	((ZFKeyringAddKeyPlain*)object).realmId = FLCopyOrRetainObject(_realmId);
	((ZFKeyringAddKeyPlain*)object).password = FLCopyOrRetainObject(_password);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_keyring);
	FLRelease(_realmId);
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_keyring) [aCoder encodeObject:_keyring forKey:@"_keyring"];
	if(_realmId) [aCoder encodeObject:_realmId forKey:@"_realmId"];
	if(_password) [aCoder encodeObject:_password forKey:@"_password"];
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
		_keyring = FLRetain([aDecoder decodeObjectForKey:@"_keyring"]);
		_realmId = FLRetain([aDecoder decodeObjectForKey:@"_realmId"]);
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
	}
	return self;
}

+ (ZFKeyringAddKeyPlain*) keyringAddKeyPlain
{
	return FLAutorelease([[ZFKeyringAddKeyPlain alloc] init]);
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
		[s_describer setChildForIdentifier:@"keyring" withClass:[NSString class]];
		[s_describer setChildForIdentifier:@"realmId" withClass:[FLIntegerNumber class] ];
		[s_describer setChildForIdentifier:@"password" withClass:[NSString class]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"keyring" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"realmId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFKeyringAddKeyPlain (ValueProperties) 

- (int) realmIdValue
{
	return [self.realmId intValue];
}

- (void) setRealmIdValue:(int) value
{
	self.realmId = [NSNumber numberWithInt:value];
}
@end

