//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioUser.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioFile;
@class FLZenfolioAddress;
@class FLZenfolioGroup;
@class FLZenfolioPhotoSet;

// --------------------------------------------------------------------
// FLZenfolioUser
// --------------------------------------------------------------------
@interface FLZenfolioUser : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _LoginName;
	NSString* _DisplayName;
	NSString* _FirstName;
	NSString* _LastName;
	NSString* _PrimaryEmail;
	FLZenfolioFile* _BioPhoto;
	NSString* _Bio;
	NSNumber* _Views;
	NSNumber* _GalleryCount;
	NSNumber* _CollectionCount;
	NSNumber* _PhotoCount;
	NSNumber* _PhotoBytes;
	NSDate* _UserSince;
	NSDate* _LastUpdated;
	FLZenfolioAddress* _PublicAddress;
	FLZenfolioAddress* _PersonalAddress;
	NSMutableArray* _RecentPhotoSets;
	NSMutableArray* _FeaturedPhotoSets;
	FLZenfolioGroup* _RootGroup;
	NSString* _ReferralCode;
	NSDate* _ExpiresOn;
	NSNumber* _Balance;
	NSString* _DomainName;
	NSNumber* _StorageQuota;
	NSNumber* _PhotoBytesQuota;
	NSNumber* _VideoBytesQuota;
	NSNumber* _VideoDurationQuota;
	NSNumber* _HierarchyCn;
} 


@property (readwrite, retain, nonatomic) NSNumber* Balance;

@property (readwrite, retain, nonatomic) NSString* Bio;

@property (readwrite, retain, nonatomic) FLZenfolioFile* BioPhoto;

@property (readwrite, retain, nonatomic) NSNumber* CollectionCount;

@property (readwrite, retain, nonatomic) NSString* DisplayName;

@property (readwrite, retain, nonatomic) NSString* DomainName;

@property (readwrite, retain, nonatomic) NSDate* ExpiresOn;

@property (readwrite, retain, nonatomic) NSMutableArray* FeaturedPhotoSets;
// Type: FLZenfolioPhotoSet*, forKey: PhotoSet

@property (readwrite, retain, nonatomic) NSString* FirstName;

@property (readwrite, retain, nonatomic) NSNumber* GalleryCount;

@property (readwrite, retain, nonatomic) NSNumber* HierarchyCn;

@property (readwrite, retain, nonatomic) NSString* LastName;

@property (readwrite, retain, nonatomic) NSDate* LastUpdated;

@property (readwrite, retain, nonatomic) NSString* LoginName;

@property (readwrite, retain, nonatomic) FLZenfolioAddress* PersonalAddress;

@property (readwrite, retain, nonatomic) NSNumber* PhotoBytes;

@property (readwrite, retain, nonatomic) NSNumber* PhotoBytesQuota;

@property (readwrite, retain, nonatomic) NSNumber* PhotoCount;

@property (readwrite, retain, nonatomic) NSString* PrimaryEmail;

@property (readwrite, retain, nonatomic) FLZenfolioAddress* PublicAddress;

@property (readwrite, retain, nonatomic) NSMutableArray* RecentPhotoSets;
// Type: FLZenfolioPhotoSet*, forKey: PhotoSet

@property (readwrite, retain, nonatomic) NSString* ReferralCode;

@property (readwrite, retain, nonatomic) FLZenfolioGroup* RootGroup;

@property (readwrite, retain, nonatomic) NSNumber* StorageQuota;

@property (readwrite, retain, nonatomic) NSDate* UserSince;

@property (readwrite, retain, nonatomic) NSNumber* VideoBytesQuota;

@property (readwrite, retain, nonatomic) NSNumber* VideoDurationQuota;

@property (readwrite, retain, nonatomic) NSNumber* Views;

+ (NSString*) BalanceKey;

+ (NSString*) BioKey;

+ (NSString*) BioPhotoKey;

+ (NSString*) CollectionCountKey;

+ (NSString*) DisplayNameKey;

+ (NSString*) DomainNameKey;

+ (NSString*) ExpiresOnKey;

+ (NSString*) FeaturedPhotoSetsKey;

+ (NSString*) FirstNameKey;

+ (NSString*) GalleryCountKey;

+ (NSString*) HierarchyCnKey;

+ (NSString*) LastNameKey;

+ (NSString*) LastUpdatedKey;

+ (NSString*) LoginNameKey;

+ (NSString*) PersonalAddressKey;

+ (NSString*) PhotoBytesKey;

+ (NSString*) PhotoBytesQuotaKey;

+ (NSString*) PhotoCountKey;

+ (NSString*) PrimaryEmailKey;

+ (NSString*) PublicAddressKey;

+ (NSString*) RecentPhotoSetsKey;

+ (NSString*) ReferralCodeKey;

+ (NSString*) RootGroupKey;

+ (NSString*) StorageQuotaKey;

+ (NSString*) UserSinceKey;

+ (NSString*) VideoBytesQuotaKey;

+ (NSString*) VideoDurationQuotaKey;

+ (NSString*) ViewsKey;

+ (FLZenfolioUser*) user; 

@end

@interface FLZenfolioUser (ValueProperties) 

@property (readwrite, assign, nonatomic) int ViewsValue;

@property (readwrite, assign, nonatomic) int GalleryCountValue;

@property (readwrite, assign, nonatomic) int CollectionCountValue;

@property (readwrite, assign, nonatomic) int PhotoCountValue;

@property (readwrite, assign, nonatomic) long PhotoBytesValue;

@property (readwrite, assign, nonatomic) double BalanceValue;

@property (readwrite, assign, nonatomic) long StorageQuotaValue;

@property (readwrite, assign, nonatomic) long PhotoBytesQuotaValue;

@property (readwrite, assign, nonatomic) long VideoBytesQuotaValue;

@property (readwrite, assign, nonatomic) int VideoDurationQuotaValue;

@property (readwrite, assign, nonatomic) int HierarchyCnValue;
@end

