//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchSetByCategoryResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoSetResult;

// --------------------------------------------------------------------
// FLZenfolioSearchSetByCategoryResponse
// --------------------------------------------------------------------
@interface FLZenfolioSearchSetByCategoryResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoSetResult* _SearchSetByCategoryResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoSetResult* SearchSetByCategoryResult;

+ (NSString*) SearchSetByCategoryResultKey;

+ (FLZenfolioSearchSetByCategoryResponse*) searchSetByCategoryResponse; 

@end

@interface FLZenfolioSearchSetByCategoryResponse (ValueProperties) 
@end

