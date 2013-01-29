//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfAddress.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfAddress
// --------------------------------------------------------------------
@interface FLZfAddress : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _FirstName;
	NSString* _LastName;
	NSString* _CompanyName;
	NSString* _Street;
	NSString* _Street2;
	NSString* _City;
	NSString* _Zip;
	NSString* _State;
	NSString* _Country;
	NSString* _Phone;
	NSString* _Phone2;
	NSString* _Fax;
	NSString* _Url;
	NSString* _Email;
	NSString* _Other;
} 


@property (readwrite, retain, nonatomic) NSString* City;

@property (readwrite, retain, nonatomic) NSString* CompanyName;

@property (readwrite, retain, nonatomic) NSString* Country;

@property (readwrite, retain, nonatomic) NSString* Email;

@property (readwrite, retain, nonatomic) NSString* Fax;

@property (readwrite, retain, nonatomic) NSString* FirstName;

@property (readwrite, retain, nonatomic) NSString* LastName;

@property (readwrite, retain, nonatomic) NSString* Other;

@property (readwrite, retain, nonatomic) NSString* Phone;

@property (readwrite, retain, nonatomic) NSString* Phone2;

@property (readwrite, retain, nonatomic) NSString* State;

@property (readwrite, retain, nonatomic) NSString* Street;

@property (readwrite, retain, nonatomic) NSString* Street2;

@property (readwrite, retain, nonatomic) NSString* Url;

@property (readwrite, retain, nonatomic) NSString* Zip;

+ (NSString*) CityKey;

+ (NSString*) CompanyNameKey;

+ (NSString*) CountryKey;

+ (NSString*) EmailKey;

+ (NSString*) FaxKey;

+ (NSString*) FirstNameKey;

+ (NSString*) LastNameKey;

+ (NSString*) OtherKey;

+ (NSString*) Phone2Key;

+ (NSString*) PhoneKey;

+ (NSString*) StateKey;

+ (NSString*) Street2Key;

+ (NSString*) StreetKey;

+ (NSString*) UrlKey;

+ (NSString*) ZipKey;

+ (FLZfAddress*) address; 

@end

@interface FLZfAddress (ValueProperties) 
@end

