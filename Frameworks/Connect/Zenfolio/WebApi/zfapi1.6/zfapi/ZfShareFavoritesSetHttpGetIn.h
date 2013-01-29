//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFShareFavoritesSetHttpGetIn.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// ZFShareFavoritesSetHttpGetIn
// --------------------------------------------------------------------
@interface ZFShareFavoritesSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
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

+ (ZFShareFavoritesSetHttpGetIn*) shareFavoritesSetHttpGetIn; 

@end

@interface ZFShareFavoritesSetHttpGetIn (ValueProperties) 
@end

