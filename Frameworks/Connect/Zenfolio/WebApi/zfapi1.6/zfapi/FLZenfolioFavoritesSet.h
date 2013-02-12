//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioFavoritesSet.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioFavoritesSet
// --------------------------------------------------------------------
@interface FLZenfolioFavoritesSet : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _Id;
	NSNumber* _ChangeNumber;
	NSString* _Name;
	NSNumber* _IsShared;
	NSDate* _SharedOn;
	NSString* _SharerName;
	NSString* _SharerEmail;
	NSString* _SharerMessage;
} 


@property (readwrite, retain, nonatomic) NSNumber* ChangeNumber;

@property (readwrite, retain, nonatomic) NSNumber* Id;

@property (readwrite, retain, nonatomic) NSNumber* IsShared;

@property (readwrite, retain, nonatomic) NSString* Name;

@property (readwrite, retain, nonatomic) NSDate* SharedOn;

@property (readwrite, retain, nonatomic) NSString* SharerEmail;

@property (readwrite, retain, nonatomic) NSString* SharerMessage;

@property (readwrite, retain, nonatomic) NSString* SharerName;

+ (NSString*) ChangeNumberKey;

+ (NSString*) IdKey;

+ (NSString*) IsSharedKey;

+ (NSString*) NameKey;

+ (NSString*) SharedOnKey;

+ (NSString*) SharerEmailKey;

+ (NSString*) SharerMessageKey;

+ (NSString*) SharerNameKey;

+ (FLZenfolioFavoritesSet*) favoritesSet; 

@end

@interface FLZenfolioFavoritesSet (ValueProperties) 

@property (readwrite, assign, nonatomic) int IdValue;

@property (readwrite, assign, nonatomic) int ChangeNumberValue;

@property (readwrite, assign, nonatomic) BOOL IsSharedValue;
@end

