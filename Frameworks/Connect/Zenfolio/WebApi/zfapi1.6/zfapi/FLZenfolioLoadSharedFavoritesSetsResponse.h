//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioLoadSharedFavoritesSetsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioFavoritesSet;

// --------------------------------------------------------------------
// FLZenfolioLoadSharedFavoritesSetsResponse
// --------------------------------------------------------------------
@interface FLZenfolioLoadSharedFavoritesSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadSharedFavoritesSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadSharedFavoritesSetsResult;
// Type: FLZenfolioFavoritesSet*, forKey: FavoritesSet

+ (NSString*) LoadSharedFavoritesSetsResultKey;

+ (FLZenfolioLoadSharedFavoritesSetsResponse*) loadSharedFavoritesSetsResponse; 

@end

@interface FLZenfolioLoadSharedFavoritesSetsResponse (ValueProperties) 
@end

