//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAuthenticatePlainHttpPostIn.m
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZfAuthenticatePlainHttpPostIn.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZfAuthenticatePlainHttpPostIn


@synthesize loginName = _loginName;
@synthesize password = _password;

+ (NSString*) loginNameKey
{
	return @"loginName";
}

+ (NSString*) passwordKey
{
	return @"password";
}

+ (FLZfAuthenticatePlainHttpPostIn*) authenticatePlainHttpPostIn
{
	return FLAutorelease([[FLZfAuthenticatePlainHttpPostIn alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZfAuthenticatePlainHttpPostIn*)object).loginName = FLCopyOrRetainObject(_loginName);
	((FLZfAuthenticatePlainHttpPostIn*)object).password = FLCopyOrRetainObject(_password);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_loginName);
	FLRelease(_password);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_loginName) [aCoder encodeObject:_loginName forKey:@"_loginName"];
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
		_loginName = FLRetain([aDecoder decodeObjectForKey:@"_loginName"]);
		_password = FLRetain([aDecoder decodeObjectForKey:@"_password"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"loginName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"loginName"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"loginName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"password" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZfAuthenticatePlainHttpPostIn (ValueProperties) 
@end

