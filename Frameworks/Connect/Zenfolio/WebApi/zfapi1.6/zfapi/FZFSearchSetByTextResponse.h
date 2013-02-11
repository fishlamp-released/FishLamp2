//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchSetByTextResponse.h
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
// FLZenfolioSearchSetByTextResponse
// --------------------------------------------------------------------
@interface FLZenfolioSearchSetByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoSetResult* _SearchSetByTextResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoSetResult* SearchSetByTextResult;

+ (NSString*) SearchSetByTextResultKey;

+ (FLZenfolioSearchSetByTextResponse*) searchSetByTextResponse; 

@end

@interface FLZenfolioSearchSetByTextResponse (ValueProperties) 
@end

