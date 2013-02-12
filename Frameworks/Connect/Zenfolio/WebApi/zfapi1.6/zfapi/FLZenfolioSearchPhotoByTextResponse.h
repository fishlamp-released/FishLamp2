//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioSearchPhotoByTextResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhotoResult;

// --------------------------------------------------------------------
// FLZenfolioSearchPhotoByTextResponse
// --------------------------------------------------------------------
@interface FLZenfolioSearchPhotoByTextResponse : NSObject<NSCoding, NSCopying>{ 
@private
	FLZenfolioPhotoResult* _SearchPhotoByTextResult;
} 


@property (readwrite, retain, nonatomic) FLZenfolioPhotoResult* SearchPhotoByTextResult;

+ (NSString*) SearchPhotoByTextResultKey;

+ (FLZenfolioSearchPhotoByTextResponse*) searchPhotoByTextResponse; 

@end

@interface FLZenfolioSearchPhotoByTextResponse (ValueProperties) 
@end

