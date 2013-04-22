//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadAccessRealmResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFLoadAccessRealmResponse.h"
#import "ZFAccessDescriptor.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFLoadAccessRealmResponse


@synthesize LoadAccessRealmResult = _LoadAccessRealmResult;

+ (NSString*) LoadAccessRealmResultKey
{
	return @"LoadAccessRealmResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFLoadAccessRealmResponse*)object).LoadAccessRealmResult = FLCopyOrRetainObject(_LoadAccessRealmResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoadAccessRealmResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoadAccessRealmResult) [aCoder encodeObject:_LoadAccessRealmResult forKey:@"_LoadAccessRealmResult"];
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
		_LoadAccessRealmResult = FLRetain([aDecoder decodeObjectForKey:@"_LoadAccessRealmResult"]);
	}
	return self;
}

+ (ZFLoadAccessRealmResponse*) loadAccessRealmResponse
{
	return FLAutorelease([[ZFLoadAccessRealmResponse alloc] init]);
}

+ (FLObjectDescriber*) objectDescriber
{
	
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
		
		
            [FLObjectDescriber registerClass:[self class]];
        FLObjectDescriber* describer = [FLObjectDescriber objectDescriber:[self class]];
        
		[describer setChildForIdentifier:@"LoadAccessRealmResult" withClass:[ZFAccessDescriptor class]];
	});
	return [FLObjectDescriber objectDescriber:[self class]];
}


+ (FLDatabaseTable*) sharedDatabaseTable
{
	static FLDatabaseTable* s_table = nil;
	static dispatch_once_t pred = 0;
	dispatch_once(&pred, ^{
        s_table = [[FLDatabaseTable alloc] initWithClass:[self class]]; 

		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoadAccessRealmResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFLoadAccessRealmResponse (ValueProperties) 
@end

