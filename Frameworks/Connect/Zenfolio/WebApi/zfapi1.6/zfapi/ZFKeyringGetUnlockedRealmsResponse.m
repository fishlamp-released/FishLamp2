//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFKeyringGetUnlockedRealmsResponse.m
//	Project: FishLamp WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFKeyringGetUnlockedRealmsResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation ZFKeyringGetUnlockedRealmsResponse


@synthesize KeyringGetUnlockedRealmsResult = _KeyringGetUnlockedRealmsResult;

+ (NSString*) KeyringGetUnlockedRealmsResultKey
{
	return @"KeyringGetUnlockedRealmsResult";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFKeyringGetUnlockedRealmsResponse*)object).KeyringGetUnlockedRealmsResult = FLCopyOrRetainObject(_KeyringGetUnlockedRealmsResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_KeyringGetUnlockedRealmsResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_KeyringGetUnlockedRealmsResult) [aCoder encodeObject:_KeyringGetUnlockedRealmsResult forKey:@"_KeyringGetUnlockedRealmsResult"];
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
		_KeyringGetUnlockedRealmsResult = [[aDecoder decodeObjectForKey:@"_KeyringGetUnlockedRealmsResult"] mutableCopy];
	}
	return self;
}

+ (ZFKeyringGetUnlockedRealmsResponse*) keyringGetUnlockedRealmsResponse
{
	return FLAutorelease([[ZFKeyringGetUnlockedRealmsResponse alloc] init]);
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
		[s_describer setChildForIdentifier:@"KeyringGetUnlockedRealmsResult" withArrayTypes:[NSArray arrayWithObjects:[FLTypeDesc typeDesc:@"int" class:[FLIntegerNumber class]], nil]];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"KeyringGetUnlockedRealmsResult" columnType:FLDatabaseTypeObject columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFKeyringGetUnlockedRealmsResponse (ValueProperties) 
@end

