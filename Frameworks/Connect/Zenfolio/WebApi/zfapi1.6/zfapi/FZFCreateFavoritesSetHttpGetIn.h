//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioCreateFavoritesSetHttpGetIn.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZenfolioCreateFavoritesSetHttpGetIn
// --------------------------------------------------------------------
@interface FLZenfolioCreateFavoritesSetHttpGetIn : NSObject<NSCoding, NSCopying>{ 
@private
	NSString* _name;
	NSString* _photographerLogin;
	NSMutableArray* _photoIds;
} 


@property (readwrite, retain, nonatomic) NSString* name;

@property (readwrite, retain, nonatomic) NSMutableArray* photoIds;
// Type: NSString*, forKey: String

@property (readwrite, retain, nonatomic) NSString* photographerLogin;

+ (NSString*) nameKey;

+ (NSString*) photoIdsKey;

+ (NSString*) photographerLoginKey;

+ (FLZenfolioCreateFavoritesSetHttpGetIn*) createFavoritesSetHttpGetIn; 

@end

@interface FLZenfolioCreateFavoritesSetHttpGetIn (ValueProperties) 
@end

