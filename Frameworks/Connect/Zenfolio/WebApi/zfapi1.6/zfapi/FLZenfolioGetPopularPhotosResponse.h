//	This file was generated at 3/10/12 1:14 PM by PackMule. DO NOT MODIFY!!
//
//	FLZenfolioGetPopularPhotosResponse.h
//	Project: FishLamp WebAPI
//	Schema: FLZenfolioApi1_6
//
//	Copywrite 2011 GreenTongue Software, LLC. All rights reserved.
//

/*
This is Zenfolio Web API. See <A href="/Zenfolio/help/api">help</A> for details.
*/


@class FLZenfolioPhoto;

// --------------------------------------------------------------------
// FLZenfolioGetPopularPhotosResponse
// --------------------------------------------------------------------
@interface FLZenfolioGetPopularPhotosResponse : NSObject<NSCoding, NSCopying>{ 
@private
	NSMutableArray* _GetPopularPhotosResult;
} 


@property (readwrite, retain, nonatomic) NSMutableArray* GetPopularPhotosResult;
// Type: FLZenfolioPhoto*, forKey: Photo

+ (NSString*) GetPopularPhotosResultKey;

+ (FLZenfolioGetPopularPhotosResponse*) getPopularPhotosResponse; 

@end

@interface FLZenfolioGetPopularPhotosResponse (ValueProperties) 
@end

