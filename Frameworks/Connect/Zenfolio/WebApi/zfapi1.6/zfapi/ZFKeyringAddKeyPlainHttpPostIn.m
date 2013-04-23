//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringAddKeyPlainHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFKeyringAddKeyPlainHttpPostIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFKeyringAddKeyPlainHttpPostIn


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
	((ZFKeyringAddKeyPlainHttpPostIn*)object).keyring = FLCopyOrRetainObject(_keyring);
	((ZFKeyringAddKeyPlainHttpPostIn*)object).realmId = FLCopyOrRetainObject(_realmId);
	((ZFKeyringAddKeyPlainHttpPostIn*)object).password = FLCopyOrRetainObject(_password);
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

+ (ZFKeyringAddKeyPlainHttpPostIn*) keyringAddKeyPlainHttpPostIn
{
	return FLAutorelease([[ZFKeyringAddKeyPlainHttpPostIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"keyring" withClass:[NSString class]];
		[describer setChildForIdentifier:@"realmId" withClass:[NSString class]];
		[describer setChildForIdentifier:@"password" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


- (BOOL) isModelObject {
    return YES;
}
+ (BOOL) isModelObject {
    return YES;
}
+ (FLDatabaseTable*) sharedDatabaseTable

{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"keyring" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"realmId" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFKeyringAddKeyPlainHttpPostIn (ValueProperties) 
@end

