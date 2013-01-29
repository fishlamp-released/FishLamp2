//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfLoadSharedFavoritesSetsResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class FLZfFavoritesSet;

// --------------------------------------------------------------------
// FLZfLoadSharedFavoritesSetsResponse
// --------------------------------------------------------------------
@interface FLZfLoadSharedFavoritesSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadSharedFavoritesSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadSharedFavoritesSetsResult;
// Type: FLZfFavoritesSet*, forKey: FavoritesSet

+ (NSString*) LoadSharedFavoritesSetsResultKey;

+ (FLZfLoadSharedFavoritesSetsResponse*) loadSharedFavoritesSetsResponse; 

@end

@interface FLZfLoadSharedFavoritesSetsResponse (ValueProperties) 
@end

