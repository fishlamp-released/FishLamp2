//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	ZFCheckPrivilegeResponse.m
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "ZFCheckPrivilegeResponse.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation ZFCheckPrivilegeResponse


@synthesize CheckPrivilegeResult = _CheckPrivilegeResult;

+ (NSString*) CheckPrivilegeResultKey
{
	return @"CheckPrivilegeResult";
}

+ (ZFCheckPrivilegeResponse*) checkPrivilegeResponse
{
	return FLAutorelease([[ZFCheckPrivilegeResponse alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((ZFCheckPrivilegeResponse*)object).CheckPrivilegeResult = FLCopyOrRetainObject(_CheckPrivilegeResult);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CheckPrivilegeResult" propertyClass:[NSNumber class] propertyType:FLDataTypeBool] forPropertyName:@"CheckPrivilegeResult"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CheckPrivilegeResult" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation ZFCheckPrivilegeResponse (ValueProperties) 

- (BOOL) CheckPrivilegeResultValue
{
	return [self.CheckPrivilegeResult boolValue];
}

- (void) setCheckPrivilegeResultValue:(BOOL) value
{
	self.CheckPrivilegeResult = [NSNumber numberWithBool:value];
}
@end

