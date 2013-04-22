//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringGetUnlockedRealms.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFKeyringGetUnlockedRealms.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFKeyringGetUnlockedRealms


@synthesize keyring = _keyring;

+ (NSString*) keyringKey
{
	return @"keyring";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFKeyringGetUnlockedRealms*)object).keyring = FLCopyOrRetainObject(_keyring);
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
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_keyring) [aCoder encodeObject:_keyring forKey:@"_keyring"];
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
	}
	return self;
}

+ (ZFKeyringGetUnlockedRealms*) keyringGetUnlockedRealms
{
	return FLAutorelease([[ZFKeyringGetUnlockedRealms alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"keyring" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"keyring" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFKeyringGetUnlockedRealms (ValueProperties) 
@end

