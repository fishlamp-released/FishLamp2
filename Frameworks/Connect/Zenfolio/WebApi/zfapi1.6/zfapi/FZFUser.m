//	This file was generated at 3/22/12 9:41 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUser.m
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

#import "FLZenfolioUser.h"
#import "FLZenfolioFile.h"
#import "FLZenfolioAddress.h"
#import "FLZenfolioGroup.h"
#import "FLObjectDescriber.h"
#import "FLObjectInflator.h"
#import "FLDatabaseTable.h"
#import "FLZenfolioPhotoSet.h"

@implementation FLZenfolioUser


@synthesize Balance = _Balance;
@synthesize Bio = _Bio;
@synthesize BioPhoto = _BioPhoto;
@synthesize CollectionCount = _CollectionCount;
@synthesize DisplayName = _DisplayName;
@synthesize DomainName = _DomainName;
@synthesize ExpiresOn = _ExpiresOn;
@synthesize FeaturedPhotoSets = _FeaturedPhotoSets;
@synthesize FirstName = _FirstName;
@synthesize GalleryCount = _GalleryCount;
@synthesize HierarchyCn = _HierarchyCn;
@synthesize LastName = _LastName;
@synthesize LastUpdated = _LastUpdated;
@synthesize LoginName = _LoginName;
@synthesize PersonalAddress = _PersonalAddress;
@synthesize PhotoBytes = _PhotoBytes;
@synthesize PhotoBytesQuota = _PhotoBytesQuota;
@synthesize PhotoCount = _PhotoCount;
@synthesize PrimaryEmail = _PrimaryEmail;
@synthesize PublicAddress = _PublicAddress;
@synthesize RecentPhotoSets = _RecentPhotoSets;
@synthesize ReferralCode = _ReferralCode;
@synthesize RootGroup = _RootGroup;
@synthesize StorageQuota = _StorageQuota;
@synthesize UserSince = _UserSince;
@synthesize VideoBytesQuota = _VideoBytesQuota;
@synthesize VideoDurationQuota = _VideoDurationQuota;
@synthesize Views = _Views;

+ (NSString*) BalanceKey
{
	return @"Balance";
}

+ (NSString*) BioKey
{
	return @"Bio";
}

+ (NSString*) BioPhotoKey
{
	return @"BioPhoto";
}

+ (NSString*) CollectionCountKey
{
	return @"CollectionCount";
}

+ (NSString*) DisplayNameKey
{
	return @"DisplayName";
}

+ (NSString*) DomainNameKey
{
	return @"DomainName";
}

+ (NSString*) ExpiresOnKey
{
	return @"ExpiresOn";
}

+ (NSString*) FeaturedPhotoSetsKey
{
	return @"FeaturedPhotoSets";
}

+ (NSString*) FirstNameKey
{
	return @"FirstName";
}

+ (NSString*) GalleryCountKey
{
	return @"GalleryCount";
}

+ (NSString*) HierarchyCnKey
{
	return @"HierarchyCn";
}

+ (NSString*) LastNameKey
{
	return @"LastName";
}

+ (NSString*) LastUpdatedKey
{
	return @"LastUpdated";
}

+ (NSString*) LoginNameKey
{
	return @"LoginName";
}

+ (NSString*) PersonalAddressKey
{
	return @"PersonalAddress";
}

+ (NSString*) PhotoBytesKey
{
	return @"PhotoBytes";
}

+ (NSString*) PhotoBytesQuotaKey
{
	return @"PhotoBytesQuota";
}

+ (NSString*) PhotoCountKey
{
	return @"PhotoCount";
}

+ (NSString*) PrimaryEmailKey
{
	return @"PrimaryEmail";
}

+ (NSString*) PublicAddressKey
{
	return @"PublicAddress";
}

+ (NSString*) RecentPhotoSetsKey
{
	return @"RecentPhotoSets";
}

+ (NSString*) ReferralCodeKey
{
	return @"ReferralCode";
}

+ (NSString*) RootGroupKey
{
	return @"RootGroup";
}

+ (NSString*) StorageQuotaKey
{
	return @"StorageQuota";
}

+ (NSString*) UserSinceKey
{
	return @"UserSince";
}

+ (NSString*) VideoBytesQuotaKey
{
	return @"VideoBytesQuota";
}

+ (NSString*) VideoDurationQuotaKey
{
	return @"VideoDurationQuota";
}

+ (NSString*) ViewsKey
{
	return @"Views";
}

- (void) copySelfTo:(id) object
{
	[super copySelfTo:object];
	((FLZenfolioUser*)object).LastUpdated = FLCopyOrRetainObject(_LastUpdated);
	((FLZenfolioUser*)object).Balance = FLCopyOrRetainObject(_Balance);
	((FLZenfolioUser*)object).PhotoBytesQuota = FLCopyOrRetainObject(_PhotoBytesQuota);
	((FLZenfolioUser*)object).ExpiresOn = FLCopyOrRetainObject(_ExpiresOn);
	((FLZenfolioUser*)object).PrimaryEmail = FLCopyOrRetainObject(_PrimaryEmail);
	((FLZenfolioUser*)object).Views = FLCopyOrRetainObject(_Views);
	((FLZenfolioUser*)object).PublicAddress = FLCopyOrRetainObject(_PublicAddress);
	((FLZenfolioUser*)object).LastName = FLCopyOrRetainObject(_LastName);
	((FLZenfolioUser*)object).DomainName = FLCopyOrRetainObject(_DomainName);
	((FLZenfolioUser*)object).Bio = FLCopyOrRetainObject(_Bio);
	((FLZenfolioUser*)object).CollectionCount = FLCopyOrRetainObject(_CollectionCount);
	((FLZenfolioUser*)object).FirstName = FLCopyOrRetainObject(_FirstName);
	((FLZenfolioUser*)object).FeaturedPhotoSets = FLCopyOrRetainObject(_FeaturedPhotoSets);
	((FLZenfolioUser*)object).LoginName = FLCopyOrRetainObject(_LoginName);
	((FLZenfolioUser*)object).VideoBytesQuota = FLCopyOrRetainObject(_VideoBytesQuota);
	((FLZenfolioUser*)object).StorageQuota = FLCopyOrRetainObject(_StorageQuota);
	((FLZenfolioUser*)object).VideoDurationQuota = FLCopyOrRetainObject(_VideoDurationQuota);
	((FLZenfolioUser*)object).RecentPhotoSets = FLCopyOrRetainObject(_RecentPhotoSets);
	((FLZenfolioUser*)object).HierarchyCn = FLCopyOrRetainObject(_HierarchyCn);
	((FLZenfolioUser*)object).GalleryCount = FLCopyOrRetainObject(_GalleryCount);
	((FLZenfolioUser*)object).ReferralCode = FLCopyOrRetainObject(_ReferralCode);
	((FLZenfolioUser*)object).RootGroup = FLCopyOrRetainObject(_RootGroup);
	((FLZenfolioUser*)object).BioPhoto = FLCopyOrRetainObject(_BioPhoto);
	((FLZenfolioUser*)object).PersonalAddress = FLCopyOrRetainObject(_PersonalAddress);
	((FLZenfolioUser*)object).UserSince = FLCopyOrRetainObject(_UserSince);
	((FLZenfolioUser*)object).DisplayName = FLCopyOrRetainObject(_DisplayName);
	((FLZenfolioUser*)object).PhotoCount = FLCopyOrRetainObject(_PhotoCount);
	((FLZenfolioUser*)object).PhotoBytes = FLCopyOrRetainObject(_PhotoBytes);
}

- (id) copyWithZone:(NSZone*) zone
{
	id outObject = [[[self class] alloc] init];
	[self copySelfTo:outObject];
	return outObject;
}

- (void) dealloc
{
	FLRelease(_LoginName);
	FLRelease(_DisplayName);
	FLRelease(_FirstName);
	FLRelease(_LastName);
	FLRelease(_PrimaryEmail);
	FLRelease(_BioPhoto);
	FLRelease(_Bio);
	FLRelease(_Views);
	FLRelease(_GalleryCount);
	FLRelease(_CollectionCount);
	FLRelease(_PhotoCount);
	FLRelease(_PhotoBytes);
	FLRelease(_UserSince);
	FLRelease(_LastUpdated);
	FLRelease(_PublicAddress);
	FLRelease(_PersonalAddress);
	FLRelease(_RecentPhotoSets);
	FLRelease(_FeaturedPhotoSets);
	FLRelease(_RootGroup);
	FLRelease(_ReferralCode);
	FLRelease(_ExpiresOn);
	FLRelease(_Balance);
	FLRelease(_DomainName);
	FLRelease(_StorageQuota);
	FLRelease(_PhotoBytesQuota);
	FLRelease(_VideoBytesQuota);
	FLRelease(_VideoDurationQuota);
	FLRelease(_HierarchyCn);
	FLSuperDealloc();
}

- (void) encodeWithCoder:(NSCoder*) aCoder
{
	if(_LoginName) [aCoder encodeObject:_LoginName forKey:@"_LoginName"];
	if(_DisplayName) [aCoder encodeObject:_DisplayName forKey:@"_DisplayName"];
	if(_FirstName) [aCoder encodeObject:_FirstName forKey:@"_FirstName"];
	if(_LastName) [aCoder encodeObject:_LastName forKey:@"_LastName"];
	if(_PrimaryEmail) [aCoder encodeObject:_PrimaryEmail forKey:@"_PrimaryEmail"];
	if(_BioPhoto) [aCoder encodeObject:_BioPhoto forKey:@"_BioPhoto"];
	if(_Bio) [aCoder encodeObject:_Bio forKey:@"_Bio"];
	if(_Views) [aCoder encodeObject:_Views forKey:@"_Views"];
	if(_GalleryCount) [aCoder encodeObject:_GalleryCount forKey:@"_GalleryCount"];
	if(_CollectionCount) [aCoder encodeObject:_CollectionCount forKey:@"_CollectionCount"];
	if(_PhotoCount) [aCoder encodeObject:_PhotoCount forKey:@"_PhotoCount"];
	if(_PhotoBytes) [aCoder encodeObject:_PhotoBytes forKey:@"_PhotoBytes"];
	if(_UserSince) [aCoder encodeObject:_UserSince forKey:@"_UserSince"];
	if(_LastUpdated) [aCoder encodeObject:_LastUpdated forKey:@"_LastUpdated"];
	if(_PublicAddress) [aCoder encodeObject:_PublicAddress forKey:@"_PublicAddress"];
	if(_PersonalAddress) [aCoder encodeObject:_PersonalAddress forKey:@"_PersonalAddress"];
	if(_RecentPhotoSets) [aCoder encodeObject:_RecentPhotoSets forKey:@"_RecentPhotoSets"];
	if(_FeaturedPhotoSets) [aCoder encodeObject:_FeaturedPhotoSets forKey:@"_FeaturedPhotoSets"];
	if(_RootGroup) [aCoder encodeObject:_RootGroup forKey:@"_RootGroup"];
	if(_ReferralCode) [aCoder encodeObject:_ReferralCode forKey:@"_ReferralCode"];
	if(_ExpiresOn) [aCoder encodeObject:_ExpiresOn forKey:@"_ExpiresOn"];
	if(_Balance) [aCoder encodeObject:_Balance forKey:@"_Balance"];
	if(_DomainName) [aCoder encodeObject:_DomainName forKey:@"_DomainName"];
	if(_StorageQuota) [aCoder encodeObject:_StorageQuota forKey:@"_StorageQuota"];
	if(_PhotoBytesQuota) [aCoder encodeObject:_PhotoBytesQuota forKey:@"_PhotoBytesQuota"];
	if(_VideoBytesQuota) [aCoder encodeObject:_VideoBytesQuota forKey:@"_VideoBytesQuota"];
	if(_VideoDurationQuota) [aCoder encodeObject:_VideoDurationQuota forKey:@"_VideoDurationQuota"];
	if(_HierarchyCn) [aCoder encodeObject:_HierarchyCn forKey:@"_HierarchyCn"];
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
		_LoginName = FLRetain([aDecoder decodeObjectForKey:@"_LoginName"]);
		_DisplayName = FLRetain([aDecoder decodeObjectForKey:@"_DisplayName"]);
		_FirstName = FLRetain([aDecoder decodeObjectForKey:@"_FirstName"]);
		_LastName = FLRetain([aDecoder decodeObjectForKey:@"_LastName"]);
		_PrimaryEmail = FLRetain([aDecoder decodeObjectForKey:@"_PrimaryEmail"]);
		_BioPhoto = FLRetain([aDecoder decodeObjectForKey:@"_BioPhoto"]);
		_Bio = FLRetain([aDecoder decodeObjectForKey:@"_Bio"]);
		_Views = FLRetain([aDecoder decodeObjectForKey:@"_Views"]);
		_GalleryCount = FLRetain([aDecoder decodeObjectForKey:@"_GalleryCount"]);
		_CollectionCount = FLRetain([aDecoder decodeObjectForKey:@"_CollectionCount"]);
		_PhotoCount = FLRetain([aDecoder decodeObjectForKey:@"_PhotoCount"]);
		_PhotoBytes = FLRetain([aDecoder decodeObjectForKey:@"_PhotoBytes"]);
		_UserSince = FLRetain([aDecoder decodeObjectForKey:@"_UserSince"]);
		_LastUpdated = FLRetain([aDecoder decodeObjectForKey:@"_LastUpdated"]);
		_PublicAddress = FLRetain([aDecoder decodeObjectForKey:@"_PublicAddress"]);
		_PersonalAddress = FLRetain([aDecoder decodeObjectForKey:@"_PersonalAddress"]);
		_RecentPhotoSets = [[aDecoder decodeObjectForKey:@"_RecentPhotoSets"] mutableCopy];
		_FeaturedPhotoSets = [[aDecoder decodeObjectForKey:@"_FeaturedPhotoSets"] mutableCopy];
		_RootGroup = FLRetain([aDecoder decodeObjectForKey:@"_RootGroup"]);
		_ReferralCode = FLRetain([aDecoder decodeObjectForKey:@"_ReferralCode"]);
		_ExpiresOn = FLRetain([aDecoder decodeObjectForKey:@"_ExpiresOn"]);
		_Balance = FLRetain([aDecoder decodeObjectForKey:@"_Balance"]);
		_DomainName = FLRetain([aDecoder decodeObjectForKey:@"_DomainName"]);
		_StorageQuota = FLRetain([aDecoder decodeObjectForKey:@"_StorageQuota"]);
		_PhotoBytesQuota = FLRetain([aDecoder decodeObjectForKey:@"_PhotoBytesQuota"]);
		_VideoBytesQuota = FLRetain([aDecoder decodeObjectForKey:@"_VideoBytesQuota"]);
		_VideoDurationQuota = FLRetain([aDecoder decodeObjectForKey:@"_VideoDurationQuota"]);
		_HierarchyCn = FLRetain([aDecoder decodeObjectForKey:@"_HierarchyCn"]);
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
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"LoginName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"LoginName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"DisplayName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"DisplayName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"FirstName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"FirstName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"LastName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"LastName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PrimaryEmail" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"PrimaryEmail"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"BioPhoto" propertyClass:[FLZenfolioFile class] propertyType:FLDataTypeObject] forPropertyName:@"BioPhoto"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Bio" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"Bio"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Views" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"Views"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"GalleryCount" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"GalleryCount"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"CollectionCount" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"CollectionCount"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PhotoCount" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"PhotoCount"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PhotoBytes" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"PhotoBytes"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"UserSince" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"UserSince"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"LastUpdated" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"LastUpdated"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PublicAddress" propertyClass:[FLZenfolioAddress class] propertyType:FLDataTypeObject] forPropertyName:@"PublicAddress"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PersonalAddress" propertyClass:[FLZenfolioAddress class] propertyType:FLDataTypeObject] forPropertyName:@"PersonalAddress"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"RecentPhotoSets" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"PhotoSet" propertyClass:[FLZenfolioPhotoSet class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"RecentPhotoSets"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"FeaturedPhotoSets" propertyClass:[NSMutableArray class] propertyType:FLDataTypeObject arrayTypes:[NSArray arrayWithObjects:[FLPropertyDescription propertyDescription:@"PhotoSet" propertyClass:[FLZenfolioPhotoSet class] propertyType:FLDataTypeObject arrayTypes:nil], nil] isUnboundedArray:NO] forPropertyName:@"FeaturedPhotoSets"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"RootGroup" propertyClass:[FLZenfolioGroup class] propertyType:FLDataTypeObject] forPropertyName:@"RootGroup"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"ReferralCode" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"ReferralCode"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"ExpiresOn" propertyClass:[NSDate class] propertyType:FLDataTypeDate] forPropertyName:@"ExpiresOn"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"Balance" propertyClass:[NSNumber class] propertyType:FLDataTypeDouble] forPropertyName:@"Balance"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"DomainName" propertyClass:[NSString class] propertyType:FLDataTypeString] forPropertyName:@"DomainName"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"StorageQuota" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"StorageQuota"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"PhotoBytesQuota" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"PhotoBytesQuota"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"VideoBytesQuota" propertyClass:[NSNumber class] propertyType:FLDataTypeLong] forPropertyName:@"VideoBytesQuota"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"VideoDurationQuota" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"VideoDurationQuota"];
		[s_describer setPropertyDescriber:[FLPropertyDescription propertyDescription:@"HierarchyCn" propertyClass:[NSNumber class] propertyType:FLDataTypeInteger] forPropertyName:@"HierarchyCn"];
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
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LoginName" columnType:FLDatabaseTypeText columnConstraints:[NSArray arrayWithObject:[FLDatabaseColumn primaryKeyConstraint]]]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"DisplayName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FirstName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LastName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PrimaryEmail" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"BioPhoto" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Bio" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Views" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"GalleryCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"CollectionCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoCount" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoBytes" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"UserSince" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"LastUpdated" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PublicAddress" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PersonalAddress" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"RecentPhotoSets" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"FeaturedPhotoSets" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"RootGroup" columnType:FLDatabaseTypeObject columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ReferralCode" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"ExpiresOn" columnType:FLDatabaseTypeDate columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"Balance" columnType:FLDatabaseTypeFloat columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"DomainName" columnType:FLDatabaseTypeText columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"StorageQuota" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"PhotoBytesQuota" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"VideoBytesQuota" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"VideoDurationQuota" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
		[s_table addColumn:[FLDatabaseColumn databaseColumnWithName:@"HierarchyCn" columnType:FLDatabaseTypeInteger columnConstraints:nil]];
	});
	return s_table;
}

+ (FLZenfolioUser*) user
{
	return FLAutorelease([[FLZenfolioUser alloc] init]);
}

@end

@implementation FLZenfolioUser (ValueProperties) 

- (int) ViewsValue
{
	return [self.Views intValue];
}

- (void) setViewsValue:(int) value
{
	self.Views = [NSNumber numberWithInt:value];
}

- (int) GalleryCountValue
{
	return [self.GalleryCount intValue];
}

- (void) setGalleryCountValue:(int) value
{
	self.GalleryCount = [NSNumber numberWithInt:value];
}

- (int) CollectionCountValue
{
	return [self.CollectionCount intValue];
}

- (void) setCollectionCountValue:(int) value
{
	self.CollectionCount = [NSNumber numberWithInt:value];
}

- (int) PhotoCountValue
{
	return [self.PhotoCount intValue];
}

- (void) setPhotoCountValue:(int) value
{
	self.PhotoCount = [NSNumber numberWithInt:value];
}

- (long) PhotoBytesValue
{
	return [self.PhotoBytes longValue];
}

- (void) setPhotoBytesValue:(long) value
{
	self.PhotoBytes = [NSNumber numberWithLong:value];
}

- (double) BalanceValue
{
	return [self.Balance doubleValue];
}

- (void) setBalanceValue:(double) value
{
	self.Balance = [NSNumber numberWithDouble:value];
}

- (long) StorageQuotaValue
{
	return [self.StorageQuota longValue];
}

- (void) setStorageQuotaValue:(long) value
{
	self.StorageQuota = [NSNumber numberWithLong:value];
}

- (long) PhotoBytesQuotaValue
{
	return [self.PhotoBytesQuota longValue];
}

- (void) setPhotoBytesQuotaValue:(long) value
{
	self.PhotoBytesQuota = [NSNumber numberWithLong:value];
}

- (long) VideoBytesQuotaValue
{
	return [self.VideoBytesQuota longValue];
}

- (void) setVideoBytesQuotaValue:(long) value
{
	self.VideoBytesQuota = [NSNumber numberWithLong:value];
}

- (int) VideoDurationQuotaValue
{
	return [self.VideoDurationQuota intValue];
}

- (void) setVideoDurationQuotaValue:(int) value
{
	self.VideoDurationQuota = [NSNumber numberWithInt:value];
}

- (int) HierarchyCnValue
{
	return [self.HierarchyCn intValue];
}

- (void) setHierarchyCnValue:(int) value
{
	self.HierarchyCn = [NSNumber numberWithInt:value];
}
@end

