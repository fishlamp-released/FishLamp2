//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	ZFLoadSharedFavoritesSetsResponse.h
//	Project: myZenfolio WebAPI
//	Schema: ZFApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/


@class ZFFavoritesSet;

// --------------------------------------------------------------------
// ZFLoadSharedFavoritesSetsResponse
// --------------------------------------------------------------------
@interface ZFLoadSharedFavoritesSetsResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _LoadSharedFavoritesSetsResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* LoadSharedFavoritesSetsResult;
// Type: ZFFavoritesSet*, forKey: FavoritesSet

+ (NSString*) LoadSharedFavoritesSetsResultKey;

+ (ZFLoadSharedFavoritesSetsResponse*) loadSharedFavoritesSetsResponse; 

@end

@interface ZFLoadSharedFavoritesSetsResponse (ValueProperties) 
@end

