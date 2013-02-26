//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioAddress.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioAddress.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"

@implementation FLZenfolioAddress


@synthesize City = _City;
@synthesize CompanyName = _CompanyName;
@synthesize Country = _Country;
@synthesize Email = _Email;
@synthesize Fax = _Fax;
@synthesize FirstName = _FirstName;
@synthesize LastName = _LastName;
@synthesize Other = _Other;
@synthesize Phone = _Phone;
@synthesize Phone2 = _Phone2;
@synthesize State = _State;
@synthesize Street = _Street;
@synthesize Street2 = _Street2;
@synthesize Url = _Url;
@synthesize Zip = _Zip;

+ (NSString*) CityKey
{
	return @"City";
}

+ (NSString*) CompanyNameKey
{
	return @"CompanyName";
}

+ (NSString*) CountryKey
{
	return @"Country";
}

+ (NSString*) EmailKey
{
	return @"Email";
}

+ (NSString*) FaxKey
{
	return @"Fax";
}

+ (NSString*) FirstNameKey
{
	return @"FirstName";
}

+ (NSString*) LastNameKey
{
	return @"LastName";
}

+ (NSString*) OtherKey
{
	return @"Other";
}

+ (NSString*) Phone2Key
{
	return @"Phone2";
}

+ (NSString*) PhoneKey
{
	return @"Phone";
}

+ (NSString*) StateKey
{
	return @"State";
}

+ (NSString*) Street2Key
{
	return @"Street2";
}

+ (NSString*) StreetKey
{
	return @"Street";
}

+ (NSString*) UrlKey
{
	return @"Url";
}

+ (NSString*) ZipKey
{
	return @"Zip";
}

+ (FLZenfolioAddress*) address
{
	return FLAutorelease([[FLZenfolioAddress alloc] init]);
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioAddress*)object).City = FLCopyOrRetainObject(_City);
	((FLZenfolioAddress*)object).Url = FLCopyOrRetainObject(_Url);
	((FLZenfolioAddress*)object).Email = FLCopyOrRetainObject(_Email);
	((FLZenfolioAddress*)object).Street = FLCopyOrRetainObject(_Street);
	((FLZenfolioAddress*)object).Fax = FLCopyOrRetainObject(_Fax);
	((FLZenfolioAddress*)object).State = FLCopyOrRetainObject(_State);
	((FLZenfolioAddress*)object).Other = FLCopyOrRetainObject(_Other);
	((FLZenfolioAddress*)object).Street2 = FLCopyOrRetainObject(_Street2);
	((FLZenfolioAddress*)object).Phone = FLCopyOrRetainObject(_Phone);
	((FLZenfolioAddress*)object).FirstName = FLCopyOrRetainObject(_FirstName);
	((FLZenfolioAddress*)object).Phone2 = FLCopyOrRetainObject(_Phone2);
	((FLZenfolioAddress*)object).CompanyName = FLCopyOrRetainObject(_CompanyName);
	((FLZenfolioAddress*)object).Zip = FLCopyOrRetainObject(_Zip);
	((FLZenfolioAddress*)object).LastName = FLCopyOrRetainObject(_LastName);
	((FLZenfolioAddress*)object).Country = FLCopyOrRetainObject(_Country);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_FirstName);
	FLRelease(_LastName);
	FLRelease(_CompanyName);
	FLRelease(_Street);
	FLRelease(_Street2);
	FLRelease(_City);
	FLRelease(_Zip);
	FLRelease(_State);
	FLRelease(_Country);
	FLRelease(_Phone);
	FLRelease(_Phone2);
	FLRelease(_Fax);
	FLRelease(_Url);
	FLRelease(_Email);
	FLRelease(_Other);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_FirstName) [aCoder encodeObject:_FirstName forKey:@"_FirstName"];
	if(_LastName) [aCoder encodeObject:_LastName forKey:@"_LastName"];
	if(_CompanyName) [aCoder encodeObject:_CompanyName forKey:@"_CompanyName"];
	if(_Street) [aCoder encodeObject:_Street forKey:@"_Street"];
	if(_Street2) [aCoder encodeObject:_Street2 forKey:@"_Street2"];
	if(_City) [aCoder encodeObject:_City forKey:@"_City"];
	if(_Zip) [aCoder encodeObject:_Zip forKey:@"_Zip"];
	if(_State) [aCoder encodeObject:_State forKey:@"_State"];
	if(_Country) [aCoder encodeObject:_Country forKey:@"_Country"];
	if(_Phone) [aCoder encodeObject:_Phone forKey:@"_Phone"];
	if(_Phone2) [aCoder encodeObject:_Phone2 forKey:@"_Phone2"];
	if(_Fax) [aCoder encodeObject:_Fax forKey:@"_Fax"];
	if(_Url) [aCoder encodeObject:_Url forKey:@"_Url"];
	if(_Email) [aCoder encodeObject:_Email forKey:@"_Email"];
	if(_Other) [aCoder encodeObject:_Other forKey:@"_Other"];
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
		_FirstName = FLRetain([aDecoder decodeObjectForKey:@"_FirstName"]);
		_LastName = FLRetain([aDecoder decodeObjectForKey:@"_LastName"]);
		_CompanyName = FLRetain([aDecoder decodeObjectForKey:@"_CompanyName"]);
		_Street = FLRetain([aDecoder decodeObjectForKey:@"_Street"]);
		_Street2 = FLRetain([aDecoder decodeObjectForKey:@"_Street2"]);
		_City = FLRetain([aDecoder decodeObjectForKey:@"_City"]);
		_Zip = FLRetain([aDecoder decodeObjectForKey:@"_Zip"]);
		_State = FLRetain([aDecoder decodeObjectForKey:@"_State"]);
		_Country = FLRetain([aDecoder decodeObjectForKey:@"_Country"]);
		_Phone = FLRetain([aDecoder decodeObjectForKey:@"_Phone"]);
		_Phone2 = FLRetain([aDecoder decodeObjectForKey:@"_Phone2"]);
		_Fax = FLRetain([aDecoder decodeObjectForKey:@"_Fax"]);
		_Url = FLRetain([aDecoder decodeObjectForKey:@"_Url"]);
		_Email = FLRetain([aDecoder decodeObjectForKey:@"_Email"]);
		_Other = FLRetain([aDecoder decodeObjectForKey:@"_Other"]);
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
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"FirstName" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"LastName" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"CompanyName" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Street" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Street2" propertyClass:[NSString class] ] forPropertyName:@"Street2"];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"City" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Zip" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"State" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Country" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Phone" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Phone2" propertyClass:[NSString class] ] forPropertyName:@"Phone2"];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Fax" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Url" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Email" propertyClass:[NSString class] ] ];
		[s_describer addPropertyDescriber:[FLPropertyDescription propertyDescription:@"Other" propertyClass:[NSString class] ] ];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FirstName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LastName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CompanyName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Street" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Street2" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"City" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Zip" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"State" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Country" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Phone" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Phone2" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Fax" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Url" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Email" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Other" columnType:FLDatabaseTypeText columnConstraints:nil]];
	});
	return s_table;
}

@end

@implementation FLZenfolioAddress (ValueProperties) 
@end

