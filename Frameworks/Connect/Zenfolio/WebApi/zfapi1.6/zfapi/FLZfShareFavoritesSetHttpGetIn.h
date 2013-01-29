//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfShareFavoritesSetHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfShareFavoritesSetHttpGetIn
// --------------------------------------------------------------------
@interface FLZfShareFavoritesSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _favoritesSetId;
	NSString* _favoritesSetName;
	NSString* _sharerName;
	NSString* _sharerEmail;
	NSString* _sharerMessage;
} 


@property (readwrite, retain, nonatomic) NSString* favoritesSetId;

@property (readwrite, retain, nonatomic) NSString* favoritesSetName;

@property (readwrite, retain, nonatomic) NSString* sharerEmail;

@property (readwrite, retain, nonatomic) NSString* sharerMessage;

@property (readwrite, retain, nonatomic) NSString* sharerName;

+ (NSString*) favoritesSetIdKey;

+ (NSString*) favoritesSetNameKey;

+ (NSString*) sharerEmailKey;

+ (NSString*) sharerMessageKey;

+ (NSString*) sharerNameKey;

+ (FLZfShareFavoritesSetHttpGetIn*) shareFavoritesSetHttpGetIn; 

@end

@interface FLZfShareFavoritesSetHttpGetIn (ValueProperties) 
@end

