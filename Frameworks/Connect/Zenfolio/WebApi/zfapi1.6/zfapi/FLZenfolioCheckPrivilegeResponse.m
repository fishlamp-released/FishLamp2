//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCheckPrivilegeResponse.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioCheckPrivilegeResponse.h"
#import "FLObjectDescriber.h"

#import "FLDatabaseTable.h"

@implementation FLZenfolioCheckPrivilegeResponse


@synthesize CheckPrivilegeResult = _CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey
{
	return @"CheckPrivilegeResult";
}

+ (FLZenfolioCheckPrivilegeResponse*) checkPrivilegeResponse
{
	return FLAutorelease([[FLZenfolioCheckPrivilegeResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioCheckPrivilegeResponse*)object).CheckPrivilegeResult = FLCopyOrRetainObject(_CheckPrivilegeResult);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_CheckPrivilegeResult);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_CheckPrivilegeResult) [aCoder encodeObject:_CheckPrivilegeResult forKey:@"_CheckPrivilegeResult"];
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
		_CheckPrivilegeResult = FLRetain([aDecoder decodeObjectForKey:@"_CheckPrivilegeResult"]);
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
		[s_describer addProperty:@"CheckPrivilegeResult" withClass:[FLBoolNumber class] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CheckPrivilegeResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioCheckPrivilegeResponse (ValueProperties) 

- (BOOL) CheckPrivilegeResultValue
{
	return [self.CheckPrivilegeResult boolValue];
}

- (void) setCheckPrivilegeResultValue:(BOOL) value
{
	self.CheckPrivilegeResult = [NSNumber numberWithBool:value];
}
@end

