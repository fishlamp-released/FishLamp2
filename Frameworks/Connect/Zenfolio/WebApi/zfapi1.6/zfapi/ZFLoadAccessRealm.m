//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealm.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadAccessRealm.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadAccessRealm


@synthesize realmId = _realmId;

+ (NSString*) realmIdKey
{
	return @"realmId";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadAccessRealm*)object).realmId = FLCopyOrRetainObject(_realmId);
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

+ (ZFLoadAccessRealm*) loadAccessRealm
{
	return FLAutorelease([[ZFLoadAccessRealm alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            FLObjectDescriber* describer = [FLObjectDescriber registerClass:[self class]];
        
        
		[describer setChildForIdentifier:@"realmId" withClass:[FLIntegerNumber class] ];
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

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"realmId" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadAccessRealm (ValueProperties) 

- (int) realmIdValue
{
	return [self.realmId intValue];
}

- (void) setRealmIdValue:(int) value
{
	self.realmId = [NSNumber numberWithInt:value];
}
@end

