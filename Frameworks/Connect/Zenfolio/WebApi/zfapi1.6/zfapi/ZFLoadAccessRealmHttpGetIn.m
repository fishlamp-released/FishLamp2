//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealmHttpGetIn.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadAccessRealmHttpGetIn.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadAccessRealmHttpGetIn


@synthesize realmId = _realmId;

+ (NSString*) realmIdKey
{
	return @"realmId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadAccessRealmHttpGetIn*)object).realmId = FLCopyOrRetainObject(_realmId);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_realmId);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_realmId) [aCoder encodeObject:_realmId forKey:@"_realmId"];
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
		_realmId = FLRetain([aDecoder decodeObjectForKey:@"_realmId"]);
	}
	return self;
}

+ (ZFLoadAccessRealmHttpGetIn*) loadAccessRealmHttpGetIn
{
	return FLAutorelease([[ZFLoadAccessRealmHttpGetIn alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"realmId" withClass:[NSString class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"realmId" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadAccessRealmHttpGetIn (ValueProperties) 
@end

