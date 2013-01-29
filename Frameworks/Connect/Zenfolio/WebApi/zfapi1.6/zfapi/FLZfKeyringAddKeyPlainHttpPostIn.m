//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfKeyringAddKeyPlainHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfKeyringAddKeyPlainHttpPostIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfKeyringAddKeyPlainHttpPostIn


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
	((FLZfKeyringAddKeyPlainHttpPostIn*)object).keyring = FLCopyOrRetainObject(_keyring);
	((FLZfKeyringAddKeyPlainHttpPostIn*)object).realmId = FLCopyOrRetainObject(_realmId);
	((FLZfKeyringAddKeyPlainHttpPostIn*)object).password = FLCopyOrRetainObject(_password);
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

+ (FLZfKeyringAddKeyPlainHttpPostIn*) keyringAddKeyPlainHttpPostIn
{
	return FLAutorelease([[FLZfKeyringAddKeyPlainHttpPostIn alloc] init]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"keyring" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"keyring"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"realmId" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"realmId"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"password" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"password"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"keyring" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"realmId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfKeyringAddKeyPlainHttpPostIn (ValueProperties) 
@end

