//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZfCreateFavoritesSetResponse.h
//	Project: myZenfolio WebAPI
//	Schema: FLZfApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/zf/help/api">help</A> for details.
*/



// --------------------------------------------------------------------
// FLZfCreateFavoritesSetResponse
// --------------------------------------------------------------------
@interface FLZfCreateFavoritesSetResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSNumber* _CreateFavoritesSetResult;
} 


@property (readwrite, retain, nonatomic) NSNumber* CreateFavoritesSetResult;

+ (NSString*) CreateFavoritesSetResultKey;

+ (FLZfCreateFavoritesSetResponse*) createFavoritesSetResponse; 

@end

@interface FLZfCreateFavoritesSetResponse (ValueProperties) 

@property (readwrite, assign, nonatomic) int CreateFavoritesSetResultValue;
@end

